import 'package:hollat/login/domain/entities/config_response/self_service_otp_by.dart';

class SelfServiceOtpByModel extends SelfServiceOtpBy {
  SelfServiceOtpByModel({required super.value});

  factory SelfServiceOtpByModel.fromJson(Map<String, dynamic> json) =>
      SelfServiceOtpByModel(value: json['value']);

}
