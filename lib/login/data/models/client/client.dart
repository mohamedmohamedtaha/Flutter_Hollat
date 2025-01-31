import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hollat/login/data/models/client/city_data.dart';
import 'package:hollat/login/data/models/client/country_data.dart';
import 'package:hollat/login/data/models/client/hospital.dart';
import 'package:hollat/login/data/models/client/national_id_type.dart';
import 'package:hollat/login/data/models/client/region_data.dart';

part 'client.g.dart';

@JsonSerializable(checked: false, ignoreUnannotated: true, explicitToJson: true)
class Client {
  @JsonKey(name: 'id')
  final int id; // 415270
  @JsonKey(name: 'name')
  final String name; // محمد محمد طه حسن
  @JsonKey(name: 'gender')
  final String gender; // male
  @JsonKey(name: 'birthdate')
  final String birthdate; // 1988-07-03
  @JsonKey(name: 'mobile')
  final String mobile; // 966535020871
  // @JsonKey(name: 'address')
  // final String? address; // null

  @JsonKey(name: 'national_id')
  final String nationalId; // 2352946137

  @JsonKey(name: 'national_id_type_id')
  final int? nationalIdTypeId; // 1

  // @JsonKey(name: 'national_id_type')
  // final NationalIdType? nationalIdType;

  @JsonKey(name: 'active')
  final int? active; // 1
  // @JsonKey(name: 'email')
  // final String? email; // null
  //
  // @JsonKey(name: 'client_id')
  // final String? clientId; // null
  //
  // @JsonKey(name: 'added_by')
  // final String? addedBy; // portal
  //
  // // @JsonKey(name: 'city')
  // // final CityData? city; // null
  //
  // @JsonKey(name: 'city_id')
  // final int? cityId; // null
  // // @JsonKey(name: 'client')
  // // final String? client; // null
  //
  // @JsonKey(name: 'client_type_id')
  // final String? clientTypeId; // null
  // @JsonKey(name: 'company')
  // final String? company; // null
  //
  // @JsonKey(name: 'company_id')
  // final String? companyId; // null
  // // @JsonKey(name: 'country')
  // // final CountryData? country; // null
  //
  // @JsonKey(name: 'country_id')
  // final int? countryId; // null
  //
  // @JsonKey(name: 'created_at')
  // final String createdAt; // 2023-08-24 12:40:38

  // @JsonKey(name: 'creator_id')
  // final String? creatorId; // null
  //
  @JsonKey(name: 'data_completed')
  final int? dataCompleted; // 1
  //
  // @JsonKey(name: 'deleted_at')
  // final String? deletedAt; // null
  // // @JsonKey(name: 'hospitals')
  // // final List<Hospital>? hospitals;
  //
  // @JsonKey(name: 'id_endDate')
  // final String? idEndDate; // null
  //
  // @JsonKey(name: 'ministry_member')
  // final String? ministryMember; // null
  //
  @JsonKey(name: 'mobile_verified_at')
  final String? mobileVerifiedAt; // 2023-08-24 12:40:53
  //
  // @JsonKey(name: 'nationality_id')
  // final String? nationalityId; // null
  //
  // @JsonKey(name: 'preferred_language')
  // final String preferredLanguage; // ar
  // @JsonKey(name: 'region')
  // final RegionData? region; // null
  //
  // @JsonKey(name: 'region_id')
  // final String? regionId; // null
  //
  // // @JsonKey(name: 'social_users')
  // // final List<dynamic>? socialUsers;
  //
  // @JsonKey(name: 'updated_at')
  // final String updatedAt; // 2023-08-24 12:40:53
  //
  // @JsonKey(name: 'verified_by')
  // final String? verifiedBy; // null
  //
  // @JsonKey(name: 'verified_by_nafath')
  // final int? verifiedByNafath; // 1
  // @JsonKey(name: 'telephone')
  // final String? telephone; // null

  Client({
    required this.id,
    required this.name,
    required this.gender,
    required this.birthdate,
    required this.mobile,
    required this.nationalId,
     this.mobileVerifiedAt,
    // required this.createdAt,
    // required this.mobileVerifiedAt,
    // required this.preferredLanguage,
    // required this.updatedAt,
    // this.address,
    this.nationalIdTypeId,
    // this.nationalIdType,
    this.active,
    // this.email,
    // this.clientId,
    // this.addedBy,
    // this.city,
    // this.cityId,
    // this.client,
    // this.clientTypeId,
    // this.company,
    // this.companyId,
    // this.country,
    // this.countryId,
    // this.creatorId,
    this.dataCompleted,
    // this.deletedAt,
    // // this.hospitals,
    // this.idEndDate,
    // this.ministryMember,
    // this.nationalityId,
    // this.region,
    // this.regionId,
    // // this.socialUsers,
    // this.verifiedBy,
    // this.verifiedByNafath,
    // this.telephone,
  });

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);

  Map<String, dynamic> toJson() => _$ClientToJson(this);
}
