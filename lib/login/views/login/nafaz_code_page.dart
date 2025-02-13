import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hollat/core/global/theme/app_color/app_color_light.dart';
import 'package:hollat/core/global/theme/font/fonts_size.dart';
import 'package:hollat/core/init/gen/translations.g.dart';
import 'package:hollat/core/utils/show_error_message.dart';
import 'package:hollat/login/Navigator.dart';
import 'package:hollat/login/data/models/nafath/nafaz_status.dart';
import 'package:hollat/login/data/models/nafath/nafaz_status_response.dart';
import 'package:hollat/login/data/sharedpreferences/save_token.dart';
import 'package:hollat/login/data/viewmodel/config_viewmodel.dart';
import 'package:hollat/login/presentation/widgets/custom_status_button.dart';
import 'package:hollat/login/presentation/widgets/custom_text.dart';
import 'package:hollat/login/presentation/widgets/custom_text_button.dart';
import 'package:hollat/login/views/login/nafaz_send_verify_code_page.dart';
import 'package:hollat/main/riverpod/providers.dart';

class NafazCodePage extends ConsumerStatefulWidget {
  final String nationalId;
  final String randomCode;
  final String transId;

  const NafazCodePage(
      {super.key,
        required this.nationalId,
        required this.randomCode,
        required this.transId});

  @override
  ConsumerState<NafazCodePage> createState() => _NafazCodePageState();
}

class _NafazCodePageState extends ConsumerState<NafazCodePage> {
  Timer? _timer;
  String _code = '';
  String transId = '';

  @override
  void initState() {
    super.initState();
    _code = widget.randomCode;
    transId = widget.transId;
    Future.microtask(() {
      _resetButton(false);
      _startTimer();
    });
  }

  void callNafazStatus() async {
    try {
      final nafazStatus =
      NafazStatus(id: widget.nationalId, random: _code, transId: transId);
      await ref
          .read(nafazStatusViewModelProvider.notifier)
          .nafathStatus(nafazStatus);
    } catch (e) {
      // if(mounted){
      //   setState(() {
      //     enableButton = true;
      //   });
      // }
    }
  }

