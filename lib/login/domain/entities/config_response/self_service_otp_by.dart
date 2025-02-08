import 'package:equatable/equatable.dart';

class SelfServiceOtpBy extends Equatable {
  final String value;

  const SelfServiceOtpBy({required this.value});

  @override
  List<Object> get props => [value];
}