import 'package:dartz/dartz.dart';
import 'package:hollat/core/error/failure.dart';
import 'package:hollat/core/error/server_exception.dart';
import 'package:hollat/login/data/datasources/base_nafaz_send_verify_code_remote_data_source.dart';
import 'package:hollat/login/domain/entities/response/response.dart';
import 'package:hollat/login/domain/repository/base_nafaz_send_verify_code_repository.dart';
import 'package:hollat/login/domain/usecases/nafaz_send_verify_code_reposetory_use_case.dart';

class NafazSendVerifyCodeRepoitory extends BaseNafazSendVerifyCodeRepository{

  final BaseNafazSendVerifyCodeRemoteDataSource baseNafazSendVerifyCodeRemoteDataSource;

  NafazSendVerifyCodeRepoitory(this.baseNafazSendVerifyCodeRemoteDataSource);

  @override
  Future<Either<Failure, Response>> nafazSendVerifyCode(ResponseParameters parameters)async {
      final result = await baseNafazSendVerifyCodeRemoteDataSource.nafazSendVerifyCode(parameters);
      try{
        return Right(result);
      }on ServerException catch(failure){
        return Left(ServerFailure(failure.errorMessageModel.message));
      }
  }
}