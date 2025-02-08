import 'package:equatable/equatable.dart';

class VerifyMobileAfterLoginWithEmail extends Equatable {
  final String value;

  const VerifyMobileAfterLoginWithEmail({required this.value});

  @override
  List<Object> get props => [value];
}