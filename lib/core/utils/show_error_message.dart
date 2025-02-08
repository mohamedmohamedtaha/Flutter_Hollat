
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hollat/core/global/theme/app_color/app_color_light.dart';
import 'package:hollat/core/init/gen/translations.g.dart';
import 'package:hollat/login/Navigator.dart';
import 'package:hollat/login/data/models/error_response/error_response_model.dart';
import 'package:hollat/login/data/sharedpreferences/save_token.dart';
import 'package:hollat/login/views/login/splash_page.dart';

void showMessage(BuildContext context, String message) {
  showSnackBar(context, message.toString());
}
void showErrorMessage(BuildContext context, int code, String message) async {
  if (code == 401) {
    await deleteToken();
    showSnackBar(context, LocaleKeys.tokenExpired.tr());
    navigatorControllerPushAndRemoveUntil(context, SplashPage(), false);
  } else {
    showSnackBar(context, message.toString());
  }
}

void showErrorMessageApi(BuildContext context, int code, dynamic data) async {
  if (code == 401) {
    await deleteToken();
    showSnackBar(context, LocaleKeys.tokenExpired.tr());
    navigatorControllerPushAndRemoveUntil(context, SplashPage(), false);
  } else {
    final ErrorResponseModel errorResponseModel = ErrorResponseModel.fromJson(data.data);
      if(errorResponseModel.errors != null && errorResponseModel.errors!.isNotEmpty){
        final errorMessages = errorResponseModel.errors!.values.expand((list)=>list).toList();
       // final errorMessages = errorResponseModel.errors!.toList();
        showSnackBar(context,errorMessages.join('\n '));
      }else{
        showSnackBar(context,errorResponseModel.message ?? 'Unknown error');
      }
  }
}
void showSnackBar(BuildContext context,String errorMessage){
  WidgetsBinding.instance.addPostFrameCallback((_){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColorsLight.primaryColor,
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        content: Text(errorMessage),
      ),
    );
  });
}


