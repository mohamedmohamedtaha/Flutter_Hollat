import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hollat/core/init/gen/translations.g.dart';
import 'package:hollat/login/presentation/widgets/custom_text_button.dart';
void showConfirmationDialog(BuildContext context,Future<void>Function() logout) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(LocaleKeys.exit.tr()),
        content: Text(LocaleKeys.warningExitApp.tr()),
        actions: [
          CustomTextButton(
              text: LocaleKeys.yes.tr(),
              onPressed: () async{
                Navigator.of(context).pop();
                    try{
                      await logout();
                  }catch(e){
                    print(e);
                  }
              }
          ),
          CustomTextButton(
              text: LocaleKeys.no.tr(),
              onPressed: () {
                Navigator.of(context).pop();
              }
          ),
        ],
      );
    },
  );
}