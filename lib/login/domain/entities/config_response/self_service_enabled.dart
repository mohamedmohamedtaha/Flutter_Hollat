import 'package:equatable/equatable.dart';

class SelfServiceEnabled extends Equatable {
  final String value;

  SelfServiceEnabled({required this.value});

  @override
  List<Object> get props => [value];
}