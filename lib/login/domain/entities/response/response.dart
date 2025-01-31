import 'package:equatable/equatable.dart';

class Response extends Equatable {
  final String status;
  final String message;
  final dynamic data;

  Response({required this.status, required this.message, required this.data});

  @override
  List<Object> get props => [status, message, data];
}