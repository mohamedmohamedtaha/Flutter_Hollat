import 'package:equatable/equatable.dart';

class ClientName extends Equatable {
  final String value;

  const ClientName({required this.value});

  @override
  List<Object> get props => [value];
}