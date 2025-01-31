import 'package:hollat/core/error/error_message_model.dart';

class ServerException implements Exception{
  final ErrorMessageModel errorMessageModel;

  const ServerException({required this.errorMessageModel});
}
class DatabaseException implements Exception{
  final String message;

  const DatabaseException({required this.message});
}