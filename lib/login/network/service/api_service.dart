import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hollat/login/data/models/nafath/nafath_response.dart';
import 'package:hollat/login/network/network_result.dart';


enum DioMethod { post, get, put, delete }

class ApiService {
  ApiService._singleton();

  static final ApiService instance = ApiService._singleton();

  // Future<Response?> request(
  //     String endpoint,
  //     DioMethod method, {
  //       Map<String, dynamic>? param,
  //       String? contentType,
  //       formData,
  //     }) async {
  //   try {
  //     final dio = Dio(BaseOptions(
  //         baseUrl: basUrl,
  //         contentType: contentType ?? Headers.formUrlEncodedContentType,
  //         headers: {
  //           // HttpHeaders.authorizationHeader:'Bearer $token',// if need
  //         }));
  //     // Accept all certificates (not safe for production)
  //     // (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
  //     // HttpClient()
  //     //   ..badCertificateCallback =
  //     //       (X509Certificate cert, String host, int port) => true;
  //
  //     // Load the certificate
  //     final sslCert =
  //     await rootBundle.load('assets/certificates/back-dev.hollat.crt');
  //     dio.httpClientAdapter = IOHttpClientAdapter()
  //       ..createHttpClient = () {
  //         final securitContext = SecurityContext();
  //         securitContext
  //             .setTrustedCertificatesBytes(sslCert.buffer.asUint8List());
  //         return HttpClient(context: securitContext);
  //       };
  //     switch (method) {
  //       case DioMethod.post:
  //         return dio.post(endpoint, data: param ?? formData);
  //       case DioMethod.get:
  //         return dio.get(endpoint, queryParameters: param);
  //       case DioMethod.put:
  //         return dio.put(endpoint, data: param ?? formData);
  //       case DioMethod.delete:
  //         dio.delete(endpoint, data: param ?? formData);
  //     }
  //   } catch (e) {
  //     throw Exception('Network Error');
  //   }
  // }


  // Future<dynamic> reloadCaptcha() async {
  //   try {
  //     final Response? response = await ApiService.instance.request(
  //         'api/mobile/reload-captcha', DioMethod.get,
  //         contentType: 'application/json');
  //     if (response != null && response.statusCode == 200) {
  //       print('API call successful: ${response.data}');
  //       dynamic responseData = response.data;
  //       if (responseData is String) {
  //         final sanitizedJson = responseData
  //             .replaceAllMapped(RegExp(r'(\w+):'), (m) => '"${m[1]}":')
  //             .replaceAll(RegExp(r'\"'), '"');
  //         return Captcha.fromJson(jsonDecode(sanitizedJson));
  //       } else if (responseData is Map) {
  //         // Already parsed JSON
  //         return Captcha.fromJson(responseData as Map<String, dynamic>);
  //       }
  //       return Captcha.fromJson(jsonDecode(response.data));
  //     } else {
  //       print('API call failed: ${response}');
  //     }
  //   } catch (e) {
  //     print('Network error occurred: $e');
  //   }
  // }

  // Future<dynamic> getAllNationalTypes() async {
  //   try {
  //     final Response? response = await ApiService.instance.request(
  //         'api/mobile/all-national-types', DioMethod.get,
  //         contentType: 'application/json');
  //     if (response != null && response.statusCode == 200) {
  //       print('API call successful: ${response.data}');
  //       dynamic responseData = response.data;
  //       if (responseData is String) {
  //         final sanitizedJson = responseData
  //             .replaceAllMapped(RegExp(r'(\w+):'), (m) => '"${m[1]}":')
  //             .replaceAll(RegExp(r'\"'), '"');
  //         return NationalTypesResponse.fromJson(jsonDecode(sanitizedJson));
  //       } else if (responseData is Map) {
  //         // Already parsed JSON
  //         return NationalTypesResponse.fromJson(
  //             responseData as Map<String, dynamic>);
  //       }
  //       return NationalTypesResponse.fromJson(jsonDecode(response.data));
  //     } else {
  //       print('API call failed: ${response}');
  //     }
  //   } catch (e) {
  //     print('Network error occurred: $e');
  //   }
  // }

