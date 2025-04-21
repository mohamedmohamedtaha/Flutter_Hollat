import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hollat/core/global/theme/theme_data/app_themes.dart';
import 'package:hollat/core/utils/certificate.dart';
import 'package:hollat/easy_localization/app_lang.dart';
import 'package:hollat/login/data/sharedpreferences/local_storage_service.dart';
import 'package:hollat/login/views/login/splash_page.dart';
import 'package:hollat/main/riverpod/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await LocalStorageService.init();
  Certificate.initCertificate();
  runApp(EasyLocalization(
    supportedLocales: AppLang.supportedLocales,
    fallbackLocale: AppLang.ar,
    path: 'assets/translations',
    child: const ProviderScope(child: HollatApp()),
  ));
}

class HollatApp extends ConsumerWidget {
  const HollatApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(localStorageViewModelProvider);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppThemes.lightThemeData,
        darkTheme: AppThemes.darkThemeData,
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
        locale: context.locale);
  }
}
