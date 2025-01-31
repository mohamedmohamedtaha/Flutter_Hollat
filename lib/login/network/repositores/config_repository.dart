import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hollat/login/data/models/configresponse/service_config_response_model.dart';
import 'package:hollat/login/domain/entities/config_response/service_config_response.dart';
import 'package:hollat/login/network/repositores/parse_response.dart';
import 'package:hollat/main/riverpod/api_client.dart';
import 'package:hollat/main/riverpod/dio_providers.dart';


class ConfigRepository {
  final ApiClient _apiClient;
  ConfigRepository(this._apiClient);
  Future<ServiceConfigResponse> fetchConfig() async {
      final response = await _apiClient.request(
          path: 'api/mobile/self_service_configs', method : 'GET');
      return parseResponse<ServiceConfigResponse>(response,ServiceConfigResponseModel.fromJson);
  }
}