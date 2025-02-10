import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hollat/core/global/theme/app_color/app_color_light.dart';
import 'package:hollat/core/global/theme/font/fonts_size.dart';
import 'package:hollat/core/init/gen/translations.g.dart';
import 'package:hollat/core/utils/show_error_message.dart';
import 'package:hollat/login/Navigator.dart';
import 'package:hollat/login/data/models/login_response/login_response_model.dart';
import 'package:hollat/login/data/viewmodel/config_viewmodel.dart';
import 'package:hollat/login/data/viewmodel/timer_view_model.dart';
import 'package:hollat/login/domain/usecases/nafaz_send_verify_code_reposetory_use_case.dart';
import 'package:hollat/login/presentation/widgets/custom_elevated_button.dart';
import 'package:hollat/login/presentation/widgets/custom_text.dart';
import 'package:hollat/login/views/nav_page.dart';
import 'package:hollat/main/riverpod/providers.dart';

class VerifyOtpEmailPage extends ConsumerStatefulWidget {
  final String email;

  const VerifyOtpEmailPage({super.key, required this.email});

  @override
  ConsumerState<VerifyOtpEmailPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends ConsumerState<VerifyOtpEmailPage> {
  final List<TextEditingController> _controllers =
  List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  String formatDuration(int totalSeconds) {
    final int minutes = totalSeconds ~/ 60;
    final int seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _clearFields() {
    for (var controller in _controllers) {
      controller.clear();
    }
    _focusNodes[0].requestFocus();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(timerViewModelProvider.notifier).startTimer(1);
    });
    _clearFields();
    // Add listeners to each TextField to handle input
    for (int i = 0; i < _controllers.length; i++) {
      _controllers[i].addListener(() {
        if (_controllers[i].text.length == 1) {
          if (i + 1 < _focusNodes.length) {
            //Move to the next focus node
            FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
          }
        }
      });
    }

    // Start your timer here and update the state accordingly
  }

