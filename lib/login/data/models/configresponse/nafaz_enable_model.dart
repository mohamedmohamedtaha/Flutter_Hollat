 import 'package:hollat/login/domain/entities/config_response/nafaz_enable.dart';

class NafazEnabledModel extends NafazEnabled{
  const NafazEnabledModel({required super.value});
  factory NafazEnabledModel.fromJson(Map<String, dynamic> json) =>
      NafazEnabledModel(
        value: json['value'] as String,
      );

  Map<String, dynamic> toJson(NafazEnabledModel instance) =>
      <String, dynamic>{
        'value': instance.value,
      };
 }