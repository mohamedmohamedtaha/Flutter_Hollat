import 'package:hollat/login/domain/entities/config_response/client_name.dart';

class ClientNameModel extends ClientName {
  ClientNameModel({required super.value});

  factory ClientNameModel.fromJson(Map<String, dynamic> json) =>
      ClientNameModel(value: json['value'] as String);

  Map<String, dynamic> toJson(ClientNameModel model) =>
      <String, dynamic>{'value': model.value};
}
