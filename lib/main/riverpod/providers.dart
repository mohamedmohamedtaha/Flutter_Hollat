//Services
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hollat/login/data/database/ServiceConfigDatabaseRepository.dart';
import 'package:hollat/login/data/database/ServiceConfigDtabaseViewModel.dart';
import 'package:hollat/login/data/database/hive_service.dart';
import 'package:hollat/login/data/sharedpreferences/local_storage_view_model.dart';
import 'package:hollat/login/data/viewmodel/config_viewmodel.dart';
import 'package:hollat/login/data/viewmodel/create_account_view_model.dart';
import 'package:hollat/login/data/viewmodel/get_all_national_types_view_model.dart';
import 'package:hollat/login/data/viewmodel/nafaz_send_verify_code_view_model.dart';
import 'package:hollat/login/data/viewmodel/nafaz_status_view_model.dart';
import 'package:hollat/login/data/viewmodel/nafaz_verify_mobile_view_model.dart';
import 'package:hollat/login/data/viewmodel/nafaz_view_model.dart';
import 'package:hollat/login/data/viewmodel/normal_login_view_model.dart';
import 'package:hollat/login/data/viewmodel/send_otp_view_model.dart';
import 'package:hollat/login/data/viewmodel/verify_otp_view_model.dart';
import 'package:hollat/login/network/repositores/config_repository.dart';
import 'package:hollat/login/network/repositores/normal_login_repository.dart';
import 'package:hollat/main/riverpod/dio_providers.dart';

// final apiServiceProvider = Provider<ApiService>((ref) =>ApiService());
final hiveServiceProvider = FutureProvider((ref) async {
  final hiveService = HiveService();
  await hiveService.init();
  return hiveService;
});

final serviceConfigRepoProvider =
Provider<ServiceConfigDatabaseRepository>((ref) {
  final hiveServiceAsyncValue = ref.watch(hiveServiceProvider);

  // Access the HiveService when it's loaded
  return hiveServiceAsyncValue.when(
    data: (hiveService) {
      return ServiceConfigDatabaseRepository(hiveService);
    },
    loading: () {
      throw Exception('HiveService is still loading'); // Handle loading state
    },
    error: (e, stack) {
      throw Exception(
          'Error initializing HiveService: $e'); // Handle error state
    },
  );
});
// Repositories
// final serviceConfigRepoProvider = Provider(
//     (ref) => ServiceConfigDatabaseRepository(ref.watch(hiveServiceProvider)));

//ViewModel
final configViewModelProvider =
StateNotifierProvider<ConfigViewModel, ConfigState>((ref) {
  return ConfigViewModel(ref.read(configRepositoryProvider));
});
final serviceConfigDatabaseViewModelProvider = Provider((ref) =>
    ServiceConfigDatabaseViewModel(ref.watch(serviceConfigRepoProvider)));

final localStorageViewModelProvider =
StateNotifierProvider<LocalStorageServiceVieWModel, bool>(
      (ref) => LocalStorageServiceVieWModel(),
);

final configRepositoryProvider = Provider<ConfigRepository>((ref) {
  return ConfigRepository(ref.read(apiClientProvider));
});

final normalLoginRepositoryProvider = Provider<NormalLoginRepository>(
        (ref) => NormalLoginRepository(ref.read(apiClientProvider)));

final normalLoginViewModelProvider =
StateNotifierProvider.autoDispose<NormalLoginViewModel, ConfigState>((ref) {
  return NormalLoginViewModel(
      repository: ref.read(normalLoginRepositoryProvider));
});

final getAllNationalTypesViewModelProvider = StateNotifierProvider.autoDispose<
    GetAllNationalTypesViewModel, ConfigState>((ref) {
  return GetAllNationalTypesViewModel(
      repository: ref.read(normalLoginRepositoryProvider));
});
final nafazLoginViewModelProvider =
StateNotifierProvider.autoDispose<NafazViewModel, ConfigState>((ref) {
  return NafazViewModel(repository: ref.read(normalLoginRepositoryProvider));
});
final nafazCodeViewModelProvider =
StateNotifierProvider.autoDispose<NafazViewModel, ConfigState>((ref) {
  return NafazViewModel(repository: ref.read(normalLoginRepositoryProvider));
});
final enableButtonProvider = StateProvider((ref) => false);
final enableButtonProviderDefaultTrue = StateProvider((ref) => true);

final nafazStatusViewModelProvider =
StateNotifierProvider.autoDispose<NafazStatusViewModel, ConfigState>((ref) {
  return NafazStatusViewModel(
      repository: ref.read(normalLoginRepositoryProvider));
});

final nafazSendVerifyCodeProvider = StateNotifierProvider.autoDispose<
    NafazSendVerifyCodeViewModel, ConfigState>((ref) {
  return NafazSendVerifyCodeViewModel(
      repository: ref.read(normalLoginRepositoryProvider));
});
final resendNafazSendVerifyCodeProvider = StateNotifierProvider.autoDispose<
    NafazSendVerifyCodeViewModel, ConfigState>((ref) {
  return NafazSendVerifyCodeViewModel(
      repository: ref.read(normalLoginRepositoryProvider));
});
final nafazVerifyMobileViewModelProvider =
StateNotifierProvider.autoDispose<NafazVerifyMobileViewModel, ConfigState>(
        (ref) {
      return NafazVerifyMobileViewModel(
          repository: ref.read(normalLoginRepositoryProvider));
    });
final verifyOtpVieWModelProvider =
StateNotifierProvider.autoDispose<VerifyOtpVieWModel, ConfigState>((ref) {
  return VerifyOtpVieWModel(
      repository: ref.read(normalLoginRepositoryProvider));
});
final sendOtpViewModelProvider =
StateNotifierProvider.autoDispose<SendOtpViewModel, ConfigState>((ref) {
  return SendOtpViewModel(repository: ref.read(normalLoginRepositoryProvider));
});

final normalSendOtpViewModelProvider =
StateNotifierProvider.autoDispose<SendOtpViewModel, ConfigState>((ref) {
  return SendOtpViewModel(repository: ref.read(normalLoginRepositoryProvider));
});
final createAccountViewModelProvider =
StateNotifierProvider.autoDispose<CreateAccountViewModel, ConfigState>((ref) {
  return CreateAccountViewModel(repository: ref.read(normalLoginRepositoryProvider));
});

// final nafazViewModelProvider = Provider<NormalLoginRepository>(
//         (ref) => NormalLoginRepository(ref.read(apiClientProvider)));

// final normalLoginViewModelProvider = StateNotifierProvider<NormalLoginViewModel, LoginState>(
//       (ref) => NormalLoginViewModel(ref.watch(apiServiceProvider)),
// );
