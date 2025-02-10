import 'package:equatable/equatable.dart';
import 'package:hollat/login/data/models/configresponse/amplitude_enabled_model.dart';
import 'package:hollat/login/data/models/configresponse/client_details_model.dart';
import 'package:hollat/login/data/models/configresponse/maintenance_mode_model.dart';
import 'package:hollat/login/data/models/configresponse/min_chars_onDetails_model.dart';
import 'package:hollat/login/data/models/configresponse/nafaz_enable_model.dart';
import 'package:hollat/login/data/models/configresponse/theme_config_model.dart';
import 'package:hollat/login/data/models/configresponse/verify_email_after_self_service_login_enabled_model.dart';
import 'package:hollat/login/data/models/configresponse/verify_email_after_self_service_login_required_model.dart';
import 'package:hollat/login/domain/entities/config_response/amplitude_enabled.dart';
import 'package:hollat/login/domain/entities/config_response/client_details.dart';
import 'package:hollat/login/domain/entities/config_response/maintenance_mode.dart';
import 'package:hollat/login/domain/entities/config_response/min_chars_on_details.dart';
import 'package:hollat/login/domain/entities/config_response/nafaz_enable.dart';
import 'package:hollat/login/data/models/configresponse/self_service_otp_by_model.dart';
import 'package:hollat/login/domain/entities/config_response/theme_config.dart';
import 'package:hollat/login/data/models/configresponse/verify_mobile_after_login_with_email_model.dart';
import 'package:hollat/login/domain/entities/config_response/verify_email_after_self_service_login_enabled.dart';
import 'package:hollat/login/domain/entities/config_response/verify_email_after_self_service_login_required.dart';
import 'package:hollat/login/domain/entities/config_response/verify_mobile_after_login_with_email.dart';

import 'self_service_otp_by.dart';

class ServiceConfigResponse extends Equatable {
  final NafazEnabled nafathEnabled;

  final AmplitudeEnabled amplitudeEnabled;

  final ClientDetails clientDetails;

  final MinCharsOnDetails minCharsOnDetails;

  final MaintenanceMode maintenanceMode;

  final ThemeConfig theme;

  final SelfServiceOtpBy selfServiceOtpBy;

  final VerifyMobileAfterLoginWithEmail verifyMobileAfterLoginWithEmail;

  final VerifyEmailAfterSelfServiceLoginRequired verifyEmailAfterSelfServiceLoginRequired;
  final VerifyEmailAfterSelfServiceLoginEnabled verifyEmailAfterSelfServiceLoginEnabled;

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
    required this.verifyMobileAfterLoginWithEmail,
    required this.verifyEmailAfterSelfServiceLoginRequired,
    required this.verifyEmailAfterSelfServiceLoginEnabled
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
        verifyEmailAfterSelfServiceLoginRequired,
        verifyEmailAfterSelfServiceLoginEnabled
      ];
}