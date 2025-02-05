import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hollat/login/data/viewmodel/config_viewmodel.dart';
import 'package:hollat/login/network/error_handling.dart';
import 'package:hollat/main/data/repositories/client_profile_repositories.dart';

class CountriesViewModel extends StateNotifier<ConfigState> {
  final ClientProfileRepository repository;

  CountriesViewModel({required this.repository}) : super(ConfigInitial());

  Future<void> getAllCountries() async {
    state = ConfigLoading();
    try {
      final clientProfile = await repository.getAllCountries();
      state = ConfigSuccess(clientProfile);
    } on ApiException catch (e) {
      state = ConfigErrorApi(e.statusCode ?? 0, e.response);
    } on AppException catch (e) {
      state = ConfigError(e.message,e.hashCode);
    }
  }

  void resetSate() {
    state = ConfigInitial();
  }
}
