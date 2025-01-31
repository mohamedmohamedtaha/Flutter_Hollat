import 'package:json_annotation/json_annotation.dart';

part 'nafath_response.g.dart';

@JsonSerializable()
class NafathResponse{
  @JsonKey(name: 'random')
  final String random;
  @JsonKey(name: 'transId')
  final String transId;
  NafathResponse({required this.random, required this.transId});
 factory NafathResponse.fromJson(Map<String,dynamic>json) => _$NafathResponseFromJson(json);
 Map<String,dynamic> toJson()=> _$NafathResponseToJson(this);

}