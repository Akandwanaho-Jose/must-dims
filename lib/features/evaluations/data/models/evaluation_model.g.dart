// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evaluation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EvaluationModelImpl _$$EvaluationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$EvaluationModelImpl(
      id: json['id'] as String?,
      placementId: json['placementId'] as String,
      studentId: json['studentId'] as String,
      evaluatorType:
          $enumDecode(_$EvaluationTypeEnumMap, json['evaluatorType']),
      evaluatorId: json['evaluatorId'] as String,
      evaluatorName: json['evaluatorName'] as String?,
      finalMarks: (json['finalMarks'] as num).toDouble(),
      technicalSkillsRating: (json['technicalSkillsRating'] as num).toDouble(),
      workEthicRating: (json['workEthicRating'] as num).toDouble(),
      communicationRating: (json['communicationRating'] as num).toDouble(),
      problemSolvingRating: (json['problemSolvingRating'] as num).toDouble(),
      initiativeRating: (json['initiativeRating'] as num).toDouble(),
      teamworkRating: (json['teamworkRating'] as num).toDouble(),
      daysPresent: (json['daysPresent'] as num?)?.toInt(),
      daysAbsent: (json['daysAbsent'] as num?)?.toInt(),
      totalWorkingDays: (json['totalWorkingDays'] as num?)?.toInt(),
      overallComments: json['overallComments'] as String?,
      strengthsHighlighted: json['strengthsHighlighted'] as String?,
      areasForImprovement: json['areasForImprovement'] as String?,
      recommendationsForFutureInterns:
          json['recommendationsForFutureInterns'] as String?,
      wouldHireAgain: json['wouldHireAgain'] as bool?,
      hiringConditions: json['hiringConditions'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      submittedAt: json['submittedAt'] == null
          ? null
          : DateTime.parse(json['submittedAt'] as String),
    );

Map<String, dynamic> _$$EvaluationModelImplToJson(
        _$EvaluationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'placementId': instance.placementId,
      'studentId': instance.studentId,
      'evaluatorType': _$EvaluationTypeEnumMap[instance.evaluatorType]!,
      'evaluatorId': instance.evaluatorId,
      'evaluatorName': instance.evaluatorName,
      'finalMarks': instance.finalMarks,
      'technicalSkillsRating': instance.technicalSkillsRating,
      'workEthicRating': instance.workEthicRating,
      'communicationRating': instance.communicationRating,
      'problemSolvingRating': instance.problemSolvingRating,
      'initiativeRating': instance.initiativeRating,
      'teamworkRating': instance.teamworkRating,
      'daysPresent': instance.daysPresent,
      'daysAbsent': instance.daysAbsent,
      'totalWorkingDays': instance.totalWorkingDays,
      'overallComments': instance.overallComments,
      'strengthsHighlighted': instance.strengthsHighlighted,
      'areasForImprovement': instance.areasForImprovement,
      'recommendationsForFutureInterns':
          instance.recommendationsForFutureInterns,
      'wouldHireAgain': instance.wouldHireAgain,
      'hiringConditions': instance.hiringConditions,
      'createdAt': instance.createdAt?.toIso8601String(),
      'submittedAt': instance.submittedAt?.toIso8601String(),
    };

const _$EvaluationTypeEnumMap = {
  EvaluationType.companySupervisor: 'companySupervisor',
  EvaluationType.universitySupervisor: 'universitySupervisor',
};
