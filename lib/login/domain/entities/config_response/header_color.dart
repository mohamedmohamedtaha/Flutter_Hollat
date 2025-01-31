import 'package:equatable/equatable.dart';

class HeaderColor extends Equatable {
  final String value;

  HeaderColor({required this.value});

  @override
  List<Object> get props => [value];
}