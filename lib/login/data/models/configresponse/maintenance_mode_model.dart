
import 'package:hollat/login/domain/entities/config_response/maintenance_mode.dart';

class MaintenanceModeModel extends MaintenanceMode{
  const MaintenanceModeModel({required super.value});

  factory MaintenanceModeModel.fromJson(Map<String, dynamic> json) =>
      MaintenanceModeModel(
        value: json['value'] as String,
      );

  Map<String, dynamic> toJson(MaintenanceModeModel instance) =>
      <String, dynamic>{
        'value': instance.value,
      };

}