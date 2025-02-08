 import 'package:hollat/login/domain/entities/config_response/self_service_enabled.dart';

class SelfServiceEnabledModel extends SelfServiceEnabled{
  const SelfServiceEnabledModel({required super.value});
  factory SelfServiceEnabledModel.fromJson(Map<String, dynamic> json) =>
      SelfServiceEnabledModel(
        value: json['value'] as String,
      );

  Map<String, dynamic> toJson(SelfServiceEnabledModel instance) =>
      <String, dynamic>{
        'value': instance.value,
      };

}