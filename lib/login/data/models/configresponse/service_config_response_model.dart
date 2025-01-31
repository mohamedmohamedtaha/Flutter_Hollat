import 'package:hollat/login/data/models/configresponse/amplitude_enabled_model.dart';
import 'package:hollat/login/data/models/configresponse/client_details_model.dart';
import 'package:hollat/login/data/models/configresponse/maintenance_mode_model.dart';
import 'package:hollat/login/data/models/configresponse/min_chars_onDetails_model.dart';
import 'package:hollat/login/data/models/configresponse/nafaz_enable_model.dart';
import 'package:hollat/login/data/models/configresponse/self_service_otp_by_model.dart';
import 'package:hollat/login/data/models/configresponse/theme_config_model.dart';
import 'package:hollat/login/data/models/configresponse/verify_mobile_after_login_with_email_model.dart';
import 'package:hollat/login/domain/entities/config_response/nafaz_enable.dart';
import 'package:hollat/login/domain/entities/config_response/service_config_response.dart';

class ServiceConfigResponseModel extends ServiceConfigResponse {
  ServiceConfigResponseModel(
      {required super.nafathEnabled,
        required super.amplitudeEnabled,
        required super.clientDetails,
        required super.minCharsOnDetails,
        required super.maintenanceMode,
        required super.theme,
        required super.selfServiceOtpBy,
        super.verifyMobileAfterLoginWithEmail});


  factory ServiceConfigResponseModel.fromJson(
      Map<String, dynamic> json) =>
      ServiceConfigResponseModel(
        nafathEnabled: NafazEnabledModel.fromJson(
            json['NAFATH_ENABLED'] as Map<String, dynamic>),
        amplitudeEnabled: AmplitudeEnabledModel.fromJson(
            json['AmplitudeEnabled'] as Map<String, dynamic>),
        clientDetails: ClientDetailsModel.fromJson(
            json['CLIENT_DETAILS'] as Map<String, dynamic>),
        minCharsOnDetails: MinCharsOnDetailsModel.fromJson(
            json['MIN_CHARS_ON_DETAILS'] as Map<String, dynamic>),
        maintenanceMode: MaintenanceModeModel.fromJson(
            json['MAINTENANCE_MODE'] as Map<String, dynamic>),
        theme: ThemeConfigModel.fromJson(json['THEME'] as Map<String, dynamic>),
        selfServiceOtpBy: SelfServiceOtpByModel.fromJson(json['SELF_SERVICE_OTP_BY'] as Map<String,dynamic>),
        verifyMobileAfterLoginWithEmail: VerifyMobileAfterLoginWithEmailModel.fromJson(json['VERIFY_MOBILE_AFTER_LOGIN_WITH_EMAIL'] as Map<String,dynamic>),
      );

  Map<String, dynamic> toJson(
      ServiceConfigResponseModel instance) =>
      <String, dynamic>{
        'NAFATH_ENABLED': instance.nafathEnabled,
        'AmplitudeEnabled': instance.amplitudeEnabled,
        'CLIENT_DETAILS': instance.clientDetails,
        'MIN_CHARS_ON_DETAILS': instance.minCharsOnDetails,
        'MAINTENANCE_MODE': instance.maintenanceMode,
        'THEME': instance.theme,
        'SELF_SERVICE_OTP_BY': instance.selfServiceOtpBy,
        'VERIFY_MOBILE_AFTER_LOGIN_WITH_EMAIL':
        instance.verifyMobileAfterLoginWithEmail,
      };

}
