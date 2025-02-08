import 'package:hollat/login/domain/entities/config_response/amplitude_enabled.dart';
class AmplitudeEnabledModel extends   AmplitudeEnabled
{
  const AmplitudeEnabledModel({required super.value});

  factory AmplitudeEnabledModel.fromJson(Map<String, dynamic> json) =>
      AmplitudeEnabledModel(
        value: json['value'] as String
      );

  Map<String, dynamic> toJson(AmplitudeEnabledModel model) => <String, dynamic>{'value': model.value};
}