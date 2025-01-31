import 'package:equatable/equatable.dart';

class NafazEnabled extends Equatable {
  final String value;

  NafazEnabled({required this.value});

  @override
  List<Object> get props => [value];
}