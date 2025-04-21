import 'package:hollat/login/data/database/hive_service.dart';
import 'package:hollat/login/data/database/service_config_database.dart';
import 'package:hollat/login/data/database/service_config_database_repository.dart';

class ServiceConfigDataSource implements ServiceConfigDatabaseRepository {
  final HiveService _hiveService;
  ServiceConfigDataSource(this._hiveService);

  @override
  Future<void> clearConfig() async {
    await _hiveService.clearConfig();
  }

  @override
  ServiceConfigDatabase? getAllConfig() {
    return _hiveService.getAllConfig();
  }

  @override
  Future<int> saveConfig(ServiceConfigDatabase config) async {
    return await _hiveService.saveConfig(config);
  }
}
