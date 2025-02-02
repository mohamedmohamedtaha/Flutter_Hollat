import 'package:hollat/login/domain/entities/send_otp/send_otp.dart';

class SendOtpModel extends SendOtp {
  const SendOtpModel({required super.capatchaCode,
    required super.key,
    required super.mobile,
    required super.nationalId});

  factory SendOtpModel.fromJdon(Map<String, dynamic> json) =>
      SendOtpModel(
          capatchaCode: json['captcha_code'],
          key: json['key'],
          mobile: json['mobile'],
          nationalId: json['nationalId']);

  @override
  List<Object> get props => [key,mobile,nationalId];
}
