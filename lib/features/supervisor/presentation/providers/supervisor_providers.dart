import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Import Auth and Core
import '../../../auth/controllers/auth_controller.dart';
// Fix: Use ONLY this one import for the supervisor model
import '../../data/models/supervisor_profile_model.dart';
import '../../../student/data/models/student_profile_model.dart';
import '../../../logbook/data/models/logbook_entry_model.dart';
import '../../controllers/supervisor_controller.dart';


import '../../../logbook/data/models/weekly_logbook_summary_model.dart';

// Supervisor's own profile
// Explicitly typed as <SupervisorProfileModel?>
final supervisorProfileProvider = StreamProvider<SupervisorProfileModel?>((ref) {
  final authState = ref.watch(authStateProvider);
  final firestore = ref.watch(firestoreProvider);

  final uid = authState.value?.uid;
  if (uid == null) return Stream.value(null);

  return firestore
      .collection('supervisorProfiles')
      .doc(uid)
      .snapshots()
      .map((doc) {
        if (!doc.exists) return null;
        return SupervisorProfileModel.fromFirestore(doc, null);
      });
});

// Students assigned to this supervisor
final assignedStudentsProvider = StreamProvider<List<StudentProfileModel>>((ref) {
  final profile = ref.watch(supervisorProfileProvider).value;
  final firestore = ref.watch(firestoreProvider);

  final uid = profile?.uid;
  if (uid == null) return Stream.value([]);

  return firestore
      .collection('students')
      .where('currentSupervisorId', isEqualTo: uid)
      .snapshots()
      .map((snapshot) {
        return snapshot.docs.map((doc) => StudentProfileModel.fromFirestore(doc, null)).toList();
      });
});

// Pending logbooks for the current supervisor
final pendingLogbooksProvider = StreamProvider<List<LogbookEntryModel>>((ref) {
  final profile = ref.watch(supervisorProfileProvider).value;
  final supervisorUid = profile?.uid;

  if (supervisorUid == null) return Stream.value([]);

  return ref.watch(supervisorControllerProvider).getPendingLogbooks(supervisorUid);
});

final pendingWeeklySummariesProvider = StreamProvider<List<WeeklyLogbookSummaryModel>>((ref) {
  final authState = ref.watch(authStateProvider);
  final userId = authState.value?.uid;
  
  if (userId == null) return Stream.value([]);

  return FirebaseFirestore.instance
      .collection('weeklyLogbookSummaries')
      .where('status', isEqualTo: 'submitted')
      .orderBy('weekNumber', descending: true)
      .snapshots()
      .asyncMap((snapshot) async {
        // Filter summaries for students assigned to this supervisor
        final supervisorProfile = await FirebaseFirestore.instance
            .collection('supervisorProfiles')
            .doc(userId)
            .get();

        if (!supervisorProfile.exists) return <WeeklyLogbookSummaryModel>[];

        final profile = SupervisorProfileModel.fromFirestore(supervisorProfile, null);
        final assignedStudentIds = profile.assignedStudentIds;

        // Filter and parse
        return snapshot.docs
            .map((doc) => WeeklyLogbookSummaryModel.fromFirestore(doc, null))
            .where((summary) => assignedStudentIds.contains(summary.studentId))
            .toList();
      })
      .handleError((e) {
        print('[PendingWeeklySummaries] Error: $e');
        return <WeeklyLogbookSummaryModel>[];
      });
});

// NEW: Count of pending reviews
final pendingSummaryReviewsCountProvider = Provider<int>((ref) {
  final summaries = ref.watch(pendingWeeklySummariesProvider).value ?? [];
  return summaries.where((s) => !s.isReviewedByUniversitySupervisor).length;
});