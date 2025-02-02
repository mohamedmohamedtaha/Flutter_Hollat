import 'package:equatable/equatable.dart';

class ErrorResponse extends Equatable {
  final String? message;
   final Map<String, List<String>>? errors;
//  final List<String>? errors;

  const ErrorResponse({required this.message, required this.errors});

  @override
  List<Object?> get props => [message, errors];
}