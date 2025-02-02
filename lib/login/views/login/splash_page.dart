import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hollat/login/Navigator.dart';
import 'package:hollat/login/data/database/service_config_database.dart';
import 'package:hollat/login/data/sharedpreferences/save_token.dart';
import 'package:hollat/login/data/viewmodel/config_viewmodel.dart';
import 'package:hollat/login/domain/entities/config_response/theme_config.dart';
import 'package:hollat/login/views/login/nafaz_login_page.dart';
import 'package:hollat/login/views/login/normal_login_page.dart';
import 'package:hollat/login/views/nav_page.dart';
import 'package:hollat/main/riverpod/providers.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => SplashPage_State();
}

class SplashPage_State extends ConsumerState<SplashPage> {
  late Timer _timer;
  bool _isImageLoaded = false;
  String nafathEnabled = '';

  @override
  void initState() {
    super.initState();
    Future.microtask(
          () {
        ref.read(configViewModelProvider.notifier).loadConfig();
        // Provider.of<ConfigViewModel>(context, listen: false).loadConfig();
        startNavigationByTimer();
      },
    );
    // initThemeMode();
  }

  void startNavigationByTimer() async {
    final token = await getToken();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_timer) async {
      if (_isImageLoaded) {
        _timer.cancel();
        await Future.delayed(const Duration(seconds: 3));
        if (mounted) {
          if (token != null) {
            navigatorControllerReplacement(context, const NavPage());
          } else {
            navigatorControllerReplacement(
                context,
                nafathEnabled == "1"
                    ? const NafazLoginPage() //NafazLoginPage()
                    : const NormalLoginPage());
          }
        }
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Consumer(builder: (context, ref, child) {
        final hiveServiceAsyncValue = ref.watch(hiveServiceProvider);
        return hiveServiceAsyncValue.when(
            data: (hiveState) {
              final state = ref.watch(configViewModelProvider);
              return switch (state) {
                ConfigInitial() => const SizedBox.shrink(),
                ConfigLoading() =>
                const Center(child: CircularProgressIndicator()),
                ConfigSuccess(:final data) => Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white),
                              child: Image.network(
                                  frameBuilder: (context, child, frame,
                                      wasSynchronouslyLoaded) {
                                    if (frame != null) {
                                      ServiceConfigDatabase serviceConfigDatabase =
                                      ServiceConfigDatabase();
                                      ThemeConfig theme = data.theme;
                                      serviceConfigDatabase.largeLogo =
                                          data.theme.logo.value ?? '';
                                      serviceConfigDatabase.smallLogo =
                                          data.theme.miniLogo.value ?? "";
                                      serviceConfigDatabase.primaryColor =
                                          data.theme.headerColor.value ?? '';
                                      serviceConfigDatabase.smallImage =
                                          data.theme.miniLogo.value ?? '';

                                      //---------------------------- Login Config ----------------------------
                                      serviceConfigDatabase.nafathEnabled =
                                          data.nafathEnabled.value ?? '';
                                      nafathEnabled =
                                          data.nafathEnabled.value ?? '';
                                      serviceConfigDatabase.selfServiceOtpBy =
                                          data.selfServiceOtpBy.value;
                                      serviceConfigDatabase
                                          .verifyMobileAfterLoginWithEmail = data
                                          .verifyMobileAfterLoginWithEmail
                                          ?.value ??
                                          '';
                                      ref
                                          .read(
                                          serviceConfigDatabaseViewModelProvider)
                                          .clearConfig();

                                      ref
                                          .read(
                                          serviceConfigDatabaseViewModelProvider)
                                          .saveConfig(serviceConfigDatabase);
                                      _isImageLoaded = true;

                                    }
                                    return child;
                                  },
                                  data.theme.logo.value ?? '',
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                        'assets/images/hollatksa_logo');
                                  }),
                            )
                          ],
                        ))),
                ConfigError(:final message) => Text('Error: $message'),
                _ => Container(),
              };
            },
            error: (e, stack) =>
                Center(child: Text('Error initializing HiveService: $e')),
            loading: () => const Center(child: CircularProgressIndicator()));
      }),
    );
  }

// void initThemeMode() async{
//   final prefs = await SharedPreferences.getInstance();
//   final bool getMode = prefs.getBool(Constants.modeKey) ?? false;
//   modeNotifier.value = getMode;
// }
}
