import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:hollat/core/global/theme/theme_data/theme_data_light.dart';
import 'package:hollat/easy_localization/app_lang.dart';
import 'package:hollat/login/data/database/service_config_database.dart';
import 'package:hollat/login/data/sharedpreferences/local_storage_service.dart';
import 'package:hollat/login/network/MyHttpOverrids.dart';
import 'package:hollat/login/views/login/splash_page.dart';
import 'package:hollat/login/views/login/verify_email/verify_otp_email_page.dart';
import 'package:hollat/main/riverpod/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // For Localization
  await EasyLocalization.ensureInitialized();
  await LocalStorageService.init();
  await Hive.initFlutter();
  Hive.registerAdapter(ServiceConfigDatabaseAdapter());
  final sslCert =
  await rootBundle.load('assets/certificates/back-dev.hollat.crt');
  final securityContext = SecurityContext();
  securityContext.setTrustedCertificatesBytes(sslCert.buffer.asUint8List());
  HttpOverrides.global = MyHttpOverrides(securityContext);
  runApp(EasyLocalization(
   supportedLocales: AppLang.supportedLocales,
    fallbackLocale: AppLang.ar,
    path: 'assets/translations',
    child: const ProviderScope(child: HollatApp()),
  ));
}
//Stateless
//material app
//scaffold

// Stateful can refresh
//Stateless can not refresh
// setState to refresh the screens . I want to refresh right now

class HollatApp extends ConsumerWidget {
  const HollatApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(localStorageViewModelProvider);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: getThemeDataLight(),
        darkTheme: ThemeData.dark(),
        themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
        //
        // ThemeData(
        //     colorScheme: ColorScheme.fromSeed(
        //         seedColor: Colors.teal,
        //         brightness: mode ? Brightness.light : Brightness.dark))
        //
        home: const SplashPage(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale
    );
  }
}
