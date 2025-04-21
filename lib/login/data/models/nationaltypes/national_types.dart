import 'package:json_annotation/json_annotation.dart';
part 'national_types.g.dart';

@JsonSerializable()
class NationalTypes {
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'deleted_at')
  final String? deletedAt;
  final int id; // Short in Kotlin becomes int in Dart
  @JsonKey(name: 'title_ar')
  final String titleAr;
  @JsonKey(name: 'title_en')
  final String titleEn;
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  NationalTypes({
    required this.createdAt,
    this.deletedAt,
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.updatedAt,
  });
  factory NationalTypes.fromJson(Map<String, dynamic> json) =>
      _$NationalTypesFromJson(json);

  Map<String, dynamic> toJson() => _$NationalTypesToJson(this);
}
