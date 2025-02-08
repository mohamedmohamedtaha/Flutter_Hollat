
import 'package:hollat/core/global/url.dart';
import 'package:hollat/login/data/models/login_response/login_response_model.dart';
import 'package:hollat/login/data/models/nafath/nafath_response.dart';
import 'package:hollat/login/data/models/nafath/nafaz_status.dart';
import 'package:hollat/login/data/models/nafath/nafaz_status_response.dart';
import 'package:hollat/login/data/models/nationaltypes/national_types_response.dart';
import 'package:hollat/login/data/models/reloadcaptcha/captcha.dart';
import 'package:hollat/login/data/models/response/response_model.dart';
import 'package:hollat/login/data/models/send_otp/send_otp_model.dart';
import 'package:hollat/login/domain/entities/create_account/create_account.dart';
import 'package:hollat/login/domain/usecases/nafaz_send_verify_code_reposetory_use_case.dart';
import 'package:hollat/login/network/repositores/parse_response.dart';
import 'package:hollat/main/riverpod/api_client.dart';

class NormalLoginRepository {
  final ApiClient _apiClient;

  NormalLoginRepository(this._apiClient);

  // Future<Either<Failure,Captcha>> reloadCaptcha() async {
  //   final response = await _apiClient.request(
  //       path: Url.reloadCaptcha, method : 'GET');
  //   try{
  //
  //    // return Right(parseResponse<Captcha>(response,Captcha.fromJson));
  //     return Right(Captcha.fromJson(response.data));
  //   }on ServerException catch(failure){
  //     return Left(ServerFailure(failure.errorMessageModel.message));
  //   }
  // }

  Future<Captcha> reloadCaptcha() async {
    final response = await _apiClient.request(
        path: Url.reloadCaptcha, method : 'GET');


      // return Right(parseResponse<Captcha>(response,Captcha.fromJson));
      return parseResponse<Captcha>(response,Captcha.fromJson);

  }
  Future<NationalTypesResponse> getAllNationalTypes() async {
    final response = await _apiClient.request(
        path: Url.allNationalTypes, method : 'GET');
    // response.data
    return parseResponse<NationalTypesResponse>(response,NationalTypesResponse.fromJson);
  }

  Future<NafathResponse>  nafath(String id) async {
        final Map<String, dynamic> requestBody = {
          'id': id,
          // Add other parameters if needed
        };
    final response = await _apiClient.request(
        path: Url.nafaz, method : 'POST',queryParameters: requestBody);
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
        path: Url.nafazStatus, method : 'POST',queryParameters: requestBody);
    return parseResponse<NafazStatusResponse>(response,NafazStatusResponse.fromJson);
  }

  Future<ResponseModel>  nafazSendVerifyCode(ResponseParameters parameters) async {
    final Map<String, dynamic> requestBody = {
      'mobile': parameters.mobile,
      'email': parameters.email,
      // Add other parameters if needed
    };
    final response = await _apiClient.request(
        path: Url.sendVerifyCode, method : 'POST',queryParameters: requestBody,isAuthorize: true);
    return parseResponse<ResponseModel>(response,ResponseModel.fromJson);
  }

  Future<ResponseModel>  nafathVerifyMobile(LoginResponseParameters parameters) async {
    final Map<String, dynamic> requestBody = {
      'otp_code':parameters.otpCode,
      'mobile':parameters.mobile,
// Add other parameters if needed
    };
    final response = await _apiClient.request(
        path: Url.nafazVerifyMobile, method : 'POST',queryParameters: requestBody,isAuthorize: true);
    return parseResponse<ResponseModel>(response,ResponseModel.fromJson);
  }

  Future<ResponseModel>  verifyOtp(LoginResponseParameters parameters) async {
    final Map<String, dynamic> requestBody = {
      'otp_code':parameters.otpCode,
      'mobile':parameters.mobile,
      'national_id':parameters.nationalId
      // Add other parameters if needed
    };
    final response = await _apiClient.request(
        path: Url.verifyOtp, method : 'POST',queryParameters: requestBody);
    return parseResponse<ResponseModel>(response,ResponseModel.fromJson);
  }

  Future<ResponseModel>  sendOtp(SendOtpModel parameters) async {
    final Map<String, dynamic> requestBody = {
      'captcha_code':parameters.capatchaCode,
      'key':parameters.key,
      'mobile':parameters.mobile,
      'national_id':parameters.nationalId
      // Add other parameters if needed
    };
    final response = await _apiClient.request(
        path: Url.sendOtp, method : 'POST',queryParameters: requestBody);
    return parseResponse<ResponseModel>(response,ResponseModel.fromJson);
  }
  Future<ResponseModel>  createClient(CreateAccount parameters) async {
    final Map<String, dynamic> requestBody = {
      'key':parameters.key,
      'captcha_code':parameters.capatchaCode,
      'national_id':parameters.nationalId,
      'name':parameters.name,
      'mobile':parameters.mobile,
      'email':parameters.email,
      'birthdate':parameters.birthDay,
      'national_id_type_id':parameters.nationalIdTypeId,
      // Add other parameters if needed
    };
    final response = await _apiClient.request(
        path: Url.createClient, method : 'POST',queryParameters: requestBody);
    return parseResponse<ResponseModel>(response,ResponseModel.fromJson);
  }
}