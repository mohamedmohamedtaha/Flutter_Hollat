import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hollat/core/global/theme/app_color/app_color_light.dart';
import 'package:hollat/core/global/theme/font/fonts_size.dart';
import 'package:hollat/core/init/gen/translations.g.dart';
import 'package:hollat/login/Navigator.dart';
import 'package:hollat/login/data/models/nafath/nafaz_status.dart';
import 'package:hollat/login/data/models/nafath/nafaz_status_response.dart';
import 'package:hollat/login/data/sharedpreferences/save_token.dart';
import 'package:hollat/login/data/viewmodel/config_viewmodel.dart';
import 'package:hollat/login/network/repositores/normal_login_repository.dart';
import 'package:hollat/login/presentation/widgets/custom_status_button.dart';
import 'package:hollat/login/presentation/widgets/custom_text.dart';
import 'package:hollat/login/views/nav_page.dart';
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
    _startTimer();
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
    int _secondsRemaining = 100;
    // _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (_secondsRemaining > 0) {
        if (mounted) {
          setState(() => _secondsRemaining -= 10);
        }
        callNafazStatus();
      } else {
        _timer?.cancel();
        if (mounted) {
          ref.read(enableButtonProvider.notifier).state = true;
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    ref.invalidate(nafazCodeViewModelProvider);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxScrolled) => [
          SliverAppBar(
            expandedHeight: 140,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  AppColorsLight.backgroundColorNafazCode,
                  AppColorsLight.backgroundColorNafazCode
                ]),
              ),
            ),
          ),
        ],
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 140,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/nafaz_green.png',
                      width: 91, height: 91),
                  const SizedBox(height: 25),
                  Text(
                    LocaleKeys.confirmationCode.tr(),
                    style: TextStyle(
                      fontSize: FontsSize.font_20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    LocaleKeys.nafazTextCode.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColorsLight.grayColor),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _code ?? '--',
                    style: const TextStyle(
                      fontSize: FontsSize.font_70,
                      color: AppColorsLight.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Consumer(builder: (context, ref, child) {
                    final state = ref.watch(nafazStatusViewModelProvider);
                    return switch (state) {
                      ConfigInitial() =>
                          CustomStatusButton(text: LocaleKeys.orderWaiting.tr())
                    //     Text(
                    //   _secondsRemaining > 0
                    //       ? 'Wait (${_secondsRemaining}s)'
                    //       : 'Resend Code',
                    // )
                    ,
                      ConfigLoading() => CircularProgressIndicator(),
                      ConfigSuccess(:final data) => switch (data.status) {
                        'WAITING' => CustomStatusButton(
                            text: LocaleKeys.orderWaiting.tr()),
                        'COMPLETED' => _buildCompletedWithTimer(data),
                        'EXPIRED' => _buildExpiredWithTimer(),
                        _ => const Text('Unknown Status'),
                      },
                      ConfigError(:final message) => Text('Error: $message'),
                      NormalLoginRepository() => throw UnimplementedError(),
                    };
                  }),
                  const SizedBox(height: 20),
                  Consumer(
                    builder: (context, ref, child) {
                      final state = ref.watch(nafazCodeViewModelProvider);
                      final enableButton = ref.watch(enableButtonProvider);
                      state.whenOrNull(success: (data) {
                        _startTimer();
                        _code = data.random;
                        transId = data.transId;
                        Future(() {
                          ref
                              .read(nafazCodeViewModelProvider.notifier)
                              .restState();
                        });
                      }, error: (isError) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text((state as ConfigError).message),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        });
                        ref.read(enableButtonProvider.notifier).state = true;
                      });
                      return InkWell(
                        onTap: enableButton
                            ? () {
                          ref.read(enableButtonProvider.notifier).state =
                          false;
                          ref
                              .read(nafazCodeViewModelProvider.notifier)
                              .nafath(widget.nationalId);
                        }
                            : null,
                        child: CustomText(
                          LocaleKeys.resendCode.tr(),
                          color: enableButton ? Colors.red : Colors.grey,
                          style: TextStyle(fontSize: FontsSize.font_18),
                        ),
                      );
                      // return CustomElevatedButton(
                      //     enabled: enableButton,
                      //     onPressed: enableButton
                      //         ? () {
                      //       ref
                      //           .read(enableButtonProvider.notifier)
                      //           .state = false;
                      //       ref
                      //           .read(nafazCodeViewModelProvider.notifier)
                      //           .nafath(widget.nationalId);
                      //     }
                      //         : null,
                      //     text: LocaleKeys.resendCode.tr(),
                      //     style: ElevatedButton.styleFrom(
                      //         backgroundColor:
                      //         enableButton ? Colors.red : Colors.grey));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWaitingWithTimer(String status) {
    // Schedule timer start after build completes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!(_timer?.isActive ?? false) && status == 'WAITING') {
        _startTimer();
      }
    });
    return const Text('Order status: The order time has waiting');
  }

  Widget _buildExpiredWithTimer() {
    // Schedule timer start after build completes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _timer?.cancel();
        ref.read(enableButtonProvider.notifier).state = true;
      }
    });
    return CustomStatusButton(text: LocaleKeys.orderExpired.tr());
  }

  Widget _buildCompletedWithTimer(NafazStatusResponse data) {
    // Schedule timer start after build completes
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        _timer?.cancel();
        var mobileVerifiedAt = data.client?.mobileVerifiedAt ?? '';
        if (mobileVerifiedAt.isNotEmpty) {
          navigatorControllerPush(context, NavPage());

        } else {
          if (data.token != null) {
            await saveToken(data.token!);
            navigatorControllerPushAndRemoveUntil(context, NavPage(), false);
          } else {
            if (kDebugMode) {
              print('Token is null can not save.');
            }
          }
        }
      }
    });
    return CustomStatusButton(text: LocaleKeys.orderCompleted.tr());
  }
}
