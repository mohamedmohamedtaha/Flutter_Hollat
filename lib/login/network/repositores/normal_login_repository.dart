
import 'package:dartz/dartz.dart';
import 'package:hollat/core/error/failure.dart';
import 'package:hollat/core/error/server_exception.dart';
import 'package:hollat/login/data/models/nafath/nafath_response.dart';
import 'package:hollat/login/data/models/nafath/nafaz_status.dart';
import 'package:hollat/login/data/models/nafath/nafaz_status_response.dart';
import 'package:hollat/login/data/models/nationaltypes/national_types_response.dart';
import 'package:hollat/login/data/models/reloadcaptcha/captcha.dart';
import 'package:hollat/login/network/repositores/parse_response.dart';
import 'package:hollat/main/riverpod/api_client.dart';

class NormalLoginRepository {
  final ApiClient _apiClient;

  NormalLoginRepository(this._apiClient);

  Future<Either<Failure,Captcha>> reloadCaptcha() async {
    final response = await _apiClient.request(
        path: 'api/mobile/reload-captcha', method : 'GET');
    try{

     // return Right(parseResponse<Captcha>(response,Captcha.fromJson));
      return Right(response.data);
    }on ServerException catch(failure){
      return Left(ServerFailure(failure.errorMessageModel.message));
    }
  }
  Future<NationalTypesResponse> getAllNationalTypes() async {
    final response = await _apiClient.request(
        path: 'api/mobile/all-national-types', method : 'GET');
    // response.data
    return parseResponse<NationalTypesResponse>(response,NationalTypesResponse.fromJson);
  }

  Future<NafathResponse>  nafath(String id) async {
        final Map<String, dynamic> requestBody = {
          'id': id,
          // Add other parameters if needed
        };
    final response = await _apiClient.request(
        path: 'api/mobile/nafath', method : 'POST',queryParameters: requestBody);
    return parseResponse<NafathResponse>(response,NafathResponse.fromJson);
  }

  Future<NafazStatusResponse>  nafathStatus(NafazStatus nafazStatus) async {
    final Map<String, dynamic> requestBody = {
      'id': nafazStatus.id,
      'random': nafazStatus.random,
      'transId': nafazStatus.transId,
      // Add other parameters if needed
    };
    final response = await _apiClient.request(
        path: 'api/mobile/nafath_status', method : 'POST',queryParameters: requestBody);
    return parseResponse<NafazStatusResponse>(response,NafazStatusResponse.fromJson);
  }

}