// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CompanyModelImpl _$$CompanyModelImplFromJson(Map<String, dynamic> json) =>
    _$CompanyModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      industry: json['industry'] as String,
      location: json['location'] as String,
      contactEmail: json['contactEmail'] as String?,
      contactPhone: json['contactPhone'] as String?,
      website: json['website'] as String?,
      logoUrl: json['logoUrl'] as String?,
      description: json['description'] as String?,
      maxInterns: (json['maxInterns'] as num?)?.toInt() ?? 0,
      currentInterns: (json['currentInterns'] as num?)?.toInt() ?? 0,
      preferredPrograms: (json['preferredPrograms'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      companySupervisorIds: (json['companySupervisorIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isActive: json['isActive'] as bool? ?? true,
      acceptingInterns: json['acceptingInterns'] as bool? ?? true,
      address: json['address'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
      postalCode: json['postalCode'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$CompanyModelImplToJson(_$CompanyModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'industry': instance.industry,
      'location': instance.location,
      'contactEmail': instance.contactEmail,
      'contactPhone': instance.contactPhone,
      'website': instance.website,
      'logoUrl': instance.logoUrl,
      'description': instance.description,
      'maxInterns': instance.maxInterns,
      'currentInterns': instance.currentInterns,
      'preferredPrograms': instance.preferredPrograms,
      'companySupervisorIds': instance.companySupervisorIds,
      'isActive': instance.isActive,
      'acceptingInterns': instance.acceptingInterns,
      'address': instance.address,
      'city': instance.city,
      'country': instance.country,
      'postalCode': instance.postalCode,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
