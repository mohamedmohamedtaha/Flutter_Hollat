import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hollat/core/global/theme/app_color/app_color_light.dart';
import 'package:hollat/core/global/theme/font/fonts_size.dart';
import 'package:hollat/core/init/gen/translations.g.dart';
import 'package:hollat/login/presentation/widgets/custom_elevated_button.dart';
import 'package:hollat/login/presentation/widgets/custom_text.dart';
import 'package:hollat/login/presentation/widgets/custom_text_field.dart';

void showSendComplaintBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      TextEditingController detailsTextEditingController =
      TextEditingController();
      return Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: AppColorsLight.whiteColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: 40.0,
                  height: 5.0,
                  child: Image.asset(
                    'assets/images/rectangle.png',
                    fit: BoxFit.fill,
                  )),
              SizedBox(
                  width: 150.0,
                  height: 150.0,
                  child: Image.asset(
                    'assets/images/complaint.png',
                    fit: BoxFit.fill,
                  )),
              CustomText(
                LocaleKeys.complaint.tr(),
                fontSize: FontsSize.font_16,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 10.0,
              ),
              CustomText(
                LocaleKeys.complaintUp.tr(),
                fontSize: FontsSize.font_16,
                color: AppColorsLight.grayColor,
                 textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20.0,
              ),
              CustomTextField(
                maxLength: 500,
                maxLines: 6,
                controller: detailsTextEditingController,
                labelText: LocaleKeys.details.tr(),
                hintText: LocaleKeys.details.tr(),
                keyboardType: TextInputType.multiline,
              ),
              SizedBox(
                height: 40.0,
              ),
              Container(
                width: double.infinity,
                decoration:BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: AppColorsLight.lightGreen,
                ) ,
                child: Column(
                  children: [SizedBox(
                  height: 10.0,
                ),
                    Image.asset(
                      'assets/images/saving_green.png',
                      height: 40.0,
                      width: 40.0,
                    ),
                    CustomText(
                      LocaleKeys.addAttachment.tr(),
                      fontSize: FontsSize.font_16,
                      fontWeight: FontWeight.bold,
                    ),
                    Padding(padding:EdgeInsets.only(left: 40.0,right: 40.0),
                        child:  CustomText(
                      LocaleKeys.uploadAttachment.tr(),
                      fontSize: FontsSize.font_16,
                      color: AppColorsLight.grayColor,
                          textAlign: TextAlign.center,
                    )),
                    Padding(padding:EdgeInsets.only(left: 40.0,right: 40.0),
                    child: CustomElevatedButton(
                        text: LocaleKeys.selectFiles.tr(), onPressed: () {}),)
                    ,SizedBox(
                      height: 10.0,
                    ) ],
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Padding(padding:EdgeInsets.only(left: 40.0,right: 40.0),
                  child:  CustomElevatedButton(
                  text: LocaleKeys.send.tr(),
                  color: AppColorsLight.redColor,
                  onPressed: () {})),
              SizedBox(
                height: 80.0,
              ),
            ],
          ),
        ),
      );
    },
  );
}
