// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_logbook_entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailyLogbookEntryModelImpl _$$DailyLogbookEntryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DailyLogbookEntryModelImpl(
      id: json['id'] as String?,
      studentId: json['studentId'] as String,
      placementId: json['placementId'] as String,
      date: DateTime.parse(json['date'] as String),
      dayNumber: (json['dayNumber'] as num).toInt(),
      tasksPerformed: json['tasksPerformed'] as String,
      hoursWorked: (json['hoursWorked'] as num).toDouble(),
      challenges: json['challenges'] as String?,
      skillsLearned: json['skillsLearned'] as String?,
      notes: json['notes'] as String?,
      attachmentUrls: (json['attachmentUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$DailyLogbookEntryModelImplToJson(
        _$DailyLogbookEntryModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'studentId': instance.studentId,
      'placementId': instance.placementId,
      'date': instance.date.toIso8601String(),
      'dayNumber': instance.dayNumber,
      'tasksPerformed': instance.tasksPerformed,
      'hoursWorked': instance.hoursWorked,
      'challenges': instance.challenges,
      'skillsLearned': instance.skillsLearned,
      'notes': instance.notes,
      'attachmentUrls': instance.attachmentUrls,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
