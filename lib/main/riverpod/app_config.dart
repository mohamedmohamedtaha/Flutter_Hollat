import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppConfig{
  final String baseUrl;
  AppConfig({required this.baseUrl});
}
final appConfigProvider = Provider<AppConfig>((ref){
  return AppConfig(baseUrl:
  kDebugMode ? 'https://back-dev.hollat.net/hollat_upgrade_develop/public/' ////Test Url
      : 'https://back-dev.hollat.net/hollat_upgrade_develop/public/api/mobile/self_service_configs' //Production Url
  );
});