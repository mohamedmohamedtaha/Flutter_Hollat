import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hollat/login/data/viewmodel/config_viewmodel.dart';
import 'package:hollat/login/domain/entities/create_account/create_account.dart';
import 'package:hollat/login/network/error_handling.dart';
import 'package:hollat/login/network/repositores/normal_login_repository.dart';

class CreateAccountViewModel extends StateNotifier<ConfigState> {
  final NormalLoginRepository repository;

  CreateAccountViewModel({required this.repository}) : super(ConfigInitial());

  Future<void> createClient(CreateAccount parameters) async {
    state = ConfigLoading();
    try {
      final data = await repository.createClient(parameters);
      state = ConfigSuccess(data);
    } on ApiException catch (e) {
      print('final error: ${e.statusCode} message: ${e.message} e.response.data ${e.response?.data.toString()}');
      state = ConfigErrorApi(e.statusCode ?? 0, e.response);
    } on AppException catch (e) {
      state = ConfigError(e.message, e.hashCode);
    }
  }

  void restState() {
    state = ConfigInitial();
  }
}
