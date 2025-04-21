import 'package:hollat/login/data/database/service_config_database.dart';

abstract class ServiceConfigDatabaseRepository {
  Future<int> saveConfig(ServiceConfigDatabase config);
  Future<void> clearConfig();

  ServiceConfigDatabase? getAllConfig();
}
