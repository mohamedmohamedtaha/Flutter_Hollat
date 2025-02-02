import 'package:equatable/equatable.dart';
import 'package:hollat/login/domain/entities/login_response/login_response.dart';

class LoginResponseModel extends LoginResponse {
  const LoginResponseModel(
      {super.token,
        required super.identityServerToken,
        required super.nationalIdType});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        token: json['token'] ?? '',
        identityServerToken: json['IdentityServerToken'],
        nationalIdType: json['national_id_type'],
      );
}

class LoginResponseParameters extends Equatable {
  final String mobile;
  final String otpCode;
  final String nationalId;

  const LoginResponseParameters({required this.otpCode, required this.mobile,required this.nationalId});

  @override
  List<Object> get props => [mobile, otpCode,nationalId];
}
