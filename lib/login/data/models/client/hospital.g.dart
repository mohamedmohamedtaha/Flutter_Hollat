// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hospital.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hospital _$HospitalFromJson(Map<String, dynamic> json) => Hospital(
      active: (json['active'] as num).toInt(),
      addressAr: json['address_ar'] as String,
      addressEn: json['address_en'] as String,
      cityId: (json['city_id'] as num).toInt(),
      code: json['code'] as String,
      countryId: (json['country_id'] as num).toInt(),
      createdAt: json['created_at'] as String,
      defaultRoleId: (json['default_role_id'] as num).toInt(),
      defaultTeamTierId: (json['default_team_tier_id'] as num).toInt(),
      deletedAt: json['deleted_at'],
      googleMapUrl: json['google_map_url'] as String,
      hotline: json['hotline'] as String,
      id: (json['id'] as num).toInt(),
      mobile: json['mobile'] as String,
      organizationTypeId: (json['organization_type_id'] as num).toInt(),
      pivot: Pivot.fromJson(json['pivot'] as Map<String, dynamic>),
      portal: (json['portal'] as num).toInt(),
      regionId: (json['region_id'] as num).toInt(),
      responsibility: json['responsibility'] as String,
      supervisionOrganizationId: json['supervision_organization_id'],
      telephone: json['telephone'] as String,
      timezone: json['timezone'],
      titleAr: json['title_ar'] as String,
      titleEn: json['title_en'] as String,
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$HospitalToJson(Hospital instance) => <String, dynamic>{
      'active': instance.active,
      'address_ar': instance.addressAr,
      'address_en': instance.addressEn,
      'city_id': instance.cityId,
      'code': instance.code,
      'country_id': instance.countryId,
      'created_at': instance.createdAt,
      'default_role_id': instance.defaultRoleId,
      'default_team_tier_id': instance.defaultTeamTierId,
      'deleted_at': instance.deletedAt,
      'google_map_url': instance.googleMapUrl,
      'hotline': instance.hotline,
      'id': instance.id,
      'mobile': instance.mobile,
      'organization_type_id': instance.organizationTypeId,
      'pivot': instance.pivot,
      'portal': instance.portal,
      'region_id': instance.regionId,
      'responsibility': instance.responsibility,
      'supervision_organization_id': instance.supervisionOrganizationId,
      'telephone': instance.telephone,
      'timezone': instance.timezone,
      'title_ar': instance.titleAr,
      'title_en': instance.titleEn,
      'updated_at': instance.updatedAt,
    };
