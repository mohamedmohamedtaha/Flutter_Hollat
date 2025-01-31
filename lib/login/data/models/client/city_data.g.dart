// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityData _$CityDataFromJson(Map<String, dynamic> json) => CityData(
      active: (json['active'] as num).toInt(),
      countryId: (json['country_id'] as num).toInt(),
      regionId: (json['region_id'] as num).toInt(),
      createdAt: json['created_at'] as String,
      deletedAt: json['deleted_at'],
      id: (json['id'] as num).toInt(),
      titleAr: json['title_ar'] as String,
      titleEn: json['title_en'] as String,
      updatedAt: json['updated_at'] as String,
      userId: (json['user_id'] as num).toInt(),
    );

Map<String, dynamic> _$CityDataToJson(CityData instance) => <String, dynamic>{
      'active': instance.active,
      'country_id': instance.countryId,
      'region_id': instance.regionId,
      'created_at': instance.createdAt,
      'deleted_at': instance.deletedAt,
      'id': instance.id,
      'title_ar': instance.titleAr,
      'title_en': instance.titleEn,
      'updated_at': instance.updatedAt,
      'user_id': instance.userId,
    };
