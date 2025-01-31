import 'package:json_annotation/json_annotation.dart';

part 'city_data.g.dart';
@JsonSerializable()
class CityData {
  final int active; // 1

  @JsonKey(name: 'country_id')
  final int countryId; // 9

  @JsonKey(name: 'region_id')
  final int regionId; // 15

  @JsonKey(name: 'created_at')
  final String createdAt; // 2020-11-09 16:39:24

  @JsonKey(name: 'deleted_at')
  final dynamic deletedAt; // null

  final int id; // 15

  @JsonKey(name: 'title_ar')
  final String titleAr; // الرياض

  @JsonKey(name: 'title_en')
  final String titleEn; // الرياض

  @JsonKey(name: 'updated_at')
  final String updatedAt; // 2023-03-14 11:08:42

  @JsonKey(name: 'user_id')
  final int userId; // 98

  CityData({
    required this.active,
    required this.countryId,
    required this.regionId,
    required this.createdAt,
    this.deletedAt,
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.updatedAt,
    required this.userId,
  });

  factory CityData.fromJson(Map<String, dynamic> json) => _$CityDataFromJson(json);
  Map<String, dynamic> toJson() => _$CityDataToJson(this);

  @override
  String toString() {
    return 'CityData(id: $id, titleAr: $titleAr, titleEn: $titleEn)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CityData &&
        id == other.id &&
        titleAr == other.titleAr &&
        titleEn == other.titleEn;
  }

  @override
  int get hashCode => id.hashCode ^ titleAr.hashCode ^ titleEn.hashCode;
}