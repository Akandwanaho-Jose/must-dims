import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'student_profile_model.freezed.dart';
part 'student_profile_model.g.dart';

// Enum for internship status
enum StudentInternshipStatus {
  notStarted,
  awaitingApproval,
  inProgress,
  completed,
  deferred,
  terminated,
}

@freezed
class StudentProfileModel with _$StudentProfileModel {
  const factory StudentProfileModel({
    required String uid,
    required String fullName,
    required String registrationNumber,
    required String program,
    @Default(1) int academicYear,
    @Default('') String currentLevel,
    @Default(null) String? currentPlacementId,
    @Default(null) String? currentSupervisorId,
    @Default('active') String status,
    @Default(0.0) double progressPercentage,
    @Default(StudentInternshipStatus.notStarted) StudentInternshipStatus internshipStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _StudentProfileModel;

  factory StudentProfileModel.fromJson(Map<String, dynamic> json) =>
      _$StudentProfileModelFromJson(json);

  // ── Timestamp-safe fromFirestore (static factory) ───────────────────────────
  static StudentProfileModel fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data() ?? {};
    
    DateTime? parseDate(dynamic value) {
      if (value == null) return null;
      if (value is Timestamp) return value.toDate();
      if (value is DateTime) return value;
      if (value is String) return DateTime.tryParse(value);
      return null;
    }
    
    return StudentProfileModel.fromJson({
      'uid': data['uid'] ?? snapshot.id,
      'fullName': data['fullName'] ?? 'Unknown Student', // CRITICAL FIX
      'registrationNumber': data['registrationNumber'] ?? 'PENDING',
      'program': data['program'] ?? 'Computer Science',
      'academicYear': data['academicYear'] ?? 2024,
      'currentLevel': data['currentLevel'] ?? '',
      'currentPlacementId': data['currentPlacementId'], // Can be null
      'currentSupervisorId': data['currentSupervisorId'], // Can be null
      'status': data['status'] ?? 'active',
      'progressPercentage': (data['progressPercentage'] ?? 0.0).toDouble(),
      'internshipStatus': data['internshipStatus'] ?? 'notStarted',
      'createdAt': parseDate(data['createdAt'])?.toIso8601String(),
      'updatedAt': parseDate(data['updatedAt'])?.toIso8601String(),
    });
  }
}

// ── Extension for toFirestore (instance method) ──────────────────────────────
extension StudentProfileModelFirestore on StudentProfileModel {
  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('uid'); // UID is document ID
    
    // Ensure critical fields are explicitly null if empty
    json['currentSupervisorId'] = currentSupervisorId; 
    json['currentPlacementId'] = currentPlacementId;
    
    if (createdAt != null) {
      json['createdAt'] = Timestamp.fromDate(createdAt!);
    }
    if (updatedAt != null) {
      json['updatedAt'] = Timestamp.fromDate(updatedAt!);
    }
    
    json['internshipStatus'] = internshipStatus.name;
    return json;
  }
}