

import 'package:hollat/login/data/database/hive_service.dart';
import 'package:hollat/login/data/database/service_config_database.dart';

class ServiceConfigDatabaseRepository{
  final HiveService _hiveService;
  ServiceConfigDatabaseRepository(this._hiveService);

  Future<int> saveConfig(ServiceConfigDatabase config)async{
   return await _hiveService.saveConfig(config);
  }
  Future<void> clearConfig() async{
    await _hiveService.clearConfig();
  }
  ServiceConfigDatabase? getAllConfig() {
    return _hiveService.getAllConfig();
  }
}