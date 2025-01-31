import 'package:json_annotation/json_annotation.dart';

part 'country_data.g.dart';

@JsonSerializable()
class CountryData {
  @JsonKey(name: 'country_code')
  final String countryCode; // KSA

  @JsonKey(name: 'created_at')
  final String createdAt; // 2020-11-09 16:38:49

  @JsonKey(name: 'deleted_at')
  final dynamic deletedAt; // null

  final int id; // 9

  @JsonKey(name: 'is_default')
  final int isDefault; // 0

  final String lat; // 00123
  final String long; // 00332

  @JsonKey(name: 'phone_code')
  final String phoneCode; // 966

  @JsonKey(name: 'title_ar')
  final String titleAr; // المملكة العربية السعودية

  @JsonKey(name: 'title_en')
  final String titleEn; // KSA

  @JsonKey(name: 'updated_at')
  final String updatedAt; // 2024-08-11 13:50:46

  @JsonKey(name: 'user_id')
  final int userId; // 314

  CountryData({
    required this.countryCode,
    required this.createdAt,
    this.deletedAt,
    required this.id,
    required this.isDefault,
    required this.lat,
    required this.long,
    required this.phoneCode,
    required this.titleAr,
    required this.titleEn,
    required this.updatedAt,
    required this.userId,
  });

  factory CountryData.fromJson(Map<String, dynamic> json) => _$CountryDataFromJson(json);
  Map<String, dynamic> toJson() => _$CountryDataToJson(this);

  @override
  String toString() {
    return 'CountryData(id: $id, code: $countryCode, title: $titleEn)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CountryData &&
        id == other.id &&
        countryCode == other.countryCode &&
        titleEn == other.titleEn &&
        phoneCode == other.phoneCode;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    countryCode.hashCode ^
    titleEn.hashCode ^
    phoneCode.hashCode;
  }
}