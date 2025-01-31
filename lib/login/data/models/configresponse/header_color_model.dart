import 'package:hollat/login/domain/entities/config_response/header_color.dart';

class HeaderColorModel extends HeaderColor {
  HeaderColorModel({required super.value});

  factory HeaderColorModel.fromJson(Map<String, dynamic> json) =>
      HeaderColorModel(value: json['value'] as String);

  Map<String, dynamic> toJson(HeaderColorModel model) =>
      <String, dynamic>{'value': model.value};
}
