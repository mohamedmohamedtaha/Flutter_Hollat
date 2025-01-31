import 'package:hollat/login/domain/entities/config_response/logo.dart';

class LogoModel extends Logo{
  LogoModel({required super.value});
  factory LogoModel.fromJson(Map<String, dynamic>json)=> LogoModel(value: json['value'] as String);
  Map<String,dynamic>toJson(LogoModel model)=> <String,dynamic>{'value': model.value};
}