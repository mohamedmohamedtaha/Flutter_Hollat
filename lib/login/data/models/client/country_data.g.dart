// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryData _$CountryDataFromJson(Map<String, dynamic> json) => CountryData(
      countryCode: json['country_code'] as String,
      createdAt: json['created_at'] as String,
      deletedAt: json['deleted_at'],
      id: (json['id'] as num).toInt(),
      isDefault: (json['is_default'] as num).toInt(),
      lat: json['lat'] as String,
      long: json['long'] as String,
      phoneCode: json['phone_code'] as String,
      titleAr: json['title_ar'] as String,
      titleEn: json['title_en'] as String,
      updatedAt: json['updated_at'] as String,
      userId: (json['user_id'] as num).toInt(),
    );

Map<String, dynamic> _$CountryDataToJson(CountryData instance) =>
    <String, dynamic>{
      'country_code': instance.countryCode,
      'created_at': instance.createdAt,
      'deleted_at': instance.deletedAt,
      'id': instance.id,
      'is_default': instance.isDefault,
      'lat': instance.lat,
      'long': instance.long,
      'phone_code': instance.phoneCode,
      'title_ar': instance.titleAr,
      'title_en': instance.titleEn,
      'updated_at': instance.updatedAt,
      'user_id': instance.userId,
    };
