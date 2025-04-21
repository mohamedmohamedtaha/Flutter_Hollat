import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hollat/core/global/theme/app_color/app_color_light.dart';
import 'package:hollat/core/global/theme/font/fonts_size.dart';
import 'package:hollat/core/global/validation/validation.dart';
import 'package:hollat/core/init/gen/translations.g.dart';
import 'package:hollat/core/utils/constants.dart';
import 'package:hollat/core/utils/show_error_message.dart';
import 'package:hollat/easy_localization/app_lang.dart';
import 'package:hollat/login/navigator.dart';
import 'package:hollat/login/data/models/reloadcaptcha/captcha.dart';
import 'package:hollat/login/data/models/send_otp/send_otp_model.dart';
import 'package:hollat/login/data/viewmodel/config_viewmodel.dart';
import 'package:hollat/login/network/repositores/normal_login_repository.dart';
import 'package:hollat/login/presentation/widgets/custom_captcha.dart';
import 'package:hollat/login/presentation/widgets/custom_country_code_number.dart';
import 'package:hollat/login/presentation/widgets/custom_elevated_button.dart';
import 'package:hollat/login/presentation/widgets/custom_text.dart';
import 'package:hollat/login/presentation/widgets/custom_text_field.dart';
import 'package:hollat/login/views/login/register_page.dart';
import 'package:hollat/login/views/login/verify_otp_page.dart';
import 'package:hollat/main/riverpod/providers.dart';

class NormalLoginPage extends ConsumerStatefulWidget {
  const NormalLoginPage({super.key});

  @override
  ConsumerState<NormalLoginPage> createState() => _NormalLoginPageState();
}

