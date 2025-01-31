import 'package:equatable/equatable.dart';

class MaintenanceMode extends Equatable {
  final String value;

  MaintenanceMode({required this.value});

  @override
  List<Object> get props => [value];
}