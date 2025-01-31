// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'region_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegionData _$RegionDataFromJson(Map<String, dynamic> json) => RegionData(
      active: (json['active'] as num).toInt(),
      code: json['code'] as String,
      countryId: (json['country_id'] as num).toInt(),
      createdAt: json['created_at'] as String,
      deletedAt: json['deleted_at'],
      id: (json['id'] as num).toInt(),
      titleAr: json['title_ar'] as String,
      titleEn: json['title_en'] as String,
      updatedAt: json['updated_at'] as String,
      userId: (json['user_id'] as num).toInt(),
    );

Map<String, dynamic> _$RegionDataToJson(RegionData instance) =>
    <String, dynamic>{
      'active': instance.active,
      'code': instance.code,
      'country_id': instance.countryId,
      'created_at': instance.createdAt,
      'deleted_at': instance.deletedAt,
      'id': instance.id,
      'title_ar': instance.titleAr,
      'title_en': instance.titleEn,
      'updated_at': instance.updatedAt,
      'user_id': instance.userId,
    };
