import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hollat/core/init/gen/translations.g.dart';
import 'package:hollat/login/navigator.dart';
import 'package:hollat/main/presentation/views/information/contact_us_page.dart';
import 'package:hollat/main/presentation/views/information/information_bank_page.dart';
import 'package:hollat/main/presentation/views/information/who_are_we_page.dart';
import 'package:hollat/main/presentation/widgets/custom_info_page.dart';

class SamaPage extends StatelessWidget {
  const SamaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              navigatorControllerPush(context, WhoAreWePage());
            },
            child: CustomInfoPage(
              text: LocaleKeys.whoAreWe.tr(),
              description: '',
            ),
          ),
          InkWell(
            onTap: () {
              navigatorControllerPush(context, InformationBankPage());
            },
            child: CustomInfoPage(
              text: LocaleKeys.informationBank.tr(),
              description: '',
            ),
          ),
          InkWell(
            onTap: () {
              navigatorControllerPush(context, ContactUsPage());
            },
            child: CustomInfoPage(
              text: LocaleKeys.contactUs.tr(),
              description: '',
            ),
          )
        ],
      ),
    ));
  }
}
