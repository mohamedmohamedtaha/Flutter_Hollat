import 'package:equatable/equatable.dart';

class SendOtp extends Equatable {
  final String capatchaCode;
  final String key;
  final String mobile;
  final String nationalId;

  const SendOtp({required this.capatchaCode, required this.key, required this.mobile, required this.nationalId});

  @override
  List<Object> get props => [capatchaCode, key, mobile, nationalId];
}