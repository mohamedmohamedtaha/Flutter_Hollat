import 'package:hollat/login/data/models/configresponse/header_color_model.dart';
import 'package:hollat/login/data/models/configresponse/logo_model.dart';
import 'package:hollat/login/data/models/configresponse/mini_log_model.dart';
import 'package:hollat/login/domain/entities/config_response/theme_config.dart';

class ThemeConfigModel extends ThemeConfig {
  ThemeConfigModel(
      {required super.logo,
        required super.miniLogo,
        required super.headerColor});

  factory ThemeConfigModel.fromJson(Map<String, dynamic> json) => ThemeConfigModel(
    logo: LogoModel.fromJson(json['LOGO'] as Map<String, dynamic>),
    miniLogo: MiniLogoModel.fromJson(json['MINI_LOGO'] as Map<String, dynamic>),
    headerColor:
    HeaderColorModel.fromJson(json['HEADER_COLOR'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson(ThemeConfigModel instance) =>
      <String, dynamic>{
        'LOGO': instance.logo,
        'MINI_LOGO': instance.miniLogo,
        'HEADER_COLOR': instance.headerColor,
      };

}
