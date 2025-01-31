import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static SharedPreferences? _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData<T>(String key, T value) {
    if (_preferences == null)
      throw Exception('SharedPReferences not initialized');
    switch (T) {
      case String:
        return _preferences!.setString(key, value as String);
      case int:
        return _preferences!.setInt(key, value as int);
      case bool:
        return _preferences!.setBool(key, value as bool);
      case double:
        return _preferences!.setDouble(key, value as double);
      default:
        throw Exception('Unsupported data type: $T');
    }
  }

  static T? getData<T>(String key) {
    if (_preferences == null)
      throw Exception('SharedPReferences not initialized');
    switch (T) {
      case String:
        return _preferences!.getString(key) as T?;
      case int:
        return _preferences!.getInt(key) as T?;
      case bool:
        return _preferences!.getBool(key) as T?;
      case double:
        return _preferences!.getDouble(key) as T?;
      default:
        throw Exception('Unsupported data type: $T');
    }
  }

  static Future<bool> deletedata(String key) async {
    if (_preferences == null)
      throw Exception('SharedPReferences not initialized');
    return _preferences!.remove(key);
  }
  static Future<bool> clearAll()async{
    if (_preferences == null)
      throw Exception('SharedPReferences not initialized');
    return _preferences!.clear();
  }
}
