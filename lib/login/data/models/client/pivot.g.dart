// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pivot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pivot _$PivotFromJson(Map<String, dynamic> json) => Pivot(
      clientId: (json['client_id'] as num).toInt(),
      createdAt: json['created_at'] as String,
      creationDate: json['creation_date'],
      expirationDate: json['expiration_date'],
      fileNumber: (json['file_number'] as num).toInt(),
      hospitalId: (json['hospital_id'] as num).toInt(),
      id: (json['id'] as num).toInt(),
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$PivotToJson(Pivot instance) => <String, dynamic>{
      'client_id': instance.clientId,
      'created_at': instance.createdAt,
      'creation_date': instance.creationDate,
      'expiration_date': instance.expirationDate,
      'file_number': instance.fileNumber,
      'hospital_id': instance.hospitalId,
      'id': instance.id,
      'updated_at': instance.updatedAt,
    };
