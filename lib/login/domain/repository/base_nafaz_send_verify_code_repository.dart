import 'package:dartz/dartz.dart';
import 'package:hollat/core/error/failure.dart';
import 'package:hollat/login/domain/entities/response/response.dart';

abstract class BaseNafazSendVerifyCodeRepository{
  Future<Either<Failure, Response>> nafazSendVerifyCode(String mobile, String email);
}