
import 'package:hollat/login/domain/entities/config_response/mini_logo.dart';

class MiniLogoModel extends MiniLogo{
  MiniLogoModel({required super.value});

  factory MiniLogoModel.fromJson(Map<String, dynamic> json) => MiniLogoModel(
    value: json['value'] as String,
  );

  Map<String, dynamic> toJson(MiniLogoModel instance) => <String, dynamic>{
    'value': instance.value,
  };

}