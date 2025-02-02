import 'package:dartz/dartz.dart';
import 'package:hollat/core/error/failure.dart';
import 'package:hollat/login/domain/entities/response/response.dart';
import 'package:hollat/login/domain/usecases/nafaz_send_verify_code_reposetory_use_case.dart';

abstract class BaseNafazSendVerifyCodeRepository{
  Future<Either<Failure, Response>> nafazSendVerifyCode(ResponseParameters parameters);
}