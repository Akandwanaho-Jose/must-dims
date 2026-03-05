// lib/core/extensions/model_extensions.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dims/features/placements/data/models/placement_model.dart';
import 'package:dims/features/logbook/data/models/logbook_entry_model.dart';
import 'package:dims/features/evaluations/data/models/evaluation_model.dart';
import 'package:dims/features/notifications/data/models/notification_model.dart';

// Placement Extensions
extension PlacementModelExtension on PlacementModel {
  // Updated field names in new PlacementModel
  DocumentReference get studentRef => 
      FirebaseFirestore.instance.collection('students').doc(studentId);
  
  DocumentReference get companyRef => 
      FirebaseFirestore.instance.collection('companies').doc(companyId);
  
  DocumentReference? get universitySupervisorRef => 
      universitySupervisorId != null 
          ? FirebaseFirestore.instance.collection('supervisorProfiles').doc(universitySupervisorId!)
          : null;
  
  DocumentReference? get companySupervisorRef => 
      companySupervisorId != null 
          ? FirebaseFirestore.instance.collection('companySupervisors').doc(companySupervisorId!)
          : null;
}

// Logbook Entry Extensions
extension LogbookEntryModelExtension on LogbookEntryModel {
  // Updated field names in new LogbookEntryModel
  DocumentReference get studentRef => 
      FirebaseFirestore.instance.collection('students').doc(studentId);
  
  DocumentReference get placementRef => 
      FirebaseFirestore.instance.collection('placements').doc(placementId);
  
  // GPS location helper
  GeoPoint? get gpsLocation => 
      (latitude != null && longitude != null)
          ? GeoPoint(latitude!, longitude!)
          : null;
}

// Evaluation Extensions
extension EvaluationModelExtension on EvaluationModel {
  // Updated field names in new EvaluationModel
  DocumentReference get studentRef => 
      FirebaseFirestore.instance.collection('students').doc(studentId);
  
  DocumentReference get evaluatorRef {
    // Return appropriate collection based on evaluator type
    if (evaluatorType == EvaluationType.companySupervisor) {
      return FirebaseFirestore.instance.collection('companySupervisors').doc(evaluatorId);
    } else {
      return FirebaseFirestore.instance.collection('supervisorProfiles').doc(evaluatorId);
    }
  }
  
  DocumentReference get placementRef => 
      FirebaseFirestore.instance.collection('placements').doc(placementId);
}

// Notification Extensions
extension NotificationModelExtension on NotificationModel {
  DocumentReference? get userRef => 
      userRefPath != null ? FirebaseFirestore.instance.doc(userRefPath!) : null;
}