  @override
  void dispose() {
    // Dispose controllers and focus nodes
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: AppColorsLight.lightGray, // dark blue color
        appBar: AppBar(
          backgroundColor: AppColorsLight.backgroundColorNafazCode,
          iconTheme: IconThemeData(color: AppColorsLight.whiteColor),
          elevation: 0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
            SizedBox(
              height: 40.0,
            ),
            Expanded(
                child: Container(
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
                              padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  return FractionallySizedBox(
                                    widthFactor: widthScreen > 500 ? 0.5 : 1.0,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 10),
                                        Image.asset(
                                          'assets/images/icon_code_confirm.png',
                                          width: 200,
                                          height: 150,
                                          fit: BoxFit.cover,
                                          alignment: Alignment.center,
                                        ),
                                        // Placeholder for image
                                        CustomText(
                                          LocaleKeys.confirmationCode.tr(),
                                          color: AppColorsLight.primaryColor,
                                          fontSize: FontsSize.font_20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        SizedBox(height: 10),
                                        CustomText(
                                          LocaleKeys.confirmText.tr(),
                                          fontSize: FontsSize.font_18,
                                        ),
                                        CustomText(
                                          color: AppColorsLight.primaryColor,
                                          widget.email,
                                          fontSize: FontsSize.font_18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: List.generate(6, (index) {
                                            return SizedBox(
                                              width: 40,
                                              child: TextField(
                                                controller: _controllers[index],
                                                focusNode: _focusNodes[index],
                                                textAlign: TextAlign.center,
                                                keyboardType: TextInputType.number,
                                                maxLength: 1,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                ),
                                                onChanged: (value) {
                                                  if (value.length == 1) {
                                                    // Move to next field if the input is complete
                                                    if (index <
                                                        _controllers.length - 1) {
                                                      FocusScope.of(context)
                                                          .requestFocus(_focusNodes[
                                                      index + 1]);
                                                    }
                                                  }
                                                },
                                              ),
                                            );
                                          }),
                                        ),
                                        SizedBox(height: 20),
                                        Consumer(
                                          builder: (context, ref, child) {
                                            var timerState =
                                            ref.watch(timerViewModelProvider);
                                            if (timerState <= 0) {
                                              _resetDefaultButton(false);
                                              _resetAntherButton(true);
                                            } else {
                                              _resetAntherButton(false);
                                            }
                                            return CustomText(
                                              formatDuration(timerState),
                                              textAlign: TextAlign.center,
                                              fontSize: FontsSize.font_15,
                                              fontWeight: FontWeight.bold,
                                              color: AppColorsLight.primaryColor,
                                            );
                                          },
                                        ),
                                        SizedBox(height: 20),
                                        Consumer(
                                          builder: (context, ref, child) {
                                            //Nafaz response
                                            final verifyOtpEmailState = ref
                                                .watch(verifyOtpEmailPageProvider);
                                            final enableButtonProviderDefault =
                                            ref.watch(
                                                enableButtonProviderDefaultTrue);
                                            // Check if the API is in loading state for nafaz
                                            if (verifyOtpEmailState
                                            is ConfigLoading) {
                                              return Center(
                                                  child:
                                                  CircularProgressIndicator());
                                            }

                                            verifyOtpEmailState.whenOrNull(
                                                success: (data) {
                                                  goToMainPage();
                                                }, error: (message, code) {
                                              showErrorMessage(
                                                  context, code, message);
                                              _resetDefaultButton(true);
                                              _resetVerifyOtpEmail();
                                            }, errorApi: (code, data) {
                                              showErrorMessageApi(
                                                  context, code, data);
                                              _resetDefaultButton(true);
                                              _resetVerifyOtpEmail();
                                            });

                                            return CustomElevatedButton(
                                              text:
                                              LocaleKeys.confirmationCode.tr(),
                                              textStyle: const TextStyle(
                                                  fontSize: 18, letterSpacing: 1.2),
                                              enabled: enableButtonProviderDefault,
                                              onPressed: enableButtonProviderDefault
                                                  ? () {
                                                _callVerifyOtpEmail();
                                              }
                                                  : null,
                                            );
                                          },
                                        ),
                                        Consumer(
                                          builder: (context, ref, child) {
                                            final enableButton =
                                            ref.watch(enableButtonProvider);
                                            //Nafaz response resend
                                            final verifyEmailState = ref.watch(
                                                verifyEmailViewModelProvider);
                                            if (verifyEmailState is ConfigLoading) {
                                              return Center(
                                                  child:
                                                  CircularProgressIndicator());
                                            }
                                            verifyEmailState.whenOrNull(
                                                success: (data) {
                                                  WidgetsBinding.instance
                                                      .addPostFrameCallback((_) {
                                                    _resetDefaultButton(true);
                                                    _resetVerifyEmail();
                                                    ref
                                                        .read(timerViewModelProvider
                                                        .notifier)
                                                        .resetTimer(1);
                                                  });
                                                }, error: (message, code) {
                                              showErrorMessage(
                                                  context, code, message);
                                              _resetAntherButton(true);
                                              _resetVerifyEmail();
                                            }, errorApi: (code, data) {
                                              showErrorMessageApi(
                                                  context, code, data);
                                              _resetAntherButton(true);
                                              _resetVerifyEmail();
                                            });
                                            return Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              // Center horizontally
                                              children: [
                                                Icon(
                                                  Icons.sync,
                                                  color: AppColorsLight.redColor,
                                                  size: 20.0,
                                                ),
                                                TextButton(
                                                  onPressed: enableButton
                                                      ? () {
                                                    _resendVerifyEmail();
                                                  }
                                                      : null,
                                                  child: Text(
                                                    LocaleKeys.resendCode.tr(),
                                                    style: TextStyle(
                                                        color: enableButton
                                                            ? Colors.red
                                                            : Colors.grey),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  );
                                },
                              )),

                      ],
                    ),
                  ),
                ))
          ],
        ));
  }

  void goToMainPage() {
    _resetVerifyOtpEmail();
    _resetVerifyEmail();
    _mainPage();
  }

  void _resetVerifyOtpEmail() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref.read(verifyOtpEmailPageProvider.notifier).restState();
      }
    });
  }

  void _resetAntherButton(bool state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref.read(enableButtonProvider.notifier).state = state;
      }
    });
  }

  void _resetDefaultButton(bool state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref.read(enableButtonProviderDefaultTrue.notifier).state = state;
      }
    });
  }

  void _callVerifyOtpEmail() {
    final otpCode = _controllers.map((c) => c.text.trim()).join();
    if (otpCode.isEmpty && otpCode.length != 6) {
      showMessage(context, LocaleKeys.confirmationCodeRequired.tr());
      return;
    }

    var loginResponseParameters =
    LoginResponseParameters(otpCode: otpCode, mobile: '', nationalId: '');
    ref
        .read(verifyOtpEmailPageProvider.notifier)
        .verifyOtpEmail(loginResponseParameters);

    _resetDefaultButton(false);
  }

  void _resetVerifyEmail() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(verifyEmailViewModelProvider.notifier).restState();
    });
  }

  void _resendVerifyEmail() {
    var parameters = ResponseParameters(mobile: '', email: widget.email);

    ref.read(verifyEmailViewModelProvider.notifier).verifyEmail(parameters);
    _resetAntherButton(false);
    _clearFields();
  }

  void _mainPage() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        ref.read(timerViewModelProvider.notifier).stopTimer();

        // var token  =data.token ?? '';
        // if (token.isNotEmpty) {
        //   await deleteToken();
        //   await saveToken(token);
        // } else {
        //   if (kDebugMode) {
        //     print('Token is null can not save.');
        //   }
        // }

        navigatorControllerPushAndRemoveUntil(context, NavPage(), false);
      }
    });
  }
}
