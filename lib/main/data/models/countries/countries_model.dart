import 'package:hollat/login/data/models/client/country_data.dart';
import 'package:hollat/main/domain/entities/countries/countries.dart';

class CountriesModel extends Countries {
  const CountriesModel(
      {required super.data, required super.message, required super.status});

  factory CountriesModel.fromJson(Map<String, dynamic> json) => CountriesModel(
      data: List<CountryData>.from(
          json['data'].map((x) => CountryData.fromJson(x))),
      message: json['message'] as String,
      status: json['status'] as String);
}
