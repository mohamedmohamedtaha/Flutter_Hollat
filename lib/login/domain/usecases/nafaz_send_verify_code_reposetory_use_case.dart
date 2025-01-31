import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:hollat/core/error/failure.dart';
import 'package:hollat/login/domain/entities/response/response.dart';
import 'package:hollat/login/domain/repository/base_nafaz_send_verify_code_repository.dart';

class NafazSendVerifyCodeReposetoryUseCase {
  final BaseNafazSendVerifyCodeRepository nafazSendVerifyCodeRepositoryBase;
  NafazSendVerifyCodeReposetoryUseCase(this.nafazSendVerifyCodeRepositoryBase);
  
  Future<Either<Failure, Response>>excecute(String mobile, String email) async{
    return await nafazSendVerifyCodeRepositoryBase.nafazSendVerifyCode(mobile, email);
  }

}