import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hollat/login/data/viewmodel/config_viewmodel.dart';
import 'package:hollat/login/network/error_handling.dart';
import 'package:hollat/login/network/repositores/normal_login_repository.dart';

class GetAllNationalTypesViewModel extends StateNotifier<ConfigState>{
  final NormalLoginRepository repository;
  GetAllNationalTypesViewModel({required this.repository}) : super(ConfigInitial());
  Future<void> getAllNationalTypes() async {
    state = ConfigLoading();
    try {
      final nationalTypesResponse = await repository.getAllNationalTypes();
      state = ConfigSuccess(nationalTypesResponse);
    }on AppException catch (e) {
      state = ConfigError(e.message,e.hashCode);
    }
  }
}