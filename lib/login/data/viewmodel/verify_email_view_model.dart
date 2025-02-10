import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hollat/login/data/models/login_response/login_response_model.dart';
import 'package:hollat/login/data/viewmodel/config_viewmodel.dart';
import 'package:hollat/login/domain/usecases/nafaz_send_verify_code_reposetory_use_case.dart';
import 'package:hollat/login/network/error_handling.dart';
import 'package:hollat/login/network/repositores/normal_login_repository.dart';

class VerifyEmailViewModel extends StateNotifier<ConfigState>{
  final NormalLoginRepository repository;
  VerifyEmailViewModel({required this.repository}) : super(ConfigInitial());
  Future<void> verifyEmail(ResponseParameters parameters) async {
    state = ConfigLoading();
    try {
      final captcha = await repository.verifyEmail(parameters);
      state = ConfigSuccess(captcha);
    }on ApiException catch (e) {
      print('final error: ${e.statusCode} message: ${e.message}');
      state = ConfigError(e.message,e.statusCode ?? 0);
    } on AppException catch (e) {
      state = ConfigError(e.message,e.hashCode);
    }
  }

  void restState() {
    state = ConfigInitial();
  }
}