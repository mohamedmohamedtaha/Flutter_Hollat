import 'package:equatable/equatable.dart';

class HeaderColor extends Equatable {
  final String value;

  const HeaderColor({required this.value});

  @override
  List<Object> get props => [value];
}