import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hollat/main/riverpod/api_client.dart';
import 'package:hollat/main/riverpod/app_config.dart';

final dioProvider = Provider<Dio>((ref) {
  final config = ref.read(appConfigProvider);
  final dio = Dio(BaseOptions(
      baseUrl: config.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10)
  ));

  // Add interceptors
  dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true
  ));
  //SSL/ TLS configration
  ref.onDispose(() async {
    dio.close();
  });
  return dio;
});

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(ref.read(dioProvider));
});