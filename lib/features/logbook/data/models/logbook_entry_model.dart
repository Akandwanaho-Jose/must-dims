import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'logbook_entry_model.freezed.dart';
part 'logbook_entry_model.g.dart';

@freezed
class LogbookEntryModel with _$LogbookEntryModel {
  const factory LogbookEntryModel({
    String? id,
    required String studentId,
    required String placementId,
    
    // Week tracking
    required int weekNumber, // 1, 2, 3... up to totalWeeks
    required DateTime weekStartDate,
    required DateTime weekEndDate,
    
    // Student submission
    required String activitiesPerformed,
    String? skillsLearned,
    String? challengesFaced,
    required double hoursWorked,
    @Default([]) List<String> attachmentUrls, // Photos, documents
    DateTime? submittedAt,
    
    // University supervisor review
    @Default(false) bool isReviewedByUniversitySupervisor,
    String? universitySupervisorComment,
    int? universitySupervisorRating, // 1-5 stars
    DateTime? universityReviewedAt,
    
    // Company supervisor review - NEW FIELDS
    @Default(false) bool isReviewedByCompanySupervisor,
    String? companySupervisorComment,
    int? companySupervisorRating, // 1-5 stars
    DateTime? companyReviewedAt,
    
    // Additional ratings (optional)
    int? codeQualityRating,
    int? problemSolvingRating,
    int? initiativeRating,
    int? communicationRating,
    
    // Status
    @Default('draft') String status, // draft, submitted, reviewed
    
    // Location tracking (optional)
    double? latitude,
    double? longitude,
    
    // Timestamps
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _LogbookEntryModel;

  factory LogbookEntryModel.fromJson(Map<String, dynamic> json) =>
      _$LogbookEntryModelFromJson(json);

  // ── Timestamp-safe fromFirestore
  static LogbookEntryModel fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    final data = doc.data() ?? {};

    DateTime? parseDate(dynamic value) {
      if (value == null) return null;
      if (value is Timestamp) return value.toDate();
      if (value is DateTime) return value;
      if (value is String) return DateTime.tryParse(value);
      return null;
    }

    return LogbookEntryModel.fromJson({
      ...data,
      'id': doc.id,
      'weekStartDate': parseDate(data['weekStartDate'])?.toIso8601String() ?? DateTime.now().toIso8601String(),
      'weekEndDate': parseDate(data['weekEndDate'])?.toIso8601String() ?? DateTime.now().toIso8601String(),
      'submittedAt': parseDate(data['submittedAt'])?.toIso8601String(),
      'universityReviewedAt': parseDate(data['universityReviewedAt'])?.toIso8601String(),
      'companyReviewedAt': parseDate(data['companyReviewedAt'])?.toIso8601String(),
      'createdAt': parseDate(data['createdAt'])?.toIso8601String(),
      'updatedAt': parseDate(data['updatedAt'])?.toIso8601String(),
    });
  }
}

// ── Extension for toFirestore
extension LogbookEntryModelFirestore on LogbookEntryModel {
  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('id');

    // Convert DateTimes to Timestamps
    json['weekStartDate'] = Timestamp.fromDate(weekStartDate);
    json['weekEndDate'] = Timestamp.fromDate(weekEndDate);
    
    if (submittedAt != null) {
      json['submittedAt'] = Timestamp.fromDate(submittedAt!);
    }
    if (universityReviewedAt != null) {
      json['universityReviewedAt'] = Timestamp.fromDate(universityReviewedAt!);
    }
    if (companyReviewedAt != null) {
      json['companyReviewedAt'] = Timestamp.fromDate(companyReviewedAt!);
    }
    if (createdAt != null) {
      json['createdAt'] = Timestamp.fromDate(createdAt!);
    }
    
    json['updatedAt'] = FieldValue.serverTimestamp();

    return json;
  }
}