import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'weekly_logbook_summary_model.freezed.dart';
part 'weekly_logbook_summary_model.g.dart';

@freezed
class WeeklyLogbookSummaryModel with _$WeeklyLogbookSummaryModel {
  const factory WeeklyLogbookSummaryModel({
    String? id,
    required String studentId,
    required String placementId,
    required int weekNumber,
    required DateTime weekStartDate,
    required DateTime weekEndDate,
    
    // Weekly Overview (compiled by student)
    required String weeklyOverview,
    required double totalHoursWorked,
    String? keyAccomplishments,
    String? challengesSummary,
    String? skillsAcquired,
    String? lessonsLearned,
    
    // References to daily entries
    @Default([]) List<String> dailyEntryIds,
    
    // Company Supervisor Review
    @Default(false) bool isReviewedByCompanySupervisor,
    String? companySupervisorComment,
    double? companySupervisorRating,
    DateTime? companyReviewedAt,
    
    // University Supervisor Review
    @Default(false) bool isReviewedByUniversitySupervisor,
    String? universitySupervisorComment,
    double? universitySupervisorRating,
    DateTime? universityReviewedAt,
    
    // Status
    @Default('draft') String status, // draft, submitted, reviewed
    DateTime? submittedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _WeeklyLogbookSummaryModel;

  factory WeeklyLogbookSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$WeeklyLogbookSummaryModelFromJson(json);

  factory WeeklyLogbookSummaryModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;
    return WeeklyLogbookSummaryModel(
      id: snapshot.id,
      studentId: data['studentId'] as String,
      placementId: data['placementId'] as String,
      weekNumber: data['weekNumber'] as int,
      weekStartDate: (data['weekStartDate'] as Timestamp).toDate(),
      weekEndDate: (data['weekEndDate'] as Timestamp).toDate(),
      weeklyOverview: data['weeklyOverview'] as String,
      totalHoursWorked: (data['totalHoursWorked'] as num).toDouble(),
      keyAccomplishments: data['keyAccomplishments'] as String?,
      challengesSummary: data['challengesSummary'] as String?,
      skillsAcquired: data['skillsAcquired'] as String?,
      lessonsLearned: data['lessonsLearned'] as String?,
      dailyEntryIds: data['dailyEntryIds'] != null
          ? List<String>.from(data['dailyEntryIds'] as List)
          : [],
      isReviewedByCompanySupervisor: data['isReviewedByCompanySupervisor'] as bool? ?? false,
      companySupervisorComment: data['companySupervisorComment'] as String?,
      companySupervisorRating: data['companySupervisorRating'] != null
          ? (data['companySupervisorRating'] as num).toDouble()
          : null,
      companyReviewedAt: data['companyReviewedAt'] != null
          ? (data['companyReviewedAt'] as Timestamp).toDate()
          : null,
      isReviewedByUniversitySupervisor: data['isReviewedByUniversitySupervisor'] as bool? ?? false,
      universitySupervisorComment: data['universitySupervisorComment'] as String?,
      universitySupervisorRating: data['universitySupervisorRating'] != null
          ? (data['universitySupervisorRating'] as num).toDouble()
          : null,
      universityReviewedAt: data['universityReviewedAt'] != null
          ? (data['universityReviewedAt'] as Timestamp).toDate()
          : null,
      status: data['status'] as String? ?? 'draft',
      submittedAt: data['submittedAt'] != null
          ? (data['submittedAt'] as Timestamp).toDate()
          : null,
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : null,
      updatedAt: data['updatedAt'] != null
          ? (data['updatedAt'] as Timestamp).toDate()
          : null,
    );
  }
}

extension WeeklyLogbookSummaryModelX on WeeklyLogbookSummaryModel {
  Map<String, dynamic> toFirestore() {
    return {
      'studentId': studentId,
      'placementId': placementId,
      'weekNumber': weekNumber,
      'weekStartDate': Timestamp.fromDate(weekStartDate),
      'weekEndDate': Timestamp.fromDate(weekEndDate),
      'weeklyOverview': weeklyOverview,
      'totalHoursWorked': totalHoursWorked,
      'keyAccomplishments': keyAccomplishments,
      'challengesSummary': challengesSummary,
      'skillsAcquired': skillsAcquired,
      'lessonsLearned': lessonsLearned,
      'dailyEntryIds': dailyEntryIds,
      'isReviewedByCompanySupervisor': isReviewedByCompanySupervisor,
      'companySupervisorComment': companySupervisorComment,
      'companySupervisorRating': companySupervisorRating,
      'companyReviewedAt': companyReviewedAt != null
          ? Timestamp.fromDate(companyReviewedAt!)
          : null,
      'isReviewedByUniversitySupervisor': isReviewedByUniversitySupervisor,
      'universitySupervisorComment': universitySupervisorComment,
      'universitySupervisorRating': universitySupervisorRating,
      'universityReviewedAt': universityReviewedAt != null
          ? Timestamp.fromDate(universityReviewedAt!)
          : null,
      'status': status,
      'submittedAt': submittedAt != null ? Timestamp.fromDate(submittedAt!) : null,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}