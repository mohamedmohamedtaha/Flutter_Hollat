import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hollat/core/init/gen/translations.g.dart';

abstract class AppException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  AppException(this.message, [this.stackTrace]);
}

class NetworkException extends AppException {
  NetworkException(super.message, [super.stackTrace]); // Add const
}

class ApiException extends AppException {
  final int? statusCode;
  final Response? response;

  ApiException({this.statusCode, this.response, String? message})
      : super(message ?? LocaleKeys.apiError.tr());
}

class CancelledException extends AppException {
  CancelledException() : super('Request cancelled');
}
