import 'package:hollat/login/domain/entities/response/response.dart';

class ResponseModel extends Response {
  ResponseModel(
      {required super.status, required super.message, required super.data});

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
      status: json['status'] as String,
      message: json['message'],
      data: json['data'] as dynamic);

  Map<String, dynamic> toJson(ResponseModel model) => <String, dynamic>{
    'status': model.status,
    'message': model.message,
    'data': model.data
  };
}
