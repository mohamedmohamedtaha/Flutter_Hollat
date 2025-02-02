import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hollat/core/global/reg.dart';
import 'package:hollat/core/global/validation/validation.dart';
import 'package:hollat/core/init/gen/translations.g.dart';
import 'package:hollat/core/utils/constants.dart';
import 'package:hollat/login/Navigator.dart';
import 'package:hollat/login/data/sharedpreferences/save_token.dart';
import 'package:hollat/login/data/viewmodel/config_viewmodel.dart';
import 'package:hollat/login/domain/usecases/nafaz_send_verify_code_reposetory_use_case.dart';
import 'package:hollat/login/presentation/widgets/custom_country_code_number.dart';
import 'package:hollat/login/presentation/widgets/custom_elevated_button.dart';
import 'package:hollat/login/presentation/widgets/custom_text_field.dart';
import 'package:hollat/login/views/login/splash_page.dart';
import 'package:hollat/login/views/login/verify_otp_page.dart';
import 'package:hollat/main/riverpod/providers.dart';

class NafazSendVerifyCodePage extends ConsumerStatefulWidget {
  const NafazSendVerifyCodePage({super.key});

  @override
  ConsumerState<NafazSendVerifyCodePage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<NafazSendVerifyCodePage> {
  TextEditingController controllerPhoneNumber = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  CountryCode _selectedCountry = CountryCode.fromCountryCode('SA');
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controllerEmail.dispose();
    controllerPhoneNumber.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    final state = ref.watch(normalLoginViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
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
                        PhoneNumberField(
                          controller: controllerPhoneNumber,
                          initialCountry: _selectedCountry,
                          onCountryChanged: (country) {
                            setState(() {
                              _selectedCountry = country;
                              final fullName =
                                  '${_selectedCountry.dialCode}${controllerPhoneNumber.text}';
                              print(' fullName: ${fullName}');
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return LocaleKeys.phoneRequired.tr();
                            }
                            if (!RegExp(RegException.phonePattern)
                                .hasMatch(value) ||
                                value.length != 9) {
                              return LocaleKeys.phoneRequired.tr();
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
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
                              return LocaleKeys.errorEmailRequired.tr();
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        Consumer(
                          builder: (context, ref, child) {
                            final state =
                            ref.watch(nafazSendVerifyCodeProvider);
                            final enableButton =
                            ref.watch(enableButtonProviderDefaultTrue);
                            state.whenOrNull(success: (data) {
                              WidgetsBinding.instance
                                  .addPostFrameCallback((_) async {
                                if (mounted) {
                                  ref
                                      .read(enableButtonProviderDefaultTrue
                                      .notifier)
                                      .state = true;
                                  ref
                                      .read(
                                      nafazSendVerifyCodeProvider.notifier)
                                      .restState();
                                  navigatorControllerPush(
                                      context,
                                      VerifyOtpPage(
                                        moveFrom: Constants.NAFAZ,
                                        phoneNumber: controllerPhoneNumber.text,
                                        captchaCode: '',
                                        captchaKey: '',
                                        nationalId: '',
                                      ));
                                }
                              });
                            }, error: (message, code) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                _sohwMessage(code, message);
                                ref
                                    .read(enableButtonProviderDefaultTrue
                                    .notifier)
                                    .state = true;
                              });
                            });
                            return CustomElevatedButton(
                              text: LocaleKeys.confirmationCode.tr(),
                              textStyle: const TextStyle(
                                  fontSize: 18, letterSpacing: 1.2),
                              enabled: enableButton,
                              onPressed: enableButton
                                  ? () {
                                var phone = Validation.checkPhone(
                                    controllerPhoneNumber.text);
                                if (!phone ||
                                    controllerPhoneNumber.text.length !=
                                        9) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    SnackBar(
                                      duration: Duration(seconds: 2),
                                      behavior: SnackBarBehavior.floating,
                                      content: Text(
                                          LocaleKeys.phoneRequired.tr()),
                                    ),
                                  );
                                  return;
                                }
                                var email = Validation.checkEmailAddress(
                                    controllerEmail.text);
                                if (!email) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    SnackBar(
                                      duration: Duration(seconds: 2),
                                      behavior: SnackBarBehavior.floating,
                                      content: Text(LocaleKeys
                                          .errorEmailRequired
                                          .tr()),
                                    ),
                                  );
                                  return;
                                }
                                var parameters = ResponseParameters(
                                    mobile: controllerPhoneNumber.text,
                                    email: controllerEmail.text);
                                //Send data to anther page
                                ref
                                    .read(nafazSendVerifyCodeProvider
                                    .notifier)
                                    .email = controllerEmail.text;

                                ref
                                    .read(nafazSendVerifyCodeProvider
                                    .notifier)
                                    .nafazSendVerifyCode(parameters);
                                ref
                                    .read(enableButtonProviderDefaultTrue
                                    .notifier)
                                    .state = false;
                              }
                                  : null,
                            );
                          },
                        )
                      ],
                    ),
                  );
                },
              )),
        ),
      ),
    );
  }

  void _sohwMessage(int code, String message) async {
    if (code == 401) {
      await deleteToken();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          content: Text(LocaleKeys.tokenExpired.tr()),
        ),
      );
      navigatorControllerPushAndRemoveUntil(context, SplashPage(), false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          content: Text(message),
        ),
      );
    }
  }
}
