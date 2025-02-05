import 'package:hollat/login/data/models/client/region_data.dart';
import 'package:hollat/main/domain/entities/regions/regions.dart';

class RegionsModel extends Regions {
  const RegionsModel(
      {required super.data, required super.message, required super.status});

  factory RegionsModel.fromJson(Map<String, dynamic> json) => RegionsModel(
      data: List<RegionData>.from(
          json['data'].map((x) => RegionData.fromJson(x))),
      message: json['message'] as String,
      status: json['status'] as String);
}
