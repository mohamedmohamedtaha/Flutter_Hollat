import 'package:equatable/equatable.dart';
import 'package:hollat/login/data/models/client/city_data.dart';
import 'package:hollat/login/data/models/client/country_data.dart';
import 'package:hollat/login/data/models/client/national_id_type.dart';
import 'package:hollat/login/data/models/client/region_data.dart';

class ClientProfile extends Equatable {
  final int active; // 1
  final String? address; // null
  final String? birthDate; // 1988-07-03
  final CityData? city; // null
  final int? cityId; // null
  final String? client; // null
  final String? clientId; // null
  final String? clientType; // null
  final String? clientTypeId; // null
  final CountryData? country; // null
  final int? countryId; // null
  final String? createdAt; // 2024-08-13 19:26:17
  final int dataCompleted; // 1
  final String? deletedAt; // null
  final String? email; // mohamed.taha169@yahoo.com
  final String? gender; // null
  final int id; // 2598
  final String? idEndDate; // null
  final String? mobile; // +966535020871
  final String? mobileVerifiedAt; // null
  final String? name; // Mohamed taha
  final String? nationalId; // 2352946177
  final NationalIdType? nationalIdType;
  final int nationalIdTypeId; // 2
  final String? nationalityId; // null
  final String? preferredLanguage; // ar
  final RegionData? region;
  final int? regionId; // null
  final String? telephone; // null
  final String? ticketField; // null
  final String? updatedAt; // 2024-08-13 19:26:17
  final String? verifiedBy; // null
  final int? verifieBbyNafath;

  const ClientProfile(
  { required this.active,
    this.address,
    this.birthDate,
    this.city,
    this.cityId,
    this.client,
    this.clientId,
    this.clientType,
    this.clientTypeId,
    this.country,
    this.countryId,
    this.createdAt,
    required this.dataCompleted,
    this.deletedAt,
    this.email,
    this.gender,
    required this.id,
    this.idEndDate,
    this.mobile,
    this.mobileVerifiedAt,
    this.name,
    this.nationalId,
    this.nationalIdType,
    required this.nationalIdTypeId,
    this.nationalityId,
    this.preferredLanguage,
    this.region,
    this.regionId,
    this.telephone,
    this.ticketField,
    this.updatedAt,
    this.verifiedBy,
    this.verifieBbyNafath});

  @override
  List<Object?> get props => [
    active,
    address,
    birthDate,
    String,
    String,
    String,
    String,
    String,
    String,
    String,
    String,
    country,
    countryId,
    createdAt,
    dataCompleted,
    deletedAt,
    email,
    gender,
    id,
    idEndDate,
    mobile,
    mobileVerifiedAt,
    name,
    nationalId,
    nationalIdType,
    nationalIdTypeId,
    String,
    String,
    String,
    preferredLanguage,
    region,
    regionId,
    telephone,
    ticketField,
    updatedAt,
    verifiedBy,
    verifieBbyNafath,
  ];
}
