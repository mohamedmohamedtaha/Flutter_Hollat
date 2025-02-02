import 'package:hollat/login/domain/entities/response/response.dart';

class ResponseModel extends Response {
 const ResponseModel(
      {super.status, super.message, required super.data});

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] as dynamic);

  Map<String, dynamic> toJson(ResponseModel model) => <String, dynamic>{
    'status': model.status,
    'message': model.message,
    'data': model.data
  };
}
