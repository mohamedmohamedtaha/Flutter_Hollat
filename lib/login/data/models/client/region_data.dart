import 'package:json_annotation/json_annotation.dart';

part 'region_data.g.dart';

@JsonSerializable()
class RegionData {
  final int active; // 1
  final String? code; // sa-ri

  @JsonKey(name: 'country_id')
  final int countryId; // 9

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

  RegionData({
    required this.active,
    this.code,
    required this.countryId,
    required this.createdAt,
    this.deletedAt,
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.updatedAt,
    required this.userId,
  });

  factory RegionData.fromJson(Map<String, dynamic> json) => _$RegionDataFromJson(json);
  Map<String, dynamic> toJson() => _$RegionDataToJson(this);

  @override
  String toString() {
    return 'RegionData(id: $id, code: $code, titleAr: $titleAr)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RegionData &&
        id == other.id &&
        code == other.code &&
        titleAr == other.titleAr &&
        titleEn == other.titleEn &&
        countryId == other.countryId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    code.hashCode ^
    titleAr.hashCode ^
    titleEn.hashCode ^
    countryId.hashCode;
  }
}