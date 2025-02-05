import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hollat/login/network/error_handling.dart';
import 'package:hollat/login/network/repositores/config_repository.dart';

class ConfigViewModel extends StateNotifier<ConfigState> {
  final ConfigRepository _repository;

  ConfigViewModel(this._repository) : super(ConfigInitial());

  Future<void> loadConfig() async {
    state = ConfigLoading();
    try {
      final response = await _repository.fetchConfig();

      state = ConfigSuccess(response);
    } on ApiException catch (e) {
      state = ConfigErrorApi(e.statusCode ?? 0, e.response);
    } on AppException catch (e) {
      state = ConfigError(e.message, e.hashCode);
    }
  }

  void resetConfig() {
    state = ConfigInitial();
  }
}

// @freezed
// sealed class ConfigState  with _$ConfigState{
//   const factory ConfigState.Initial() = ConfigInitial;
//   const factory ConfigState.loading() = ConfigLoading;
//   const factory ConfigState.success(ServiceConfigResponse response) = ConfigSuccess;
//   const factory ConfigState.error(String message) = ConfigError;
// }

sealed class ConfigState<T> {
  const ConfigState();

  bool get isLoading => this is ConfigLoading<T>;

  bool get isSuccess => this is ConfigSuccess<T>;

  bool get isError => this is ConfigError<T>;
  bool get isErrorApi => this is ConfigErrorApi<T>;
}

class ConfigInitial<T> extends ConfigState<T> {
  const ConfigInitial();
}

class ConfigLoading<T> extends ConfigState<T> {
  const ConfigLoading();
}

class ConfigSuccess<T> extends ConfigState<T> {
  final T data;

  const ConfigSuccess(this.data);
}

class ConfigError<T> extends ConfigState<T> {
  final String message;
  final int code;

  const ConfigError(this.message, this.code);
}

class ConfigErrorApi<T> extends ConfigState<T> {
  final T data;
  final int code;

  const ConfigErrorApi(this.code, this.data);
}

extension ConfigStateExtensions<T> on ConfigState<T> {
  R? whenOrNull<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(T data)? success,
    R Function(String message, int code)? error,
    R Function(int code, T data)? errorApi,
  }) {
    if (this is ConfigInitial<T> && initial != null) {
      return initial();
    } else if (this is ConfigLoading<T> && loading != null) {
      return loading();
    } else if (this is ConfigSuccess<T> && success != null) {
      return success((this as ConfigSuccess<T>).data);
    } else if (this is ConfigError<T> && error != null) {
      return error(
          (this as ConfigError<T>).message, (this as ConfigError<T>).code);
    } else if (this is ConfigErrorApi<T> && errorApi != null) {
      return errorApi(
          (this as ConfigErrorApi<T>).code, (this as ConfigErrorApi<T>).data);
    }
    return null;
  }
}
