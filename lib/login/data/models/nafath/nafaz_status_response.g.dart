// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nafaz_status_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NafazStatusResponse _$NafazStatusResponseFromJson(Map<String, dynamic> json) =>
    NafazStatusResponse(
      client: json['client'] == null
          ? null
          : Client.fromJson(json['client'] as Map<String, dynamic>),
      status: json['status'] as String,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$NafazStatusResponseToJson(
        NafazStatusResponse instance) =>
    <String, dynamic>{
      if (instance.client?.toJson() case final value?) 'client': value,
      'status': instance.status,
      if (instance.token case final value?) 'token': value,
    };
