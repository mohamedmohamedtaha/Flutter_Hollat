import 'package:equatable/equatable.dart';

class SelfServiceEnabled extends Equatable {
  final String value;

  const SelfServiceEnabled({required this.value});

  @override
  List<Object> get props => [value];
}