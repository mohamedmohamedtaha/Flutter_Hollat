import 'package:equatable/equatable.dart';

class CreateAccount extends Equatable {
  final String key;
  final String capatchaCode;
  final String nationalId;
  final String name;
  final String mobile;
  final String email;
  final String birthDay;
  final String nationalIdTypeId;

  const CreateAccount({required this.key,required this.capatchaCode,required this.nationalId,required this.name, required this.mobile,
    required this.email,required this.birthDay,required this.nationalIdTypeId});

  @override
  List<Object> get props =>
      [
        key,
        capatchaCode,
        nationalId,
        name,
        mobile,
        email,
        birthDay,
        nationalIdTypeId,
      ];
}