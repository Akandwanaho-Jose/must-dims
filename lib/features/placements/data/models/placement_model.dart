import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'placement_model.freezed.dart';
part 'placement_model.g.dart';

enum PlacementStatus {
  pending,           // Acceptance letter uploaded, awaiting admin approval
  approved,          // Admin approved, ready to start
  rejected,          // Admin rejected the acceptance letter
  active,            // Internship in progress
  completed,         // Successfully completed
  cancelled,         // Cancelled before completion
  terminated,        // Ended early
  extended,          // Duration extended
}

@freezed
class PlacementModel with _$PlacementModel {
  const factory PlacementModel({
    required String id,
    required String studentId,
    required String companyId,
    String? universitySupervisorId, // Linked from student's currentSupervisorId
    
    // Company supervisor details (from acceptance letter)
    String? companySupervisorName,
    String? companySupervisorEmail,
    String? companySupervisorPhone,
    String? companySupervisorId, // Will be set when company supervisor creates account
    
    // Acceptance letter
    String? acceptanceLetterUrl,
    String? acceptanceLetterFileName,
    DateTime? letterUploadedAt,
    
    // Status & approval
    @Default(PlacementStatus.pending) PlacementStatus status,
    String? adminNotes, // Rejection reason or other notes
    DateTime? approvedAt,
    String? approvedByAdminId,
    DateTime? rejectedAt,
    String? rejectedByAdminId,
    
    // Internship timeline
    required String academicYear,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? actualEndDate,
    @Default(12) int totalWeeks, // Default 12 weeks
    @Default(0) int weeksCompleted,
    @Default(0.0) double progressPercentage,
    
    // Additional info
    String? studentNotes, // Why they chose this company
    String? remarks,
    
    // Timestamps
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _PlacementModel;

  factory PlacementModel.fromJson(Map<String, dynamic> json) =>
      _$PlacementModelFromJson(json);

  // Firestore converters
  static PlacementModel fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    final data = doc.data();
    if (data == null) {
      throw Exception('Document data is null');
    }

    DateTime? parseDate(dynamic value) {
      if (value == null) return null;
      if (value is Timestamp) return value.toDate();
      if (value is DateTime) return value;
      if (value is String) return DateTime.tryParse(value);
      return null;
    }

    return PlacementModel.fromJson({
      ...data,
      'id': doc.id,
      'letterUploadedAt': parseDate(data['letterUploadedAt'])?.toIso8601String(),
      'approvedAt': parseDate(data['approvedAt'])?.toIso8601String(),
      'rejectedAt': parseDate(data['rejectedAt'])?.toIso8601String(),
      'startDate': parseDate(data['startDate'])?.toIso8601String(),
      'endDate': parseDate(data['endDate'])?.toIso8601String(),
      'actualEndDate': parseDate(data['actualEndDate'])?.toIso8601String(),
      'createdAt': parseDate(data['createdAt'])?.toIso8601String(),
      'updatedAt': parseDate(data['updatedAt'])?.toIso8601String(),
    });
  }

  static Map<String, dynamic> toFirestore(
    PlacementModel placement,
    SetOptions? options,
  ) {
    final json = placement.toJson();
    json.remove('id'); // Don't store ID in document

    // Convert DateTimes to Timestamps
    if (placement.letterUploadedAt != null) {
      json['letterUploadedAt'] = Timestamp.fromDate(placement.letterUploadedAt!);
    }
    if (placement.approvedAt != null) {
      json['approvedAt'] = Timestamp.fromDate(placement.approvedAt!);
    }
    if (placement.rejectedAt != null) {
      json['rejectedAt'] = Timestamp.fromDate(placement.rejectedAt!);
    }
    if (placement.startDate != null) {
      json['startDate'] = Timestamp.fromDate(placement.startDate!);
    }
    if (placement.endDate != null) {
      json['endDate'] = Timestamp.fromDate(placement.endDate!);
    }
    if (placement.actualEndDate != null) {
      json['actualEndDate'] = Timestamp.fromDate(placement.actualEndDate!);
    }
    if (placement.createdAt != null) {
      json['createdAt'] = Timestamp.fromDate(placement.createdAt!);
    }
    if (placement.updatedAt != null) {
      json['updatedAt'] = Timestamp.fromDate(placement.updatedAt!);
    }

    // Convert enum to string
    json['status'] = placement.status.name;

    return json;
  }
}