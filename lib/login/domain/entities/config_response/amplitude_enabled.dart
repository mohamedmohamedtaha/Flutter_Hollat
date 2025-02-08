import 'package:equatable/equatable.dart';

class AmplitudeEnabled extends Equatable {
  final String value;

  const AmplitudeEnabled({required this.value});

  @override
  List<Object> get props => [value];


}