
import 'package:hollat/login/domain/entities/config_response/min_chars_on_details.dart';

class MinCharsOnDetailsModel extends MinCharsOnDetails{
  const MinCharsOnDetailsModel({required super.value});

  factory MinCharsOnDetailsModel.fromJson(Map<String, dynamic> json) =>
      MinCharsOnDetailsModel(
        value: json['value'] as String,
      );

  Map<String, dynamic> toJson(MinCharsOnDetailsModel instance) =>
      <String, dynamic>{
        'value': instance.value,
      };
}