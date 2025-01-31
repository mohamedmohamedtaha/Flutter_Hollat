import 'package:dartz/dartz.dart';
import 'package:hollat/core/error/failure.dart';
import 'package:hollat/core/error/server_exception.dart';
import 'package:hollat/login/data/datasources/base_remote_data_source.dart';
import 'package:hollat/login/data/models/response/response_model.dart';
import 'package:hollat/main/riverpod/api_client.dart';

class RemoteDataSource extends BaseRemoteDataSource{
  final ApiClient _apiClient;

  RemoteDataSource(this._apiClient);

  @override
  Future<Either<Failure, ResponseModel>> nafazSendVerifyCode(String mobile, String email)async {
      final response = await _apiClient.request(
          path: 'api/mobile/reload-captcha', method : 'GET');
      try{
        return Right(response.data);
      }on ServerException catch(failure){
        return Left(ServerFailure(failure.errorMessageModel.message));
      }
    }

}