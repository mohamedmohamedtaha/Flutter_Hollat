import 'package:equatable/equatable.dart';

class VerifyEmailAfterSelfServiceLoginRequired extends Equatable {
  final String value;

 const VerifyEmailAfterSelfServiceLoginRequired({required this.value});

  @override
  List<Object> get props => [value];
}