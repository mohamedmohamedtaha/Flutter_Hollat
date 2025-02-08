
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

class AppLang {
  static const ar = Locale("ar", "SA");
  static const en = Locale("en", "US");
  static const List<Locale> supportedLocales = [ar, en];
  static String currentLanguage(BuildContext context){
    Locale currentLocale = context.locale;
   return currentLocale.languageCode;
  }
  static void changeLanguage(BuildContext context){
    var currentLan = currentLanguage(context);
    if(currentLan =="en") {
      context.setLocale(AppLang.supportedLocales[0]);
    }
    else{
    context.setLocale(AppLang.supportedLocales[1]);
    }
  }
}
