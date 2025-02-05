import 'package:equatable/equatable.dart';

class UpdateProfile extends Equatable {
  final String name;
  final String nationalId;
  final String countryId;
  final String regionId;
  final String cityId;
  final String mobile;
  final String email;
  final String birthDay;
  final String idEndDate;

  const UpdateProfile({required this.name,required  this.nationalId,required  this.countryId,required  this.regionId,
    required  this.cityId,required  this.mobile, required this.email, required this.birthDay,required  this.idEndDate});

  @override
  List<Object> get props =>
      [
        name,
        nationalId,
        countryId,
        regionId,
        cityId,
        mobile,
        email,
        birthDay,
        idEndDate,
      ];
}