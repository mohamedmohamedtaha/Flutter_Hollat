import 'package:equatable/equatable.dart';
import 'package:hollat/login/data/models/client/city_data.dart';

class Cities extends Equatable {
  final List<CityData>data;
  final String message;
  final String status;

  const Cities({required this.data,required this.message,required this.status});

  @override
  List<Object> get props => [data, message, status];
}