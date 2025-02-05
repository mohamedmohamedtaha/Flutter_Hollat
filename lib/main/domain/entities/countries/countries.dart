import 'package:equatable/equatable.dart';
import 'package:hollat/login/data/models/client/country_data.dart';

class Countries extends Equatable {
  final List<CountryData>data;
  final String message;
  final String status;

  const Countries({required this.data,required this.message,required this.status});

  @override
  List<Object> get props => [data, message, status];
}