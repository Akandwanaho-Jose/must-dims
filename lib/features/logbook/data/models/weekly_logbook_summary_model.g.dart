// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_logbook_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeeklyLogbookSummaryModelImpl _$$WeeklyLogbookSummaryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$WeeklyLogbookSummaryModelImpl(
      id: json['id'] as String?,
      studentId: json['studentId'] as String,
      placementId: json['placementId'] as String,
      weekNumber: (json['weekNumber'] as num).toInt(),
      weekStartDate: DateTime.parse(json['weekStartDate'] as String),
      weekEndDate: DateTime.parse(json['weekEndDate'] as String),
      weeklyOverview: json['weeklyOverview'] as String,
      totalHoursWorked: (json['totalHoursWorked'] as num).toDouble(),
      keyAccomplishments: json['keyAccomplishments'] as String?,
      challengesSummary: json['challengesSummary'] as String?,
      skillsAcquired: json['skillsAcquired'] as String?,
      lessonsLearned: json['lessonsLearned'] as String?,
      dailyEntryIds: (json['dailyEntryIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isReviewedByCompanySupervisor:
          json['isReviewedByCompanySupervisor'] as bool? ?? false,
      companySupervisorComment: json['companySupervisorComment'] as String?,
      companySupervisorRating:
          (json['companySupervisorRating'] as num?)?.toDouble(),
      companyReviewedAt: json['companyReviewedAt'] == null
          ? null
          : DateTime.parse(json['companyReviewedAt'] as String),
      isReviewedByUniversitySupervisor:
          json['isReviewedByUniversitySupervisor'] as bool? ?? false,
      universitySupervisorComment:
          json['universitySupervisorComment'] as String?,
      universitySupervisorRating:
          (json['universitySupervisorRating'] as num?)?.toDouble(),
      universityReviewedAt: json['universityReviewedAt'] == null
          ? null
          : DateTime.parse(json['universityReviewedAt'] as String),
      status: json['status'] as String? ?? 'draft',
      submittedAt: json['submittedAt'] == null
          ? null
          : DateTime.parse(json['submittedAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$WeeklyLogbookSummaryModelImplToJson(
        _$WeeklyLogbookSummaryModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'studentId': instance.studentId,
      'placementId': instance.placementId,
      'weekNumber': instance.weekNumber,
      'weekStartDate': instance.weekStartDate.toIso8601String(),
      'weekEndDate': instance.weekEndDate.toIso8601String(),
      'weeklyOverview': instance.weeklyOverview,
      'totalHoursWorked': instance.totalHoursWorked,
      'keyAccomplishments': instance.keyAccomplishments,
      'challengesSummary': instance.challengesSummary,
      'skillsAcquired': instance.skillsAcquired,
      'lessonsLearned': instance.lessonsLearned,
      'dailyEntryIds': instance.dailyEntryIds,
      'isReviewedByCompanySupervisor': instance.isReviewedByCompanySupervisor,
      'companySupervisorComment': instance.companySupervisorComment,
      'companySupervisorRating': instance.companySupervisorRating,
      'companyReviewedAt': instance.companyReviewedAt?.toIso8601String(),
      'isReviewedByUniversitySupervisor':
          instance.isReviewedByUniversitySupervisor,
      'universitySupervisorComment': instance.universitySupervisorComment,
      'universitySupervisorRating': instance.universitySupervisorRating,
      'universityReviewedAt': instance.universityReviewedAt?.toIso8601String(),
      'status': instance.status,
      'submittedAt': instance.submittedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
