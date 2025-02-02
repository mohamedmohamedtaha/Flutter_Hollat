import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hollat/login/data/models/send_otp/send_otp_model.dart';
import 'package:hollat/login/data/viewmodel/config_viewmodel.dart';
import 'package:hollat/login/network/error_handling.dart';
import 'package:hollat/login/network/repositores/normal_login_repository.dart';

class SendOtpViewModel extends StateNotifier<ConfigState>{
  final NormalLoginRepository repository;

  SendOtpViewModel({required this.repository}) : super(ConfigInitial());

  Future<void> sendOtp(SendOtpModel parameters) async {
    state = ConfigLoading();
    try {
      final captcha = await repository.sendOtp(parameters);
      state = ConfigSuccess(captcha);
    } on ApiException catch (e) {
      print('final error: ${e.statusCode} message: ${e.message}');
      state = ConfigErrorApi(e.statusCode ?? 0, e.response);
    } on AppException catch (e) {
      state = ConfigError(e.message,e.hashCode);
    }
  }

  void restState() {
    state = ConfigInitial();
  }
}
