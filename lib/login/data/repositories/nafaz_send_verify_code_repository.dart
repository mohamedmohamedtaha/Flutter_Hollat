import 'package:dartz/dartz.dart';
import 'package:hollat/core/error/failure.dart';
import 'package:hollat/core/error/server_exception.dart';
import 'package:hollat/login/domain/entities/response/response.dart';
import 'package:hollat/login/domain/repository/base_nafaz_send_verify_code_repository.dart';

class NafazSendVerifyCodeRepoitory {

  //   extends BaseNafazSendVerifyCodeRepository{
  // final BaseNafazSendVerifyCodeRepository baseNafazSendVerifyCodeRepository;
  // NafazSendVerifyCodeRepoitory(this.baseNafazSendVerifyCodeRepository);
  // @override
  // Future<Either<Failure, Response>> nafazSendVerifyCode(String mobile, String email) async{
  //   final result = await baseNafazSendVerifyCodeRepository.nafazSendVerifyCode(mobile, email);
  //   try{
  //     return Right();
  //   }on ServerException catch(failure){
  //     return Left(ServerFailure(failure.errorMessageModel.message));
  //   }
  // }

}