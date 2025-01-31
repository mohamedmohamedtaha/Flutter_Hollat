import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:hollat/login/data/database/service_config_database.dart';

class HiveService {
  static const String _configBox = 'config_box';

  Future<void> init() async {
    await Hive.openBox<ServiceConfigDatabase>(_configBox);
  }

  Box<ServiceConfigDatabase> get configBox =>
      Hive.box<ServiceConfigDatabase>(_configBox);

  Future<int> saveConfig(ServiceConfigDatabase config) async {
    return await configBox.add(config);
  }

  Future<void> clearConfig() async {
    await configBox.clear();
  }

  // Retrieve the latest config (most recently added)
  ServiceConfigDatabase? getAllConfig() {
    if (configBox.isEmpty) return null;
    return configBox.getAt(configBox.length - 1);
  }
}
