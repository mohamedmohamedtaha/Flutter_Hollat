import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hollat/core/global/reg.dart';
import 'package:hollat/core/global/theme/app_color/app_color_light.dart';
import 'package:hollat/core/global/validation/validation.dart';
import 'package:hollat/core/init/gen/translations.g.dart';
import 'package:hollat/core/utils/constants.dart';
import 'package:hollat/core/utils/show_error_message.dart';
import 'package:hollat/login/Navigator.dart';
import 'package:hollat/login/data/database/service_config_database.dart';
import 'package:hollat/login/data/viewmodel/config_viewmodel.dart';
import 'package:hollat/login/domain/usecases/nafaz_send_verify_code_reposetory_use_case.dart';
import 'package:hollat/login/presentation/widgets/custom_country_code_number.dart';
import 'package:hollat/login/presentation/widgets/custom_elevated_button.dart';
import 'package:hollat/login/presentation/widgets/custom_text_field.dart';
import 'package:hollat/login/views/login/verify_email/verify_otp_email_page.dart';
import 'package:hollat/login/views/login/verify_otp_page.dart';
import 'package:hollat/login/views/nav_page.dart';
import 'package:hollat/main/riverpod/providers.dart';

class NafazVerifyEmailPage extends ConsumerStatefulWidget {
  const NafazVerifyEmailPage({super.key});

  @override
  ConsumerState<NafazVerifyEmailPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<NafazVerifyEmailPage> {
  TextEditingController controllerEmail = TextEditingController();
  ServiceConfigDatabase? serviceConfig;
  String required ='';

  @override
  void initState() {
    super.initState();
    _resetButton(true);
    Future.microtask(() {
      serviceConfig = ref
          .watch(serviceConfigDatabaseViewModelProvider)
          .config;
      required =
          serviceConfig?.verifyEmailAfterSelfServiceLoginRequired ?? '';
       print('config data required:  ${required}');
    });
  }

  @override
  void dispose() {
    controllerEmail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery
        .of(context)
        .size
        .width;
    double heightScreen = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
        backgroundColor: AppColorsLight.lightGray,
        // dark blue color
        appBar: AppBar(
          backgroundColor: AppColorsLight.backgroundColorNafazCode,
          iconTheme: IconThemeData(color: AppColorsLight.whiteColor),
          elevation: 0,
        ),
        body:
         Column(
         children: [
           Container(
             width: double.infinity,
             height: heightScreen * 0.2,
             decoration: BoxDecoration(
                 color: AppColorsLight.backgroundColorNafazCode,
                 borderRadius: BorderRadius.only(
                     bottomLeft: Radius.circular(15.0),
                     bottomRight: Radius.circular(15.0))),
           ),
           SizedBox(height: 40.0,),
           Expanded(child:
           Container(
               width: double.infinity,
               decoration: BoxDecoration(
                 color: AppColorsLight.whiteColor,
               borderRadius: BorderRadius.only(
                   topLeft: Radius.circular(15.0),
                   topRight: Radius.circular(15.0))),
             child: SingleChildScrollView(
                 child: Column(
                   children: [
                     Padding(
                           padding: const EdgeInsets.all(20.0),
                           child: LayoutBuilder(
                             builder: (context, constraints) {
                               return FractionallySizedBox(
                                 widthFactor: widthScreen > 500 ? 0.5 : 1.0,
                                 child: Column(
                                   children: [
                                     SizedBox(
                                       height: 50.0,
                                     ),
                                     CustomTextField(
                                       controller: controllerEmail,
                                       labelText: LocaleKeys.email.tr(),
                                       hintText: LocaleKeys.emailHint.tr(),
                                       keyboardType: TextInputType.emailAddress,
                                       validator: (value) {
                                         if (value == null || value.isEmpty) {
                                           return LocaleKeys.emailRequired.tr();
                                         }
                                         if (!RegExp(RegException.emailPattern)
                                             .hasMatch(value)) {
                                           return LocaleKeys.errorEmailRequired
                                               .tr();
                                         }
                                         return null;
                                       },
                                     ),
                                     SizedBox(height: 20),
                                     Consumer(
                                       builder: (context, ref, child) {
                                         final verifyEmailState = ref.watch(
                                             verifyEmailViewModelProvider);
                                         final enableButton =
                                         ref.watch(
                                             enableButtonProviderDefaultTrue);
                                         verifyEmailState.whenOrNull(
                                             success: (data) {
                                               WidgetsBinding.instance
                                                   .addPostFrameCallback((
                                                   _) async {
                                                 if (mounted) {
                                                   _resetButton(true);
                                                   _resetVerifyEmail();
                                                   navigatorControllerPush(
                                                       context,
                                                       VerifyOtpEmailPage(
                                                         email:controllerEmail.text,
                                                       ));
                                                 }
                                               });
                                             }, error: (message, code) {
                                           showErrorMessage(
                                               context, code, message);
                                           _resetVerifyEmail();
                                           _resetButton(true);
                                         }, errorApi: (code, data) {
                                           showErrorMessageApi(
                                               context, code, data);
                                           _resetVerifyEmail();
                                           _resetButton(true);
                                         });
                                         return CustomElevatedButton(
                                           text: LocaleKeys.confirmationCode.tr(),
                                           textStyle: const TextStyle(
                                               fontSize: 18, letterSpacing: 1.2),
                                           enabled: enableButton,
                                           onPressed: enableButton
                                               ? () {
                                             _confirm();
                                           }
                                               : null,
                                         );
                                       },
                                     ),
                                     SizedBox(height: 20),
                                     if(required == "1")
                                       CustomElevatedButton(
                                         color: AppColorsLight.redColor,
                                         text: LocaleKeys.skip.tr(),
                                         textStyle: const TextStyle(
                                             fontSize: 18, letterSpacing: 1.2),
                                         enabled: true,
                                         onPressed: () {
                                           navigatorControllerPushAndRemoveUntil(context, NavPage(), false);
                                         },
                                       )
                                   ],
                                 ),
                               );
                             },
                           )),
                   ],
                 )
             ),
           ))
         ],)
          ,

    );
  }

  void _confirm() {
    var email = Validation.checkEmailAddress(
        controllerEmail.text);
    if (!email) {
      showMessage(context, LocaleKeys.errorEmailRequired.tr());
      return;
    }
    var parameters = ResponseParameters(
        mobile: '',
        email: controllerEmail.text);

    ref
        .read(verifyEmailViewModelProvider
        .notifier)
        .verifyEmail(parameters);
    _resetButton(false);
  }

  void _resetVerifyEmail() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(
          verifyEmailViewModelProvider.notifier)
          .restState();
    });
  }

  void _resetButton(bool state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(enableButtonProviderDefaultTrue
          .notifier)
          .state = state;
    });
  }

}
