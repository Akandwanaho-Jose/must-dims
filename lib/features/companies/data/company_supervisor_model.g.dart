// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_supervisor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CompanySupervisorModelImpl _$$CompanySupervisorModelImplFromJson(
        Map<String, dynamic> json) =>
    _$CompanySupervisorModelImpl(
      uid: json['uid'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      companyId: json['companyId'] as String,
      companyName: json['companyName'] as String?,
      position: json['position'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      photoUrl: json['photoUrl'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      emailVerified: json['emailVerified'] as bool? ?? false,
      assignedStudentIds: (json['assignedStudentIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      currentLoad: (json['currentLoad'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      lastLoginAt: json['lastLoginAt'] == null
          ? null
          : DateTime.parse(json['lastLoginAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$CompanySupervisorModelImplToJson(
        _$CompanySupervisorModelImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'fullName': instance.fullName,
      'email': instance.email,
      'companyId': instance.companyId,
      'companyName': instance.companyName,
      'position': instance.position,
      'phoneNumber': instance.phoneNumber,
      'photoUrl': instance.photoUrl,
      'isActive': instance.isActive,
      'emailVerified': instance.emailVerified,
      'assignedStudentIds': instance.assignedStudentIds,
      'currentLoad': instance.currentLoad,
      'createdAt': instance.createdAt?.toIso8601String(),
      'lastLoginAt': instance.lastLoginAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
