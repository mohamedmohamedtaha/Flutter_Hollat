import 'package:equatable/equatable.dart';
import 'package:hollat/login/domain/entities/config_response/amplitude_enabled.dart';
import 'package:hollat/login/domain/entities/config_response/client_details.dart';
import 'package:hollat/login/domain/entities/config_response/maintenance_mode.dart';
import 'package:hollat/login/domain/entities/config_response/min_chars_on_details.dart';
import 'package:hollat/login/domain/entities/config_response/nafaz_enable.dart';
import 'package:hollat/login/data/models/configresponse/self_service_otp_by_model.dart';
import 'package:hollat/login/domain/entities/config_response/theme_config.dart';
import 'package:hollat/login/data/models/configresponse/verify_mobile_after_login_with_email_model.dart';

class ServiceConfigResponse extends Equatable {
  final NafazEnabled nafathEnabled;

  final AmplitudeEnabled amplitudeEnabled;

  final ClientDetails clientDetails;

  final MinCharsOnDetails minCharsOnDetails;

  final MaintenanceMode maintenanceMode;

  final ThemeConfig theme;

  final SelfServiceOtpByModel selfServiceOtpBy;

  final VerifyMobileAfterLoginWithEmailModel? verifyMobileAfterLoginWithEmail;

  // @JsonKey(name: 'FILES_FEATURE')
  // final FilesFeature filesFeature;
  //
  // @JsonKey(name: 'SelfService_ENABLED')
  // final SelfServiceEnabled selfServiceEnabled;
  //
  // @JsonKey(name: 'CONTACT_US')
  // final ContactUs contactUs;

  // Add all other fields following the same pattern

  const ServiceConfigResponse({
    required this.nafathEnabled,
    required this.amplitudeEnabled,
    required this.clientDetails,
    required this.minCharsOnDetails,
    required this.maintenanceMode,
    required this.theme,
    required this.selfServiceOtpBy,
    this.verifyMobileAfterLoginWithEmail,
    // required this.filesFeature,
    // required this.selfServiceEnabled,
    // required this.contactUs,
  });

  @override
  List<Object?> get props =>
      [
        nafathEnabled,
        amplitudeEnabled,
        clientDetails,
        minCharsOnDetails,
        maintenanceMode,
        theme,
        selfServiceOtpBy,
        verifyMobileAfterLoginWithEmail,
      ];
}