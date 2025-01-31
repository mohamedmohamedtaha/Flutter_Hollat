import 'package:hollat/login/data/models/nationaltypes/NationalTypes.dart';
import 'package:json_annotation/json_annotation.dart';
part 'national_types_response.g.dart';

@JsonSerializable()
class NationalTypesResponse{
  final List<NationalTypes>data;
  NationalTypesResponse({required this.data});
  factory NationalTypesResponse.fromJson(Map<String, dynamic> json) =>
      _$NationalTypesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NationalTypesResponseToJson(this);
}