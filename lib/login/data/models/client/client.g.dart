// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Client _$ClientFromJson(Map<String, dynamic> json) => Client(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      gender: json['gender'] as String,
      birthdate: json['birthdate'] as String,
      mobile: json['mobile'] as String,
      nationalId: json['national_id'] as String,
      nationalIdTypeId: (json['national_id_type_id'] as num?)?.toInt(),
      active: (json['active'] as num?)?.toInt(),
      dataCompleted: (json['data_completed'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ClientToJson(Client instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'gender': instance.gender,
      'birthdate': instance.birthdate,
      'mobile': instance.mobile,
      'national_id': instance.nationalId,
      'national_id_type_id': instance.nationalIdTypeId,
      'active': instance.active,
      'data_completed': instance.dataCompleted,
    };
