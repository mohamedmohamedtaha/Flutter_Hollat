import 'package:json_annotation/json_annotation.dart';
part 'national_id_type.g.dart';

@JsonSerializable()
class NationalIdType {
  final int id;
  @JsonKey(name: 'title_en')
  final String titleEn;
  @JsonKey(name: 'title_ar')
  final String titleAr;

  NationalIdType({
    required this.id,
    required this.titleEn,
    required this.titleAr,
  });

  factory NationalIdType.fromJson(Map<String, dynamic> json) =>
      _$NationalIdTypeFromJson(json);
  Map<String, dynamic> toJson() => _$NationalIdTypeToJson(this);
}
