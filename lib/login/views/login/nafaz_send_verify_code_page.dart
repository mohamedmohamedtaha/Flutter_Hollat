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
import 'package:hollat/login/navigator.dart';
import 'package:hollat/login/data/viewmodel/config_viewmodel.dart';
import 'package:hollat/login/domain/usecases/nafaz_send_verify_code_reposetory_use_case.dart';
import 'package:hollat/login/presentation/widgets/custom_country_code_number.dart';
import 'package:hollat/login/presentation/widgets/custom_elevated_button.dart';
import 'package:hollat/login/presentation/widgets/custom_text_field.dart';
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
    controllerEmail.dispose();
    controllerPhoneNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppColorsLight.lightGray, // dark blue color
        appBar: AppBar(
          backgroundColor: AppColorsLight.backgroundColorNafazCode,
          iconTheme: IconThemeData(color: AppColorsLight.whiteColor),
          elevation: 0,
        ),
        body: Container(
          color: AppColorsLight.textColorNafazCode,
          child: SingleChildScrollView(
              child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                    color: AppColorsLight.backgroundColorNafazCode,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0))),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColorsLight.whiteColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0))),
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
                                    // final fullName =
                                    //     '${_selectedCountry.dialCode}${controllerPhoneNumber.text}';
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
                                  final nafazSendVerifyCodeState =
                                      ref.watch(nafazSendVerifyCodeProvider);
                                  final enableButton = ref
                                      .watch(enableButtonProviderDefaultTrue);
                                  nafazSendVerifyCodeState.whenOrNull(
                                      success: (data) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) async {
                                      if (mounted) {
                                        _resetButton(true);
                                        _resetNafazSendVerifyCode();
                                        navigatorControllerPush(
                                            context,
                                            VerifyOtpPage(
                                              moveFrom: Constants.nafaz,
                                              phoneNumber:
                                                  controllerPhoneNumber.text,
                                              captchaCode: '',
                                              captchaKey: '',
                                              nationalId: '',
                                            ));
                                      }
                                    });
                                  }, error: (message, code) {
                                    showErrorMessage(context, code, message);
                                    _resetNafazSendVerifyCode();
                                    _resetButton(true);
                                  }, errorApi: (code, data) {
                                    showErrorMessageApi(context, code, data);
                                    _resetNafazSendVerifyCode();
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
                              )
                            ],
                          ),
                        );
                      },
                    )),
              ),
            ],
          )),
        ));
  }

  void _confirm() {
    var phone = Validation.checkPhone(controllerPhoneNumber.text);
    if (!phone || controllerPhoneNumber.text.length != 9) {
      showMessage(context, LocaleKeys.phoneRequired.tr());
      return;
    }
    var email = Validation.checkEmailAddress(controllerEmail.text);
    if (!email) {
      showMessage(context, LocaleKeys.errorEmailRequired.tr());
      return;
    }
    var parameters = ResponseParameters(
        mobile: controllerPhoneNumber.text, email: controllerEmail.text);
    ref.read(nafazSendVerifyCodeProvider.notifier).email = controllerEmail.text;

    ref
        .read(nafazSendVerifyCodeProvider.notifier)
        .nafazSendVerifyCode(parameters);
    _resetButton(false);
  }

  void _resetNafazSendVerifyCode() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(nafazSendVerifyCodeProvider.notifier).restState();
    });
  }

  void _resetButton(bool state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(enableButtonProviderDefaultTrue.notifier).state = state;
    });
  }
}
