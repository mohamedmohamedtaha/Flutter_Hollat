import 'package:flutter/material.dart';
import 'package:hollat/core/global/theme/app_color/app_color_light.dart';
import 'package:hollat/core/global/theme/font/fonts_size.dart';
import 'package:hollat/core/init/gen/translations.g.dart';
import 'package:hollat/login/presentation/widgets/custom_text.dart';

class CustomNumberTicket extends StatelessWidget {
  final String number;
  final String state;
  const CustomNumberTicket({required this.number,
    required this.state, super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
          color: AppColorsLight.lightGreen,
          borderRadius: BorderRadius.all(Radius.circular(10.0))
      ),
      child: Padding(padding: EdgeInsets.all(15.0),
        child:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomText(number,
            color: AppColorsLight.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: FontsSize.font_16,),
          CustomText(state),

        ],
      ),
    ),);
  }
}
