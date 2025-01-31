// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'national_id_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NationalIdType _$NationalIdTypeFromJson(Map<String, dynamic> json) =>
    NationalIdType(
      id: (json['id'] as num).toInt(),
      titleEn: json['title_en'] as String,
      titleAr: json['title_ar'] as String,
    );

Map<String, dynamic> _$NationalIdTypeToJson(NationalIdType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title_en': instance.titleEn,
      'title_ar': instance.titleAr,
    };
