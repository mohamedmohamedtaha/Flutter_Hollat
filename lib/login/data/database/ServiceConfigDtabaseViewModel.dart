
import 'package:flutter/cupertino.dart';
import 'package:hollat/login/data/database/ServiceConfigDatabaseRepository.dart';
import 'package:hollat/login/data/database/service_config_database.dart';

class ServiceConfigDatabaseViewModel extends ChangeNotifier{
final ServiceConfigDatabaseRepository _repository;
ServiceConfigDatabase? _configDatabase;
bool _isLoading = false;
ServiceConfigDatabase? get config => _configDatabase;
bool get isLoading => _isLoading;

ServiceConfigDatabaseViewModel(this._repository);

Future<ServiceConfigDatabase?> getAllConfig()async{
  _isLoading = true;
  notifyListeners();
  try{
    _configDatabase = _repository.getAllConfig();
  }catch(e){
    _configDatabase = null;
  }finally{
    _isLoading = false;
    notifyListeners();
  }
}
Future<void> saveConfig(ServiceConfigDatabase config)async{
  await _repository.saveConfig(config);
  _configDatabase = config;
  notifyListeners();
}
Future<void> clearConfig() async{
  await _repository.clearConfig();
  _configDatabase = null;
  notifyListeners();
}

}