import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hollat/core/global/theme/app_color/app_color_light.dart';
import 'package:hollat/core/init/gen/translations.g.dart';
import 'package:hollat/login/presentation/widgets/custom_text.dart';

class InformationBankPage extends StatefulWidget {
  const InformationBankPage({super.key});

  @override
  State<InformationBankPage> createState() => _InformationBankPageState();
}

class _InformationBankPageState extends State<InformationBankPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColorsLight.moreLightGray,
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColorsLight.whiteColor),
          automaticallyImplyLeading: true,
          title: CustomText(
            LocaleKeys.informationBank.tr(),
            color: AppColorsLight.whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: Center(
          child: CustomText(LocaleKeys.informationBank.tr()),
        ));
  }
}
