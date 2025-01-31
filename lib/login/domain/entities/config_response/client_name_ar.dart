import 'package:equatable/equatable.dart';

class ClientNameAr extends Equatable {
  final String value;

  ClientNameAr({required this.value});

  @override
  List<Object> get props => [value];
}