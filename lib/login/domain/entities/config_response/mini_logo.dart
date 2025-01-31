import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class MiniLogo extends Equatable {
  final String value;

  MiniLogo({required this.value});

  @override
  List<Object> get props => [value];
}