  void _startTimer() {
    int secondsRemaining = 100;
    // _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (secondsRemaining > 0) {
        if (mounted) {
          setState(() => secondsRemaining -= 10);
        }
        callNafazStatus();
      } else {
        _timer?.cancel();
        if (mounted) {
          _resetButton(true);
        }
      }
    });
  }

  @override
  void dispose() {
    // ref.invalidate(nafazCodeViewModelProvider);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsLight.lightGray, // dark blue color
      appBar: AppBar(
        backgroundColor: AppColorsLight.backgroundColorNafazCode,
        iconTheme: IconThemeData(color: AppColorsLight.whiteColor),
        elevation: 0,
      ),
      body: Container(
        color: AppColorsLight.lightGray,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height *
                  0.2, //20% of the screen height.
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
                  decoration: BoxDecoration(
                      color: AppColorsLight.whiteColor,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15.0),
                          topLeft: Radius.circular(15.0))),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Image.asset('assets/images/nafaz_green.png',
                              width: 91, height: 91),
                          const SizedBox(height: 25),
                          CustomText(
                            LocaleKeys.confirmationCode.tr(),
                            color: AppColorsLight.textColorNafazCode,
                            fontSize: FontsSize.font_18,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(height: 8),
                          CustomText(
                            LocaleKeys.nafazTextCode.tr(),
                            color: AppColorsLight.grayColor,
                            fontSize: FontsSize.font_15,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          CustomText(_code ?? '--',
                              fontSize: FontsSize.font_70,
                              color: AppColorsLight.primaryColor,
                              fontWeight: FontWeight.bold),
                          const SizedBox(height: 20),
                          Consumer(builder: (context, ref, child) {
                            final nafazStatusState =
                            ref.watch(nafazStatusViewModelProvider);
                            if (nafazStatusState.isLoading) {
                              return CircularProgressIndicator();
                            } else if (nafazStatusState.isSuccess) {
                              return nafazStatusState.whenOrNull(
                                success: (data) {
                                  return switch (data.status) {
                                    'WAITING' => _buildWaitingWithTimer(),
                                    'COMPLETED' => _buildCompletedWithTimer(data),
                                    'EXPIRED' => _buildExpiredWithTimer(),
                                    _ => const Text('Unknown Status'),
                                  };
                                },
                              ) ??
                                  const SizedBox.shrink();
                            } else if (nafazStatusState.isError) {
                              var error = (nafazStatusState as ConfigError);
                              _resetNafazStatus();
                              showErrorMessage(context, error.code, error.message);
                              return CustomText(LocaleKeys.error.tr());
                            } else if (nafazStatusState.isErrorApi) {
                              var error = (nafazStatusState as ConfigErrorApi);
                              _resetNafazStatus();
                              showErrorMessageApi(context, error.code, error.data);
                              return CustomText(LocaleKeys.apiError.tr());
                            }
                            return CustomStatusButton(
                                text: LocaleKeys.orderWaiting.tr());
                          }),
                          const SizedBox(height: 20),
                          Consumer(
                            builder: (context, ref, child) {
                              final nafazCodeState =
                              ref.watch(nafazCodeViewModelProvider);
                              final enableButton = ref.watch(enableButtonProvider);
                              nafazCodeState.whenOrNull(success: (data) {
                                _startTimer();
                                _code = data.random;
                                transId = data.transId;
                                _resetNafazCodeStatus();
                              }, error: (message, code) {
                                showErrorMessage(context, code, message);
                                _resetNafazCodeStatus();
                                _resetButton(true);
                              }, errorApi: (code, data) {
                                showErrorMessageApi(context, code, data);
                                _resetNafazCodeStatus();
                                _resetButton(true);
                              });
                              return CustomTextButton(
                                directWriting: true,
                                color: AppColorsLight.redColor,
                                onPressed: enableButton
                                    ? () {
                                  _resetButton(false);
                                  ref
                                      .read(nafazCodeViewModelProvider.notifier)
                                      .nafath(widget.nationalId);
                                }
                                    : null,
                                text: LocaleKeys.resendCode.tr(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ))
          ],
        ),
      )
    );
  }

  Widget _buildWaitingWithTimer() {
    return CustomStatusButton(text: LocaleKeys.orderWaiting.tr());
  }

  void _reset() {
    _resetNafazStatus();
    _timer?.cancel();
  }

  Widget _buildExpiredWithTimer() {
    // Schedule timer start after build completes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _timer?.cancel();
        //_reset();
        _resetButton(true);
      }
    });
    return CustomStatusButton(text: LocaleKeys.orderExpired.tr());
  }

  Widget _buildCompletedWithTimer(NafazStatusResponse data) {
    // Schedule timer start after build completes
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        _reset();
        if (data.token != null) {
          await saveToken(data.token!);
        } else {
          if (kDebugMode) {
            print('Token is null can not save.');
          }
        }
        var mobileVerifiedAt = data.client?.mobileVerifiedAt ?? '';
        // if (mobileVerifiedAt.isNotEmpty) {
        //   //     هعمل كوفري
        //   // هل متاح ولا لا
        //   // وهل مطلوبة ولا لا
        //   navigatorControllerPushAndRemoveUntil(context, NavPage(), false);
        // } else {

        navigatorControllerPush(context, NafazSendVerifyCodePage());
        //  }
      }
    });
    return CustomStatusButton(text: LocaleKeys.orderCompleted.tr());
  }

  void _resetNafazStatus() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(nafazStatusViewModelProvider.notifier).resetSate();
    });
  }

  void _resetNafazCodeStatus() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(nafazCodeViewModelProvider.notifier).restState();
    });
  }

  void _resetButton(bool status) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(enableButtonProvider.notifier).state = status;
    });
  }
}
