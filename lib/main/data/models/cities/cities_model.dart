import 'package:hollat/login/data/models/client/city_data.dart';
import 'package:hollat/main/domain/entities/cities/cities.dart';

class CitiesModel extends Cities {
  const CitiesModel(
      {required super.data, required super.message, required super.status});

  factory CitiesModel.fromJson(Map<String, dynamic> json) => CitiesModel(
      data: List<CityData>.from(json['data'].map((x) => CityData.fromJson(x))),
      message: json['message'] as String,
      status: json['status'] as String);
}
