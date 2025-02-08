import 'package:equatable/equatable.dart';
import 'package:hollat/login/domain/entities/config_response/header_color.dart';
import 'package:hollat/login/domain/entities/config_response/logo.dart';
import 'package:hollat/login/domain/entities/config_response/mini_logo.dart';

class ThemeConfig extends Equatable {
  final Logo logo;

  final MiniLogo miniLogo;
  final HeaderColor headerColor;

  const ThemeConfig({
    required this.logo,
    required this.miniLogo,
    required this.headerColor,
  });

  @override
  List<Object> get props => [logo, miniLogo, headerColor];
}