import 'package:equatable/equatable.dart';

class Response extends Equatable {
  final String? status;
  final String? message;
  final dynamic data;

  const Response(
      {this.status, this.message, required this.data});

  @override
  List<Object?> get props => [status, message, data];

}