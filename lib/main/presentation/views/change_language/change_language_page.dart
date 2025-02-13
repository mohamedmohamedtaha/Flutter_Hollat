import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hollat/core/global/theme/app_color/app_color_light.dart';
import 'package:hollat/core/global/theme/font/fonts_size.dart';
import 'package:hollat/core/init/gen/translations.g.dart';
import 'package:hollat/easy_localization/app_lang.dart';
import 'package:hollat/login/Navigator.dart';
import 'package:hollat/login/presentation/widgets/custom_text.dart';

void showLanguageBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: AppColorsLight.whiteColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: SvgPicture.asset(
                'assets/images/flag_arabic.svg',
                width: 25,
                height: 25,
              ),
              title: CustomText(
                LocaleKeys.label_arabic.tr(),
                fontSize: FontsSize.font_16,
                fontWeight: FontWeight.bold,
              ),
              onTap: () {
                AppLang.changeLanguage(context);
                navigatorControllerPup(context);
              },
            ),
            Divider(),
            ListTile(
              leading: SvgPicture.asset(
                'assets/images/flag_english.svg',
                width: 25,
                height: 25,
              ),
              title: CustomText(
                LocaleKeys.label_english.tr(),
                fontSize: FontsSize.font_16,
                fontWeight: FontWeight.bold,
              ),
              onTap: () {
                AppLang.changeLanguage(context);
                navigatorControllerPup(context);
              },
            )
          ],
        ),
      );
    },
  );
}
