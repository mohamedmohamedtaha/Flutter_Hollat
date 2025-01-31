import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class Logo extends Equatable {
  final String value;

  Logo({required this.value});

  @override
  List<Object> get props => [value];
}