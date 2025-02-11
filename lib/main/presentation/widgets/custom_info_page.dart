import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hollat/core/global/theme/app_color/app_color_light.dart';
import 'package:hollat/login/presentation/widgets/custom_text.dart';

class CustomInfoPage extends StatelessWidget {
  final String text;
  final String description;
  final String imagePath;
  const CustomInfoPage({required this.text, required this.description,required this.imagePath, super.key});

  @override
  Widget build(BuildContext context) {
    return  // Margin around the card
       Card(
        elevation: 1,
        //shadowColor: AppColorsLight.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          //side: BorderSide(color: AppColorsLight.primaryColor, width: 0.5),
        ),
        color: AppColorsLight.whiteColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                margin: EdgeInsets.only(right: 10),
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: AppColorsLight.colorPrimaryDark,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: SvgPicture.asset(
                  imagePath,
                  fit: BoxFit.contain,
                ),
              ),
              // Text Header
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text,
                    color:AppColorsLight.blackColor,
                  fontWeight: FontWeight.bold ,
                  ),
                  SizedBox(height: 5),
                  CustomText(
                    description,
                    color: AppColorsLight.grayColor,
                  ),
                ],
              )
            ],
          ),
        ),
      );
  }
}
