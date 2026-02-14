import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

// CRITICAL: Initialize admin ONCE at the top
if (!admin.apps.length) {
  admin.initializeApp();
}

const db = admin.firestore();

interface AssignRequest {
  reAssignAll?: boolean;
}

export const assignSupervisors = functions.https.onCall(
  async (request: functions.https.CallableRequest<AssignRequest>) => {
    const { data, auth } = request;

    // 1. Auth check
    if (!auth) {
      throw new functions.https.HttpsError("unauthenticated", "Must be logged in as admin");
    }

    const callerUid = auth.uid;
    
    try {
      const callerDoc = await db.collection("users").doc(callerUid).get();

      if (!callerDoc.exists || callerDoc.data()?.role !== "admin") {
        throw new functions.https.HttpsError("permission-denied", "Only admins can run supervisor assignment");
      }

      console.log(`[ASSIGN] Admin ${callerUid} started assignment at ${new Date().toISOString()}`);

      const { reAssignAll = false } = data || {};

      // Optional: Re-assign mode
      if (reAssignAll) {
        console.warn(`[ASSIGN] Re-assign ALL mode enabled - unassigning all students`);
        const allStudentsSnap = await db.collection("students").get();
        const batch = db.batch();
        allStudentsSnap.docs.forEach((doc) => {
          batch.update(doc.ref, { currentSupervisorId: null });
        });
        await batch.commit();
        console.log(`[ASSIGN] Unassigned ${allStudentsSnap.size} students`);
      }

      // 2. Fetch unassigned students - TRY MULTIPLE APPROACHES
      console.log(`[ASSIGN] Querying students collection...`);
      
      // First, try to get ALL students to see if we can access the collection at all
      const allStudentsTest = await db.collection("students").limit(1).get();
      console.log(`[ASSIGN] Test query returned ${allStudentsTest.size} documents (checking access)`);
      
      if (allStudentsTest.empty) {
        console.error(`[ASSIGN] ERROR: Cannot access students collection at all!`);
      }

      // Now try the actual query
      const studentsSnap = await db
        .collection("students")
        .where("currentSupervisorId", "==", null)
        .get();

      console.log(`[ASSIGN] Found ${studentsSnap.size} unassigned students with null currentSupervisorId`);

      // FALLBACK: If query returns 0, try getting all students and filter manually
      if (studentsSnap.size === 0) {
        console.log(`[ASSIGN] No results from query, trying to fetch all students...`);
        const allStudentsSnap = await db.collection("students").get();
        console.log(`[ASSIGN] Total students in collection: ${allStudentsSnap.size}`);
        
        const unassignedDocs = allStudentsSnap.docs.filter(doc => {
          const data = doc.data();
          const supervisorId = data.currentSupervisorId;
          const isUnassigned = supervisorId === null || supervisorId === undefined;
          
          if (isUnassigned) {
            console.log(`[ASSIGN] Student ${doc.id} is unassigned (currentSupervisorId: ${supervisorId})`);
          }
          
          return isUnassigned;
        });
        
        console.log(`[ASSIGN] Manually filtered: ${unassignedDocs.length} unassigned students`);
        
        if (unassignedDocs.length === 0) {
          return {
            success: true,
            assignedCount: 0,
            message: "No unassigned students found (checked all students manually)",
          };
        }
        
        // Use the manually filtered list
        const students = unassignedDocs.map((doc) => ({
          id: doc.id,
          program: doc.data().program as string || "Unknown",
          internshipStatus: doc.data().internshipStatus as string || "unknown",
          fullName: doc.data().fullName as string || "Unknown Student",
          ...doc.data(),
        }));
        
        return await processAssignments(students, callerUid, db);
      }

      // Normal path: query worked
      const students = studentsSnap.docs.map((doc) => ({
        id: doc.id,
        program: doc.data().program as string || "Unknown",
        internshipStatus: doc.data().internshipStatus as string || "unknown",
        fullName: doc.data().fullName as string || "Unknown Student",
        ...doc.data(),
      }));

      return await processAssignments(students, callerUid, db);
      
    } catch (error: any) {
      console.error(`[ASSIGN] Fatal error:`, error);
      throw new functions.https.HttpsError("internal", `Assignment failed: ${error.message}`);
    }
  }
);

