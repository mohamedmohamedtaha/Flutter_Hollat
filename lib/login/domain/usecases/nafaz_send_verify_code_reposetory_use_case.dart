import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hollat/core/error/failure.dart';
import 'package:hollat/core/global/usecase/base_use_case.dart';
import 'package:hollat/login/domain/entities/response/response.dart';
import 'package:hollat/login/domain/repository/base_nafaz_send_verify_code_repository.dart';

class NafazSendVerifyCodeReposetoryUseCase
    extends BaseUseCase<Response, ResponseParameters> {
  final BaseNafazSendVerifyCodeRepository nafazSendVerifyCodeRepositoryBase;

  NafazSendVerifyCodeReposetoryUseCase(this.nafazSendVerifyCodeRepositoryBase);

  @override
  Future<Either<Failure, Response>> call(ResponseParameters parameters) async {
    return await nafazSendVerifyCodeRepositoryBase
        .nafazSendVerifyCode(parameters);
  }
}

class ResponseParameters extends Equatable {
  final String mobile;
  final String email;

  ResponseParameters({required this.mobile, required this.email});

  @override
  List<Object> get props => [mobile, email];
}
