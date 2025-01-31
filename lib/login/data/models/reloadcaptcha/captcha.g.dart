// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'captcha.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Captcha _$CaptchaFromJson(Map<String, dynamic> json) => Captcha(
      sensitive: json['sensitive'] as bool,
      key: json['key'] as String,
      img: json['img'] as String,
    );

Map<String, dynamic> _$CaptchaToJson(Captcha instance) => <String, dynamic>{
      'sensitive': instance.sensitive,
      'key': instance.key,
      'img': instance.img,
    };
