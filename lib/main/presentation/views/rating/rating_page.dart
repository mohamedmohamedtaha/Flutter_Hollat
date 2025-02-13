import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hollat/core/global/theme/app_color/app_color_light.dart';
import 'package:hollat/core/global/theme/font/fonts_size.dart';
import 'package:hollat/core/init/gen/translations.g.dart';
import 'package:hollat/login/presentation/widgets/custom_elevated_button.dart';
import 'package:hollat/login/presentation/widgets/custom_text.dart';

void showRatingBottomSheet(BuildContext context) {
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
                    'assets/images/rating.png',
                    fit: BoxFit.fill,
                  )),
              CustomText(
                LocaleKeys.youSatisfied.tr(),
                fontSize: FontsSize.font_16,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 20.0,
              ),
              RatingBar.builder(
                initialRating: 5,
                  minRating: 1,
                  allowHalfRating: true,
                  direction: Axis.horizontal,
                  itemCount: 5, // Default value is 5
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                 // itemBuilder: (context, index) => Icon(Icons.star,
                      itemBuilder: (context, index) {
                  switch(index){
                    case 0: return Icon(Icons.sentiment_very_dissatisfied,
                    color: AppColorsLight.redColor,);
                    case 1: return Icon(Icons.sentiment_dissatisfied,
                      color: AppColorsLight.redColor,);
                    case 2: return Icon(Icons.sentiment_neutral,
                      color: AppColorsLight.yellowColor,);
                    case 3: return Icon(Icons.sentiment_satisfied,
                      color: AppColorsLight.primaryColor,);
                    case 4: return Icon(Icons.sentiment_very_satisfied,
                      color: AppColorsLight.colorPrimaryDark,);
                    default: return CustomText(LocaleKeys.apiError.tr());
                  }},
                  onRatingUpdate: (rating) {

                  }),
              SizedBox(
                height: 40.0,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 40.0, right: 40.0),
                  child: CustomElevatedButton(
                      text: LocaleKeys.send.tr(), onPressed: () {})),
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
