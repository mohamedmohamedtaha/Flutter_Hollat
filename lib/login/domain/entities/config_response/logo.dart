import 'package:equatable/equatable.dart';

class Logo extends Equatable {
  final String value;

  const Logo({required this.value});

  @override
  List<Object> get props => [value];
}