// Separate function to handle the actual assignment logic
async function processAssignments(
  students: any[],
  callerUid: string,
  db: admin.firestore.Firestore
) {
  console.log(`[ASSIGN] Processing ${students.length} students for assignment`);

  // 3. Fetch all supervisors
  const supervisorsSnap = await db.collection("supervisorProfiles").get();
  console.log(`[ASSIGN] Fetched ${supervisorsSnap.size} total supervisors`);

  let supervisors = supervisorsSnap.docs.map((doc) => ({
    id: doc.id,
    fullName: doc.data().fullName as string || "Unnamed Supervisor",
    currentLoad: (doc.data().currentLoad as number) || 0,
    maxStudents: (doc.data().maxStudents as number) || 12,
    specialties: (doc.data().programSpecialties as string[]) || [],
    department: doc.data().department as string || "",
    isAvailable: doc.data().isAvailable as boolean ?? true,
  }));

  console.log(`[ASSIGN] All supervisors:`, supervisors.map(s => ({
    id: s.id,
    name: s.fullName,
    load: s.currentLoad,
    max: s.maxStudents,
    available: s.isAvailable,
  })));

  supervisors = supervisors.filter((sup) => {
    const hasCapacity = sup.currentLoad < sup.maxStudents;
    const isAvailable = sup.isAvailable;
    return isAvailable && hasCapacity;
  });

  console.log(`[ASSIGN] Found ${supervisors.length} supervisors with available capacity`);

  if (supervisors.length === 0) {
    return {
      success: false,
      assignedCount: 0,
      message: "No supervisors with remaining capacity",
    };
  }

  supervisors.sort((a, b) => a.currentLoad - b.currentLoad);

  const assignments: Array<{ studentId: string; supervisorId: string; reason?: string }> = [];

  for (const student of students) {
    let bestSupervisor = null;
    let bestScore = -Infinity;

    for (const sup of supervisors) {
      if (sup.currentLoad >= sup.maxStudents) continue;

      let score = 100 - sup.currentLoad * 8;

      if (student.program && sup.specialties.includes(student.program)) {
        score += 50;
      } else if (sup.department === student.program) {
        score += 30;
      }

      if (score > bestScore) {
        bestScore = score;
        bestSupervisor = sup;
      }
    }

    if (bestSupervisor) {
      assignments.push({
        studentId: student.id,
        supervisorId: bestSupervisor.id,
        reason: `Score: ${bestScore} (load: ${bestSupervisor.currentLoad}/${bestSupervisor.maxStudents})`,
      });

      bestSupervisor.currentLoad += 1;
      console.log(`[ASSIGN] ✓ Student ${student.id} → Supervisor ${bestSupervisor.id} (score: ${bestScore})`);
    } else {
      console.warn(`[ASSIGN] ✗ No supervisor for student ${student.id}`);
    }
  }

  console.log(`[ASSIGN] Total assignments to commit: ${assignments.length}`);

  if (assignments.length === 0) {
    return {
      success: false,
      assignedCount: 0,
      message: "No assignments made - all supervisors at capacity",
    };
  }

  // Commit assignments
  const batch = db.batch();

  for (const assignment of assignments) {
    batch.update(
      db.collection("students").doc(assignment.studentId),
      {
        currentSupervisorId: assignment.supervisorId,
        assignedAt: admin.firestore.FieldValue.serverTimestamp(),
        assignedBy: callerUid,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      }
    );

    batch.update(
      db.collection("supervisorProfiles").doc(assignment.supervisorId),
      {
        currentLoad: admin.firestore.FieldValue.increment(1),
        assignedStudentIds: admin.firestore.FieldValue.arrayUnion(assignment.studentId),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      }
    );
  }

  try {
    await batch.commit();
    console.log(`[ASSIGN] ✓ Successfully committed ${assignments.length} assignments`);
  } catch (error) {
    console.error(`[ASSIGN] ✗ Error committing:`, error);
    throw new functions.https.HttpsError("internal", `Failed to commit: ${error}`);
  }

  return {
    success: true,
    assignedCount: assignments.length,
    message: `Successfully assigned ${assignments.length} students`,
    details: assignments.map(a => ({
      studentId: a.studentId,
      supervisorId: a.supervisorId,
      reason: a.reason,
    })),
  };
}