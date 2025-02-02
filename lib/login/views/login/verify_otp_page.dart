import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hollat/core/global/theme/app_color/app_color_light.dart';
import 'package:hollat/core/global/theme/font/fonts_size.dart';
import 'package:hollat/core/init/gen/translations.g.dart';
import 'package:hollat/core/utils/constants.dart';
import 'package:hollat/core/utils/show_error_message.dart';
import 'package:hollat/login/Navigator.dart';
import 'package:hollat/login/data/models/login_response/login_response_model.dart';
import 'package:hollat/login/data/models/send_otp/send_otp_model.dart';
import 'package:hollat/login/data/sharedpreferences/save_token.dart';
import 'package:hollat/login/data/viewmodel/config_viewmodel.dart';
import 'package:hollat/login/data/viewmodel/timer_view_model.dart';
import 'package:hollat/login/domain/usecases/nafaz_send_verify_code_reposetory_use_case.dart';
import 'package:hollat/login/presentation/widgets/custom_elevated_button.dart';
import 'package:hollat/login/presentation/widgets/custom_text.dart';
import 'package:hollat/login/views/login/splash_page.dart';
import 'package:hollat/login/views/nav_page.dart';
import 'package:hollat/main/riverpod/providers.dart';

class VerifyOtpPage extends ConsumerStatefulWidget {
  final String moveFrom;
  final String phoneNumber; // Example phone number
  final String nationalId;
  final String captchaKey;
  final String captchaCode;

  const VerifyOtpPage(
      {required this.moveFrom,
        required this.phoneNumber,
        required this.nationalId,
        required this.captchaKey,
        required this.captchaCode,
        super.key});

