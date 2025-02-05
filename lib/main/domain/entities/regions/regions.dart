import 'package:equatable/equatable.dart';
import 'package:hollat/login/data/models/client/country_data.dart';
import 'package:hollat/login/data/models/client/region_data.dart';

class Regions extends Equatable {
  final List<RegionData>data;
  final String message;
  final String status;

  const Regions({required this.data,required this.message,required this.status});

  @override
  List<Object> get props => [data, message, status];
}