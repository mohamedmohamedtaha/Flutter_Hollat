import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hollat/login/data/viewmodel/config_viewmodel.dart';
import 'package:hollat/main/data/repositories/client_profile_repositories.dart';
import 'package:hollat/main/data/viewmodel/cities_view_model.dart';
import 'package:hollat/main/data/viewmodel/client_profile_view_model.dart';
import 'package:hollat/main/data/viewmodel/countries_view_model.dart';
import 'package:hollat/main/data/viewmodel/logout_view_model.dart';
import 'package:hollat/main/data/viewmodel/regions_view_model.dart';
import 'package:hollat/main/data/viewmodel/update_profile_view_model.dart';
import 'package:hollat/main/riverpod/dio_providers.dart';

final clientProfileRepositoryProvider = Provider<ClientProfileRepository>(
        (ref) => ClientProfileRepository(ref.read(apiClientProvider)));

final clientProfileViewModelProvider =
StateNotifierProvider.autoDispose<ClientProfileViewModel, ConfigState>(
        (ref) {
      return ClientProfileViewModel(
          repository: ref.read(clientProfileRepositoryProvider));
    });

final countriesViewModelProvider =
StateNotifierProvider.autoDispose<CountriesViewModel, ConfigState>(
        (ref) {
      return CountriesViewModel(
          repository: ref.read(clientProfileRepositoryProvider));
    });

final regionsProfileViewModelProvider =
StateNotifierProvider.autoDispose<RegionsViewModel, ConfigState>(
        (ref) {
      return RegionsViewModel(
          repository: ref.read(clientProfileRepositoryProvider));
    });

final citiesViewModelProvider =
StateNotifierProvider.autoDispose<CitiesViewModel, ConfigState>(
        (ref) {
      return CitiesViewModel(
          repository: ref.read(clientProfileRepositoryProvider));
    });

final logoutViewModelProvider =
StateNotifierProvider.autoDispose<LogoutViewModel, ConfigState>(
        (ref) {
      return LogoutViewModel(
          repository: ref.read(clientProfileRepositoryProvider));
    });

final updateProfileViewModelProvider =
StateNotifierProvider.autoDispose<UpdateProfileViewModel, ConfigState>(
        (ref) {
      return UpdateProfileViewModel(
          repository: ref.read(clientProfileRepositoryProvider));
    });
