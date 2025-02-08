import 'package:equatable/equatable.dart';

class MinCharsOnDetails extends Equatable {
  final String value;

  const MinCharsOnDetails({required this.value});

  @override
  List<Object> get props => [value];
}