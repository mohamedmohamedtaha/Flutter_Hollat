import 'package:equatable/equatable.dart';

class ErrorMessageModel extends Equatable {
  final String status;
  final String message;

  const ErrorMessageModel({required this.status,required this.message});
factory ErrorMessageModel.fromJson(Map<String,dynamic>json)=>ErrorMessageModel(status: json['status'],
    message: json['message']);
  @override
  List<Object> get props => [status, message];
}