class _NormalLoginPageState extends ConsumerState<NormalLoginPage> {
  TextEditingController controllerPhoneNumber = TextEditingController();
  TextEditingController controllerCheckCode = TextEditingController();
  CountryCode _selectedCountry = CountryCode.fromCountryCode('SA');
  TextEditingController controllerIdNumber = TextEditingController();
  String key = '';
  String selfServiceOtpBy = '';

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        reloadCaptcha();
        ref.read(serviceConfigDatabaseViewModelProvider).getAllConfig();
        selfServiceOtpBy = ref
                .watch(serviceConfigDatabaseViewModelProvider)
                .config
                ?.selfServiceOtpBy ??
            '';
      },
    );
  }

  @override
  void dispose() {
    controllerCheckCode.dispose();
    controllerIdNumber.dispose();
    controllerPhoneNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColorsLight.transparentColor,
        elevation: 0, // f you want to hide back button
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(FontsSize.font_15),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return FractionallySizedBox(
                        widthFactor: widthScreen > 500 ? 0.5 : 1.0,
                        child: Column(
                          children: [
                            CircleAvatar(
                                radius: 100.0,
                                backgroundImage: AssetImage(
                                    'assets/images/hollatksa_logo.jpeg')),
                            SizedBox(
                              height: 30.0,
                            ),
                            PhoneNumberField(
                              controller: controllerPhoneNumber,
                              initialCountry: _selectedCountry,
                              onCountryChanged: (country) {
                                setState(() {
                                  _selectedCountry = country;
                                });
                              },
                              hintText: LocaleKeys.phoneHint.tr(),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return LocaleKeys.phoneRequired.tr();
                                }
                                var phone = Validation.checkPhone(
                                    controllerPhoneNumber.text);
                                if (!phone || value.length != 10) {
                                  return LocaleKeys.errorPhoneRequired.tr();
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              controller: controllerIdNumber,
                              labelText: LocaleKeys.idNumber.tr(),
                              hintText: LocaleKeys.enterYourId.tr(),
                              keyboardType: TextInputType.number,
                              prefixIcon: const Icon(Icons.person),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return LocaleKeys.yourIdNotValid.tr();
                                }
                                return null;
                              },
                              maxLength: 10,
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    controller: controllerCheckCode,
                                    hintText: LocaleKeys.checkCode.tr(),
                                    labelText: LocaleKeys.checkCodeHint.tr(),
                                    keyboardType: TextInputType.number,
                                    maxLength: 5,
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value.length < 5) {
                                        return LocaleKeys.checkCodeRequired
                                            .tr();
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(width: 10),
                                Consumer(builder: (context, ref, child) {
                                  final state =
                                      ref.watch(normalLoginViewModelProvider);
                                  return switch (state) {
                                    ConfigInitial() => const SizedBox.shrink(),
                                    ConfigLoading() => const Center(
                                        child: CircularProgressIndicator()),
                                    ConfigSuccess(:final data) =>
                                      _capatcha(data),
                                    ConfigErrorApi(:final code, :final data) =>
                                      _errorApi(code, data),
                                    ConfigError(:final message) =>
                                      CustomText('Error: $message'),
                                    NormalLoginRepository() =>
                                      throw UnimplementedError(),
                                  };
                                }),
                                SizedBox(width: 10),
                                InkWell(
                                  onTap: () {
                                    reloadCaptcha();
                                  },
                                  splashColor: Colors.teal,
                                  child: SvgPicture.asset(
                                    'assets/images/reload.svg',
                                    width: 24,
                                    height: 24,
                                    colorFilter: ColorFilter.mode(
                                        Colors.green.withValues(alpha: 1.0),
                                        BlendMode.srcIn),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            Consumer(
                              builder: (context, ref, child) {
                                var normalLoginState =
                                    ref.watch(normalSendOtpViewModelProvider);
                                final enableButton =
                                    ref.watch(enableButtonProviderDefaultTrue);

                                if (normalLoginState is ConfigLoading) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                                normalLoginState.whenOrNull(success: (data) {
                                  showMessage(context, data.message);
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) async {
                                    if (mounted) {
                                      _resetNormalSendOtp();
                                      if (selfServiceOtpBy == 'sms') {
                                        navigatorControllerPush(
                                            context,
                                            VerifyOtpPage(
                                              moveFrom: Constants.normal,
                                              phoneNumber:
                                                  controllerPhoneNumber.text,
                                              captchaKey: key,
                                              captchaCode:
                                                  controllerCheckCode.text,
                                              nationalId:
                                                  controllerIdNumber.text,
                                            ));
                                      } else {
                                        navigatorControllerPush(
                                            context,
                                            VerifyOtpPage(
                                              moveFrom: Constants.normal,
                                              phoneNumber:
                                                  controllerPhoneNumber.text,
                                              captchaKey: key,
                                              captchaCode:
                                                  controllerCheckCode.text,
                                              nationalId:
                                                  controllerIdNumber.text,
                                            ));
                                      }
                                    }
                                  });
                                }, error: (message, code) {
                                  showErrorMessage(context, code, message);
                                  _resetNormalSendOtp();
                                }, errorApi: (code, data) {
                                  showErrorMessageApi(context, code, data);
                                  _resetNormalSendOtp();
                                });
                                return Column(
                                  children: [
                                    CustomElevatedButton(
                                      text: LocaleKeys.login.tr(),
                                      enabled: enableButton,
                                      onPressed: enableButton
                                          ? () {
                                              _login();
                                            }
                                          : null,
                                    ),
                                    SizedBox(height: 10),
                                    CustomElevatedButton(
                                      text: LocaleKeys.createAccount.tr(),
                                      textStyle: const TextStyle(
                                          fontSize: 18, letterSpacing: 1.2),
                                      enabled: enableButton,
                                      onPressed: enableButton
                                          ? () {
                                              navigatorControllerPush(
                                                  context, RegisterPage());
                                            }
                                          : null,
                                    ),
                                  ],
                                );
                              },
                            ),

                            // Fixed bottom widget
                          ],
                        ),
                      );
                    },
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              // Center horizontally
              children: [
                Icon(
                  Icons.language,
                  size: 20.0,
                ),
                const SizedBox(
                  width: 8,
                ),
                InkWell(
                  onTap: () {
                    // Change to Arabic
                    setState(() {
                      // context.setLocale(AppLang.supportedLocales[1]);
                      AppLang.changeLanguage(context);
                    });
                  },
                  child: CustomText(
                    LocaleKeys.language.tr(),
                    style: TextStyle(
                        fontSize: FontsSize.font_16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _errorApi(int code, dynamic data) {
    showErrorMessageApi(context, code, data);
    key = data.key;
    return CustomText('Error Api');
  }

  Widget _capatcha(Captcha data) {
    key = data.key;
    return CustomCaptcha(captcha: data);
  }

  void reloadCaptcha() {
    ref.read(normalLoginViewModelProvider.notifier).reloadCaptcha();
  }

  void _resetNormalSendOtp() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(enableButtonProviderDefaultTrue.notifier).state = true;
      ref.read(normalSendOtpViewModelProvider.notifier).restState();
    });
  }

  void _login() {
    var phone = Validation.checkPhone(controllerPhoneNumber.text);
    if (!phone || controllerPhoneNumber.text.length != 9) {
      showMessage(context, LocaleKeys.errorPhoneRequired.tr());
      return;
    }
    var idNumber = controllerIdNumber.text;
    if (idNumber.isEmpty || idNumber.length != 10) {
      showMessage(context, LocaleKeys.yourIdNotValid.tr());
      return;
    }
    var checkCode = controllerCheckCode.text;
    if (checkCode.isEmpty || checkCode.length < 5) {
      showMessage(context, LocaleKeys.checkCodeRequired.tr());
      return;
    }

    var parameters = SendOtpModel(
        capatchaCode: controllerCheckCode.text,
        key: key,
        mobile: controllerPhoneNumber.text,
        nationalId: controllerIdNumber.text);
    ref.read(normalSendOtpViewModelProvider.notifier).sendOtp(parameters);
    ref.read(enableButtonProviderDefaultTrue.notifier).state = false;
  }
}
