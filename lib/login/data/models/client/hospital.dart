import 'package:hollat/login/data/models/client/pivot.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hospital.g.dart';

@JsonSerializable()
class Hospital {
  final int active; // 0
  @JsonKey(name: 'address_ar')
  final String addressAr; // دعم فني ساما نهتم
  @JsonKey(name: 'address_en')
  final String addressEn; // SAMA Cares
  @JsonKey(name: 'city_id')
  final int cityId; // 8
  final String code; // SAMA
  @JsonKey(name: 'country_id')
  final int countryId; // 9
  @JsonKey(name: 'created_at')
  final String createdAt; // 2022-06-28 19:36:51
  @JsonKey(name: 'default_role_id')
  final int defaultRoleId; // 406
  @JsonKey(name: 'default_team_tier_id')
  final int defaultTeamTierId; // 1
  @JsonKey(name: 'deleted_at')
  final dynamic deletedAt; // null
  @JsonKey(name: 'google_map_url')
  final String googleMapUrl; // www.hollat.net
  final String hotline; // 1234
  final int id; // 1
  final String mobile; // 0598051269
  @JsonKey(name: 'organization_type_id')
  final int organizationTypeId; // 1
  final Pivot pivot;
  final int portal; // 0
  @JsonKey(name: 'region_id')
  final int regionId; // 15
  final String responsibility; // supervision
  @JsonKey(name: 'supervision_organization_id')
  final dynamic supervisionOrganizationId; // null
  final String telephone; // 920004276
  final dynamic timezone; // null
  @JsonKey(name: 'title_ar')
  final String titleAr; // ساما تهتم
  @JsonKey(name: 'title_en')
  final String titleEn; // SAMA Cares
  @JsonKey(name: 'updated_at')
  final String updatedAt; // 2023-07-11 23:41:27

  Hospital({
    required this.active,
    required this.addressAr,
    required this.addressEn,
    required this.cityId,
    required this.code,
    required this.countryId,
    required this.createdAt,
    required this.defaultRoleId,
    required this.defaultTeamTierId,
    this.deletedAt,
    required this.googleMapUrl,
    required this.hotline,
    required this.id,
    required this.mobile,
    required this.organizationTypeId,
    required this.pivot,
    required this.portal,
    required this.regionId,
    required this.responsibility,
    this.supervisionOrganizationId,
    required this.telephone,
    this.timezone,
    required this.titleAr,
    required this.titleEn,
    required this.updatedAt,
  });

  factory Hospital.fromJson(Map<String, dynamic> json) =>
      _$HospitalFromJson(json);

  Map<String, dynamic> toJson() => _$HospitalToJson(this);

  @override
  String toString() {
    return 'Hospital(id: $id, code: $code, titleEn: $titleEn)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Hospital &&
        id == other.id &&
        code == other.code &&
        titleEn == other.titleEn &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ code.hashCode ^ titleEn.hashCode ^ createdAt.hashCode;
  }
}
