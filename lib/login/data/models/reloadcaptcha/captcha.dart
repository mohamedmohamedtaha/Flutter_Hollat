import 'package:json_annotation/json_annotation.dart';

part 'captcha.g.dart';

@JsonSerializable()
class Captcha {
  @JsonKey(name: 'sensitive')
  final bool sensitive;
  @JsonKey(name: 'key')
  final String key;
  @JsonKey(name: 'img')
  final String img;

  Captcha({
    required this.sensitive,
    required this.key,
    required this.img,
  });

  factory Captcha.fromJson(Map<String, dynamic> json) =>
      _$CaptchaFromJson(json);

  Map<String, dynamic> toJson() => _$CaptchaToJson(this);
}
