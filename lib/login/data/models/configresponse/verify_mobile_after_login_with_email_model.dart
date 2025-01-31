import 'package:hollat/login/domain/entities/config_response/verify_mobile_after_login_with_email.dart';

class VerifyMobileAfterLoginWithEmailModel
    extends VerifyMobileAfterLoginWithEmail {
  VerifyMobileAfterLoginWithEmailModel({required super.value});

  factory VerifyMobileAfterLoginWithEmailModel.fromJson(
      Map<String, dynamic> json) =>
      VerifyMobileAfterLoginWithEmailModel(value: json['value']);
}
