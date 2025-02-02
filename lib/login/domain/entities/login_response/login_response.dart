import 'package:equatable/equatable.dart';

class LoginResponse extends Equatable {
  final String? token;
  final String identityServerToken;
  final String nationalIdType;

  const LoginResponse(
      {this.token, required this.identityServerToken, required this.nationalIdType});

  @override
  List<Object?> get props => [token, identityServerToken, nationalIdType];
}