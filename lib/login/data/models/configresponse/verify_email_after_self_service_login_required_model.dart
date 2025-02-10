import 'package:hollat/login/domain/entities/config_response/verify_email_after_self_service_login_required.dart';

class VerifyEmailAfterSelfServiceLoginRequiredModel extends VerifyEmailAfterSelfServiceLoginRequired{
 const VerifyEmailAfterSelfServiceLoginRequiredModel({required super.value});
 factory VerifyEmailAfterSelfServiceLoginRequiredModel.fromJson(
     Map<String, dynamic> json) =>
     VerifyEmailAfterSelfServiceLoginRequiredModel(value: json['value']);
}