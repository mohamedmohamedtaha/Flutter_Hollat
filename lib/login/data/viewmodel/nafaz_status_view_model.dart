import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hollat/login/data/models/nafath/nafaz_status.dart';
import 'package:hollat/login/data/viewmodel/config_viewmodel.dart';
import 'package:hollat/login/network/error_handling.dart';
import 'package:hollat/login/network/repositores/normal_login_repository.dart';

class NafazStatusViewModel extends StateNotifier<ConfigState>{
  // final NafathResponse nafazResponse;
  final NormalLoginRepository repository;
  NafazStatusViewModel({required this.repository}) : super(ConfigInitial());
  Future<void> nafathStatus(NafazStatus nafazStatus) async {
    state = ConfigLoading();
    try {
      final nafazStatusResponse = await repository.nafathStatus(nafazStatus);
      state = ConfigSuccess(nafazStatusResponse);
    }on ApiException catch (e) {
      state = ConfigErrorApi(e.statusCode ?? 0,e.response);
    }
    on AppException catch (e) {
      state = ConfigError(e.message,e.hashCode);
    }
  }
  void resetSate(){
    state = ConfigInitial();
  }
}