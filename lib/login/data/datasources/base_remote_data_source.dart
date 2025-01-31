import 'package:dartz/dartz.dart';
import 'package:hollat/core/error/failure.dart';
import 'package:hollat/login/data/models/response/response_model.dart';

abstract class BaseRemoteDataSource{
  Future<Either<Failure,ResponseModel>> nafazSendVerifyCode(String mobile, String email);
}