  @override
  ConsumerState<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends ConsumerState<VerifyOtpPage> {
  final List<TextEditingController> _controllers =
  List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  String formatDuration(int totalSeconds) {
    final int minutes = totalSeconds ~/ 60;
    final int seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
  void _clearFields(){
    for(var controller in _controllers){
      controller.clear();
    }
    _focusNodes[0].requestFocus();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask((){
      ref.read(timerViewModelProvider.notifier).startTimer();
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
    return Scaffold(
      backgroundColor: AppColorsLight.lightGray, // dark blue color
      appBar: AppBar(
        backgroundColor: AppColorsLight.textColorNafazCode,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
                color: AppColorsLight.textColorNafazCode,
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
                child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return FractionallySizedBox(
                          widthFactor: widthScreen > 500 ? 0.5 : 1.0,
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              Image.asset(
                                'assets/images/icon_code_confirm.png',
                                width: 150,
                                height: 100,
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                              ),
                              // Placeholder for image
                              CustomText(
                                LocaleKeys.confirmationCode.tr(),
                                color: AppColorsLight.primaryColor,
                                // Example string
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(height: 10),
                               CustomText(LocaleKeys.confirmText.tr(),
                              fontSize: FontsSize.font_18,),
                              // Example string
                              CustomText(
                                color: AppColorsLight.primaryColor,
                                widget.phoneNumber, // Display phone number
                                style: TextStyle(
                                    color: AppColorsLight.colorPrimaryDark),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                          if (index < _controllers.length - 1) {
                                            FocusScope.of(context).requestFocus(
                                                _focusNodes[index + 1]);
                                          }
                                        }
                                      },
                                    ),
                                  );
                                }),
                              ),
                              SizedBox(height: 20),
                             Consumer(builder: (context, ref, child) {
                               var state = ref.watch(timerViewModelProvider);
                               if(state <=0){
                                 WidgetsBinding.instance.addPostFrameCallback((_){
                                    if (mounted) {
                                     ref.read(enableButtonProvider.notifier).state = true;
                                     ref.read(enableButtonProviderDefaultTrue.notifier).state = false;
                                   }
                                 });
                               }
                              return CustomText(
                                 formatDuration(state),
                                 textAlign: TextAlign.center,
                                 color: AppColorsLight.primaryColor,
                               );
                             },),
                              SizedBox(height: 20),
                              Consumer(
                                builder: (context, ref, child) {
                                  //Nafaz response
                                  final nafazState =
                                  ref.watch(nafazVerifyMobileViewModelProvider);
                                  final enableButtonProviderDefault =
                                  ref.watch(enableButtonProviderDefaultTrue);
                                  // Check if the API is in loading state for nafaz
                                  if (nafazState is ConfigLoading) {
                                    return Center(child: CircularProgressIndicator());
                                  }

                                  nafazState.whenOrNull(success: (data) {
                                    goToMainPage();
                                  }, error: (message, code) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      _sohwMessage(code, message);
                                      ref
                                          .read(enableButtonProviderDefaultTrue
                                          .notifier)
                                          .state = true;
                                      ref
                                          .read(nafazVerifyMobileViewModelProvider
                                          .notifier)
                                          .restState();
                                    });
                                  }, errorApi: (code, data) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      showErrorMessageApi(context, code, data);
                                      ref
                                          .read(enableButtonProviderDefaultTrue
                                          .notifier)
                                          .state = true;
                                      ref
                                          .read(nafazVerifyMobileViewModelProvider
                                          .notifier)
                                          .restState();
                                    });
                                  });
                                  //Verify code
                                  final verifyState =
                                  ref.watch(verifyOtpVieWModelProvider);

                                  if (verifyState is ConfigLoading) {
                                    return Center(child: CircularProgressIndicator());
                                  }
                                  verifyState.whenOrNull(success: (data) {
                                    goToMainPage();
                                  }, error: (message, code) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      _sohwMessage(code, message);
                                      ref
                                          .read(enableButtonProviderDefaultTrue
                                          .notifier)
                                          .state = true;
                                      ref
                                          .read(verifyOtpVieWModelProvider.notifier)
                                          .restState();
                                    });
                                  }, errorApi: (code, data) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      showErrorMessageApi(context, code, data);
                                      ref
                                          .read(enableButtonProviderDefaultTrue
                                          .notifier)
                                          .state = true;
                                      ref
                                          .read(verifyOtpVieWModelProvider.notifier)
                                          .restState();
                                    });
                                  });

                                  return CustomElevatedButton(
                                    text: LocaleKeys.confirmationCode.tr(),
                                    textStyle: const TextStyle(
                                        fontSize: 18, letterSpacing: 1.2),
                                    enabled: enableButtonProviderDefault,
                                    onPressed: enableButtonProviderDefault
                                        ? () {
                                      final otpCode = _controllers
                                          .map((c) => c.text.trim())
                                          .join();
                                      if (otpCode.isEmpty &&
                                          otpCode.length != 6) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            duration: Duration(seconds: 2),
                                            behavior:
                                            SnackBarBehavior.floating,
                                            content: Text(LocaleKeys
                                                .confirmationCodeRequired
                                                .tr()),
                                          ),
                                        );
                                        return;
                                      }
                                      if (widget.moveFrom ==
                                          Constants.NAFAZ) {
                                        var loginResponseParameters =
                                        LoginResponseParameters(
                                            otpCode: otpCode,
                                            mobile: widget.phoneNumber,
                                            nationalId:
                                            widget.nationalId);
                                        ref
                                            .read(
                                            nafazVerifyMobileViewModelProvider
                                                .notifier)
                                            .nafathVerifyMobile(
                                            loginResponseParameters);
                                      } else if (widget.moveFrom ==
                                          Constants.NORMAL) {
                                        var parameters =
                                        LoginResponseParameters(
                                            otpCode: otpCode,
                                            mobile: widget.phoneNumber,
                                            nationalId:
                                            widget.nationalId);

                                        ref
                                            .read(verifyOtpVieWModelProvider
                                            .notifier)
                                            .verifyOtp(parameters);
                                      }
                                      ref
                                          .read(
                                          enableButtonProviderDefaultTrue
                                              .notifier)
                                          .state = false;
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
                                  final nafazState =
                                  ref.watch(resendNafazSendVerifyCodeProvider);
                                  if (nafazState is ConfigLoading) {
                                    return Center(child: CircularProgressIndicator());
                                  }
                                  nafazState.whenOrNull(success: (data) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      ref
                                          .read(enableButtonProviderDefaultTrue
                                          .notifier)
                                          .state = true;
                                      ref.read(timerViewModelProvider.notifier).resetTimer();
                                    });
                                  }, error: (message, code) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      _sohwMessage(code, message);
                                      ref
                                          .read(enableButtonProvider.notifier)
                                          .state = true;
                                      ref
                                          .read(resendNafazSendVerifyCodeProvider
                                          .notifier)
                                          .restState();
                                    });
                                  }, errorApi: (code, data) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      showErrorMessageApi(context, code, data);
                                      ref
                                          .read(enableButtonProviderDefaultTrue
                                          .notifier)
                                          .state = true;
                                      ref
                                          .read(resendNafazSendVerifyCodeProvider
                                          .notifier)
                                          .restState();
                                    });
                                  });

                                  //Verify code resend
                                  final verifyState =
                                  ref.watch(sendOtpViewModelProvider);
                                  if (verifyState is ConfigLoading) {
                                    return Center(child: CircularProgressIndicator());
                                  }
                                  verifyState.whenOrNull(success: (data) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      ref
                                          .read(enableButtonProviderDefaultTrue
                                          .notifier)
                                          .state = true;
                                      ref.read(timerViewModelProvider.notifier).resetTimer();

                                    });
                                  }, error: (message, code) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      _sohwMessage(code, message);
                                      ref
                                          .read(enableButtonProvider.notifier)
                                          .state = true;
                                      ref
                                          .read(sendOtpViewModelProvider.notifier)
                                          .restState();
                                    });
                                  }, errorApi: (code, data) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      showErrorMessageApi(context, code, data);
                                      ref
                                          .read(enableButtonProviderDefaultTrue
                                          .notifier)
                                          .state = true;
                                      ref
                                          .read(sendOtpViewModelProvider.notifier)
                                          .restState();
                                    });
                                  });

                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                          if (widget.moveFrom ==
                                              Constants.NAFAZ) {
                                            var email = ref
                                                .watch(
                                                nafazSendVerifyCodeProvider
                                                    .notifier)
                                                .email;
                                            var parameters =
                                            ResponseParameters(
                                                mobile:
                                                widget.phoneNumber,
                                                email: email);

                                            ref
                                                .read(
                                                resendNafazSendVerifyCodeProvider
                                                    .notifier)
                                                .nafazSendVerifyCode(
                                                parameters);
                                          } else if (widget.moveFrom ==
                                              Constants.NORMAL) {
                                            var parameters = SendOtpModel(
                                                capatchaCode:
                                                widget.captchaCode,
                                                key: widget.captchaKey,
                                                mobile: widget.phoneNumber,
                                                nationalId:
                                                widget.nationalId);
                                            ref
                                                .read(sendOtpViewModelProvider
                                                .notifier)
                                                .sendOtp(parameters);
                                          }
                                          ref
                                              .read(enableButtonProvider
                                              .notifier)
                                              .state = false;
                                          _clearFields();
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
              ))
        ],
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

  void goToMainPage() {
    // Schedule timer start after build completes
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(nafazVerifyMobileViewModelProvider.notifier).restState();
      ref.read(verifyOtpVieWModelProvider.notifier).restState();
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
