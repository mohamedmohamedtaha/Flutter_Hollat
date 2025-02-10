import 'package:equatable/equatable.dart';

class VerifyEmailAfterSelfServiceLoginEnabled extends Equatable {
  final String? value;

  const VerifyEmailAfterSelfServiceLoginEnabled({required this.value});

  @override
  List<Object?> get props => [value];
}