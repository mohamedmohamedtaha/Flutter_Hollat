import 'package:hollat/login/data/models/configresponse/client_name_ar_model.dart';
import 'package:hollat/login/data/models/configresponse/client_name_model.dart';
import 'package:hollat/login/domain/entities/config_response/client_details.dart';
class ClientDetailsModel extends ClientDetails {
  const ClientDetailsModel({
    required super.clientName,
    required super.clientNameAr,
  });

  factory ClientDetailsModel.fromJson(Map<String, dynamic> json) =>
      ClientDetailsModel(clientName: ClientNameModel.fromJson(json['CLIENT_NAME'] as Map<String,dynamic>),
      clientNameAr: ClientNameArModel.fromJon(json['CLIENT_NAME_AR']as Map<String, dynamic>)
      );

  Map<String, dynamic> toJson(ClientDetailsModel model) =>
      <String,dynamic>{
    'CLIENT_NAME': model.clientName,
        'CLIENT_NAME_AR': model.clientNameAr
      };
}