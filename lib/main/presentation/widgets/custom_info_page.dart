import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hollat/core/global/theme/app_color/app_color_light.dart';

class CustomInfoPage extends StatelessWidget {
  final String text;
  final String description;
  const CustomInfoPage({required this.text, required this.description, super.key});

  @override
  Widget build(BuildContext context) {
    return  // Margin around the card
       Card(
        elevation: 5,
        shadowColor: AppColorsLight.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(color: AppColorsLight.primaryColor, width: 0.5),
        ),
        color: AppColorsLight.whiteColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: AppColorsLight.primaryColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: SvgPicture.asset(
                  'assets/images/info.svg',
                  fit: BoxFit.contain,
                ),
              ),
              // Text Header
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      color: AppColorsLight.blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    description,
                    style: TextStyle(
                      color: AppColorsLight.grayColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
  }
}
