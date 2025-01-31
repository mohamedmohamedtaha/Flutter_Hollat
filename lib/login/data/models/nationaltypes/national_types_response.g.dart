// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'national_types_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NationalTypesResponse _$NationalTypesResponseFromJson(
        Map<String, dynamic> json) =>
    NationalTypesResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => NationalTypes.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NationalTypesResponseToJson(
        NationalTypesResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
