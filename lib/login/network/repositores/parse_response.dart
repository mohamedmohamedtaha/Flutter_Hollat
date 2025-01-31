import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:hollat/login/network/error_handling.dart';

  T parseResponse<T>(Response response,
      T Function (Map<String,dynamic>)fromJson) {
    if (response.statusCode == 200) {
      final jsonData = _ensureJson(response.data);
      return fromJson(jsonData);
    }
    throw ApiException(statusCode: response.statusCode);
  }
  dynamic _ensureJson(dynamic data){
    if(data is String){
      // final sanitizedJson = data
      //     .replaceAllMapped(RegExp(r'(\w+):'), (m) => '"${m[1]}":')
      //     .replaceAll(RegExp(r'\"'), '"');
      return jsonDecode(data);
    }
    // else if (data is Map) {
    //   // Already parsed JSON
    //   return data as Map<String, dynamic>;
    // }
    return data;
  }