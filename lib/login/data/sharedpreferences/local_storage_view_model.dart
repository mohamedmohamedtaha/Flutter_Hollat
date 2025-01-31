import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hollat/login/data/constants/Constants.dart';
import 'package:hollat/login/data/sharedpreferences/local_storage_service.dart';

// @immutable
// class LocalStorageState {
//   final bool isDarkMode;
//
//   const LocalStorageState({required this.isDarkMode});
//
//   LocalStorageState copyWith({bool? isDarkMode}) {
//     return LocalStorageState(isDarkMode: isDarkMode ?? this.isDarkMode);
//   }
// }

class LocalStorageServiceVieWModel extends StateNotifier<bool> {
  // bool _isDarkMode = false;
  //
  // bool get isDarkMode => _isDarkMode;

  LocalStorageServiceVieWModel() : super(false) {
    loadMode();
  }

  Future<void> loadMode() async {
    final storedMode = LocalStorageService.getData<bool>(Constants.MODE_KEY) ?? false;
    state = storedMode;
  }
  Future<void> changeDarkMode(bool value) async {
    state = value;
    await LocalStorageService.saveData<bool>(Constants.MODE_KEY, value);
  }
  // Future<void> _loadMode() async {
  //   _isDarkMode = LocalStorageService.getData(Constants.MODE_KEY) ?? false;
  //   notifyListeners();
  // }

  // Future<void> changeDarkMode(bool value) async {
  //   _isDarkMode = value;
  //   await LocalStorageService.saveData(Constants.MODE_KEY, value);
  //   notifyListeners();
  // }
}

// class LocalStorageServiceVieWModel extends ChangeNotifier {
//   bool _isDarkMode = false;
//
//   bool get isDarkMode => _isDarkMode;
//
//   LocalStorageServiceVieWModel() {
//     _loadMode();
//   }
//
//   Future<void> _loadMode() async {
//     _isDarkMode = LocalStorageService.getData(Constants.MODE_KEY) ?? false;
//     notifyListeners();
//   }
//
//   Future<void> changeDarkMode(bool value) async {
//     _isDarkMode = value;
//     await LocalStorageService.saveData(Constants.MODE_KEY, value);
//     notifyListeners();
//   }
// }
