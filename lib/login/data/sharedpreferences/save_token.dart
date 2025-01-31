import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

  final String authToken = 'auth_token';
  final _secureStorage = FlutterSecureStorage();

  AndroidOptions _getAndroidOptions()=> const AndroidOptions(
      encryptedSharedPreferences: true
  );
  IOSOptions _getIOSOptions()=> IOSOptions(accountName: 'auth_token');

  Future<void> saveToken(String token) async {
    try {
      await _secureStorage.write(key: authToken, value: token);
      // await _secureStorage.write(
      //     key: authToken,
      //     value: token,
      //     aOptions: const AndroidOptions(encryptedSharedPreferences: true),
      //     iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock));
      print('Saving token: $token'); // Debug log
    } catch (e) {
      print('Error saving token: $e');
    }
  }

  Future<String?> getToken() async {
    try {
      String? token = await _secureStorage.read(key: authToken);
      return token;
    } catch (e) {
      print('Error retrieving token: $e');
      return null;
    }
  }

  Future<void> deleteToken() async =>
      await _secureStorage.delete(key: authToken);

