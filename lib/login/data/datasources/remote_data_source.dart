import 'package:hollat/core/error/error_message_model.dart';
import 'package:hollat/core/error/server_exception.dart';
import 'package:hollat/login/data/datasources/base_nafaz_send_verify_code_remote_data_source.dart';
import 'package:hollat/login/data/models/response/response_model.dart';
import 'package:hollat/login/domain/usecases/nafaz_send_verify_code_reposetory_use_case.dart';
import 'package:hollat/main/riverpod/api_client.dart';

class NafazSendVerifyCodeRemoteDataSource
    extends BaseNafazSendVerifyCodeRemoteDataSource {
  final ApiClient _apiClient;

  NafazSendVerifyCodeRemoteDataSource(this._apiClient);

  @override
  Future<ResponseModel> nafazSendVerifyCode(
      ResponseParameters parameters) async {
    final response = await _apiClient.request(
        path: 'api/mobile/reload-captcha', method: 'GET');
    try {
      return ResponseModel.fromJson(response.data);
    } on ServerException catch (failure) {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }
}
