import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hollat/login/data/viewmodel/config_viewmodel.dart';
import 'package:hollat/login/network/error_handling.dart';
import 'package:hollat/login/network/repositores/normal_login_repository.dart';
class NafazViewModel extends StateNotifier<ConfigState> {
  final NormalLoginRepository repository;

  NafazViewModel({required this.repository}) : super(ConfigInitial());

  Future<void> nafath(String id) async {
    state = ConfigLoading();
    try {
      final nafaz = await repository.nafath(id);
      state = ConfigSuccess(nafaz);
    } on ApiException catch (e) {
      print('final error: ${e.statusCode} message: ${e.message}');
      state = ConfigErrorApi(e.statusCode ?? 0, e.response);
    } on AppException catch (e) {
      state = ConfigError(e.message,e.hashCode);
    }
  }
  void restState(){
    state  = ConfigInitial();
  }
}
