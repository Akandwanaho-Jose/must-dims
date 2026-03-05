// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logbook_entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LogbookEntryModelImpl _$$LogbookEntryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LogbookEntryModelImpl(
      id: json['id'] as String?,
      studentId: json['studentId'] as String,
      placementId: json['placementId'] as String,
      weekNumber: (json['weekNumber'] as num).toInt(),
      weekStartDate: DateTime.parse(json['weekStartDate'] as String),
      weekEndDate: DateTime.parse(json['weekEndDate'] as String),
      activitiesPerformed: json['activitiesPerformed'] as String,
      skillsLearned: json['skillsLearned'] as String?,
      challengesFaced: json['challengesFaced'] as String?,
      hoursWorked: (json['hoursWorked'] as num).toDouble(),
      attachmentUrls: (json['attachmentUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      submittedAt: json['submittedAt'] == null
          ? null
          : DateTime.parse(json['submittedAt'] as String),
      isReviewedByUniversitySupervisor:
          json['isReviewedByUniversitySupervisor'] as bool? ?? false,
      universitySupervisorComment:
          json['universitySupervisorComment'] as String?,
      universitySupervisorRating:
          (json['universitySupervisorRating'] as num?)?.toInt(),
      universityReviewedAt: json['universityReviewedAt'] == null
          ? null
          : DateTime.parse(json['universityReviewedAt'] as String),
      isReviewedByCompanySupervisor:
          json['isReviewedByCompanySupervisor'] as bool? ?? false,
      companySupervisorComment: json['companySupervisorComment'] as String?,
      companySupervisorRating:
          (json['companySupervisorRating'] as num?)?.toInt(),
      companyReviewedAt: json['companyReviewedAt'] == null
          ? null
          : DateTime.parse(json['companyReviewedAt'] as String),
      codeQualityRating: (json['codeQualityRating'] as num?)?.toInt(),
      problemSolvingRating: (json['problemSolvingRating'] as num?)?.toInt(),
      initiativeRating: (json['initiativeRating'] as num?)?.toInt(),
      communicationRating: (json['communicationRating'] as num?)?.toInt(),
      status: json['status'] as String? ?? 'draft',
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$LogbookEntryModelImplToJson(
        _$LogbookEntryModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'studentId': instance.studentId,
      'placementId': instance.placementId,
      'weekNumber': instance.weekNumber,
      'weekStartDate': instance.weekStartDate.toIso8601String(),
      'weekEndDate': instance.weekEndDate.toIso8601String(),
      'activitiesPerformed': instance.activitiesPerformed,
      'skillsLearned': instance.skillsLearned,
      'challengesFaced': instance.challengesFaced,
      'hoursWorked': instance.hoursWorked,
      'attachmentUrls': instance.attachmentUrls,
      'submittedAt': instance.submittedAt?.toIso8601String(),
      'isReviewedByUniversitySupervisor':
          instance.isReviewedByUniversitySupervisor,
      'universitySupervisorComment': instance.universitySupervisorComment,
      'universitySupervisorRating': instance.universitySupervisorRating,
      'universityReviewedAt': instance.universityReviewedAt?.toIso8601String(),
      'isReviewedByCompanySupervisor': instance.isReviewedByCompanySupervisor,
      'companySupervisorComment': instance.companySupervisorComment,
      'companySupervisorRating': instance.companySupervisorRating,
      'companyReviewedAt': instance.companyReviewedAt?.toIso8601String(),
      'codeQualityRating': instance.codeQualityRating,
      'problemSolvingRating': instance.problemSolvingRating,
      'initiativeRating': instance.initiativeRating,
      'communicationRating': instance.communicationRating,
      'status': instance.status,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
