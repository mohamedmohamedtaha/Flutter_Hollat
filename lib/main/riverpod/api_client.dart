import 'package:dio/dio.dart';
import 'package:hollat/login/data/sharedpreferences/save_token.dart';
import 'package:hollat/login/network/error_handling.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(this._dio);

  Future<Response> request({required String path,
    required String method,
    dynamic data,
    Map<String, dynamic>? queryParameters, bool isAuthorize = false}) async {
    try {
      final token = await getToken();

      Options options = Options(
          method: method,
          headers:{
            if(isAuthorize)'Authorization': 'Bearer $token'
          }
      );
      // if method post
      options.contentType = Headers.formUrlEncodedContentType;
      final response = await _dio.request(path,
        data: data,
        queryParameters: queryParameters,
        options: options);
      //  return response;
      if (response.statusCode == 200) {
        return response;
      } else {
        throw ApiException(response: response.data);
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Never _handleDioError(DioException error) {
    print('error.type: ${error.type} response: ${error.response?.data.toString()} '
        'statusCode: ${error.response?.statusCode}');
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw CancelledException(); //NetworkException('Request timed out');
      case DioExceptionType.badResponse:
        throw ApiException(
          statusCode: error.response?.statusCode,
          message: error.response?.statusMessage,
          response: error.response,
        );
      case DioExceptionType.cancel:
        throw CancelledException();
      default:
        throw CancelledException(); //NetworkException('Network error occurred');
    }
  }
}
