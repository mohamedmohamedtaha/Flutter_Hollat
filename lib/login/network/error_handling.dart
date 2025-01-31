
import 'package:dio/dio.dart';

abstract class AppException implements Exception{
  final String message;
  final StackTrace? stackTrace;
  AppException(this.message,[this.stackTrace]);
}
class NetworkException extends AppException {
   NetworkException(super.message, [super.stackTrace]); // Add const
}

class ApiException extends AppException{
  final int? statusCode;
  final Response? response;
  ApiException({this.statusCode,
  this.response,
  String? message}): super(message ?? 'API ERROR');
}
class CancelledException extends AppException{
  CancelledException():super('Request cancelled');
}