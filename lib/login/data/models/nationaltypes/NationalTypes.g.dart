// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NationalTypes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NationalTypes _$NationalTypesFromJson(Map<String, dynamic> json) =>
    NationalTypes(
      createdAt: json['created_at'] as String,
      deletedAt: json['deleted_at'] as String?,
      id: (json['id'] as num).toInt(),
      titleAr: json['title_ar'] as String,
      titleEn: json['title_en'] as String,
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$NationalTypesToJson(NationalTypes instance) =>
    <String, dynamic>{
      'created_at': instance.createdAt,
      'deleted_at': instance.deletedAt,
      'id': instance.id,
      'title_ar': instance.titleAr,
      'title_en': instance.titleEn,
      'updated_at': instance.updatedAt,
    };
