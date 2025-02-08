import 'package:hollat/login/domain/entities/config_response/client_name_ar.dart';
class ClientNameArModel extends ClientNameAr {

  const ClientNameArModel({required super.value});

  factory ClientNameArModel.fromJon(Map<String, dynamic> json)=>
      ClientNameArModel(value: json['value'] as String);
  Map<String,dynamic>toJson(ClientNameArModel model) => <String, dynamic>{'value': model.value};
}