  // Future<NetworkResult<NafathResponse>> nafath(String id) async {
  //   try {
  //     final Map<String, dynamic> requestBody = {
  //       'id': id,
  //       // Add other parameters if needed
  //     };
  //     final Duration _timeoutDuration = const Duration(seconds: 10);
  //     final Response? response = await ApiService.instance
  //         .request('api/mobile/nafath', DioMethod.post,
  //         contentType: 'application/json', param: requestBody)
  //         .timeout(_timeoutDuration, onTimeout: () {
  //       throw TimeoutException('Connection time out');
  //     });
  //     if (response == null) {
  //       return const Error(500, 'Null response recieved');
  //     }
  //     return switch(response.statusCode){
  //       200 => Success(NafathResponse.fromJson(json.decode(response.data))),
  //       _ =>
  //           Error(response.statusCode ?? 500,
  //               response.statusMessage ?? 'Unknown error')
  //     };
  //   } on DioException catch (e) {
  //     return _handleDioError(e);
  //   } on TimeoutException catch (e) {
  //     return NetworkException(TimeoutException('Connection timeout'));
  //   }catch (e) {
  //     return const Error(500, 'Catch error ');
  //   }
  // }

NetworkResult<NafathResponse> _handleDioError(DioException e) {
  if (e.response != null) {
    return Error(
      e.response!.statusCode ?? 500,
      e.response?.statusMessage ?? 'Dio error: ${e.message}',
    );
  }
  return switch (e.type) {
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout =>
        NetworkException(TimeoutException('Connection timeout')),
    _ => NetworkException(e),
  };
}
  // Future<NetworkResult<>> sendOtp() async {
  //   try {
  //     final Duration _timeoutDuration = const Duration(seconds: 10);
  //     final Response? response = await ApiService.instance
  //         .request('api/mobile/sendOtp', DioMethod.post,
  //         contentType: 'application/json')
  //         .timeout(_timeoutDuration, onTimeout: () {
  //       throw TimeoutException('Connection time out');
  //     });
  //     if (response == null) {
  //       return const Error(500, 'Null response recieved');
  //     }
  //     return switch(response.statusCode){
  //       200 => Success(NafathResponse.fromJson(json.decode(response.data))),
  //       _ =>
  //           Error(response.statusCode ?? 500,
  //               response.statusMessage ?? 'Unknown error')
  //     };
  //   } on DioException catch (e) {
  //     _handleDioError(e);
  //   } on TimeoutException catch (e) {
  //   //  return NetworkException(e);
  //   }catch (e) {
  //     print('Network error occurred: $e');
  //   }
  // }





  // NetworkResult<NafathResponse> _handleDioError(DioException e) {
  //   if (e.response != null) {
  //     return Error(
  //       e.response!.statusCode ?? 500,
  //       e.response?.statusMessage ?? 'Dio error',
  //     );
  //   }
  //   return switch (e.type) {
  //     DioExceptionType.connectionTimeout ||
  //     DioExceptionType.sendTimeout ||
  //     DioExceptionType.receiveTimeout =>
  //         NetworkException(TimeoutException('Connection timeout')),
  //     _ => NetworkException(e),
  //   };
  // }
  void _handleResponse(Map<String, dynamic> response) {
    if (response['status'] == 'success') {
  //    _showSnackBar('Welcome ${response['user_name']}');
    } else {
  //    _showSnackBar(response['message'] ?? 'Unknown error occurred');
    }
  }

  void _handleDioErrort(DioException e) {
    String errorMessage = 'An error occurred';

    if (e.response != null) {
      // The request was made and the server responded with a status code
      final statusCode = e.response?.statusCode;
      final errorData = e.response?.data;

      switch (statusCode) {
        case 400:
          errorMessage = errorData['message'] ?? 'Bad request';
          break;
        case 401:
          errorMessage = 'Unauthorized access';
          break;
        case 404:
          errorMessage = 'User not found';
          break;
        case 500:
          errorMessage = 'Server error';
          break;
        default:
          errorMessage = 'Error: $statusCode';
      }
    } else {
      // Error occurred before getting response (timeout, cancellation, etc.)
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          errorMessage = 'Connection timeout';
          break;
        case DioExceptionType.sendTimeout:
          errorMessage = 'Send timeout';
          break;
        case DioExceptionType.receiveTimeout:
          errorMessage = 'Receive timeout';
          break;
        case DioExceptionType.badCertificate:
          errorMessage = 'Bad certificate';
          break;
        case DioExceptionType.badResponse:
          errorMessage = 'Bad response';
          break;
        case DioExceptionType.cancel:
          errorMessage = 'Request canceled';
          break;
        case DioExceptionType.connectionError:
          errorMessage = 'Connection error';
          break;
        case DioExceptionType.unknown:
          errorMessage = 'Unknown error: ${e.message}';
          break;
      }
    }

 //   _showSnackBar(errorMessage);
  }

  // void _showSnackBar(String message) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text(message)),
  //   );
  // }
}
