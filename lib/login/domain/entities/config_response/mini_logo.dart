import 'package:equatable/equatable.dart';

class MiniLogo extends Equatable {
  final String value;

  const MiniLogo({required this.value});

  @override
  List<Object> get props => [value];
}