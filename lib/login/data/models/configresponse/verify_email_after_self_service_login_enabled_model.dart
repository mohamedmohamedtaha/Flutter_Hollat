 import 'package:hollat/login/domain/entities/config_response/verify_email_after_self_service_login_enabled.dart';

class VerifyEmailAfterSelfServiceLoginEnabledModel extends VerifyEmailAfterSelfServiceLoginEnabled{
 const VerifyEmailAfterSelfServiceLoginEnabledModel({required super.value});
 factory VerifyEmailAfterSelfServiceLoginEnabledModel.fromJson(
     Map<String, dynamic> json) =>
     VerifyEmailAfterSelfServiceLoginEnabledModel(value: json['value']);
}