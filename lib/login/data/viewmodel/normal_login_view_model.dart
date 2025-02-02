import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hollat/login/data/viewmodel/config_viewmodel.dart';
import 'package:hollat/login/network/error_handling.dart';
import 'package:hollat/login/network/repositores/normal_login_repository.dart';

class NormalLoginViewModel extends StateNotifier<ConfigState> {
  final NormalLoginRepository repository;

  NormalLoginViewModel({required this.repository}) : super(ConfigInitial());

  Future<void> reloadCaptcha() async {
    state = ConfigLoading();
    try {
      final captcha = await repository.reloadCaptcha();
      state = ConfigSuccess(captcha);
    } on ApiException catch (e) {
      print('final error: ${e.statusCode} message: ${e.message}');
      state = ConfigError(e.message, e.statusCode ?? 0);
    } on AppException catch (e) {
      state = ConfigError(e.message, e.hashCode);
    }
  }

  void restState() {
    state = ConfigInitial();
  }

// Future<void> getAllNationalTypes() async {
//   state = ConfigLoading();
//   try {
//     final nationalTypesResponse = await repository.getAllNationalTypes() as T;
//     state = ConfigSuccess(nationalTypesResponse);
//   }on AppException catch (e) {
//     state = ConfigError(e.message);
//   }
// }
//
// Future<void> nafath(String id) async {
//   state = ConfigLoading();
//   try {
//     final nafaz = await repository.nafath(id);
//     state = ConfigSuccess(nafaz);
//   }on AppException catch (e) {
//     state = ConfigError(e.message);
//   }
// }
}
