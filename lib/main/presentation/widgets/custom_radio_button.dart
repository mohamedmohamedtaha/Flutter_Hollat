import 'package:flutter/material.dart';
import 'package:hollat/core/global/theme/app_color/app_color_light.dart';
import 'package:hollat/core/global/theme/font/fonts_size.dart';
import 'package:hollat/login/presentation/widgets/custom_text.dart';

class CustomRadioButton extends StatelessWidget {
  final String value;
  final String text;
  final String? groupValue;
  final ValueChanged<String?> onChanged;

  const CustomRadioButton(
      {required this.value,
        required this.text,
        required this.groupValue,
        required this.onChanged,
        super.key});

  @override
  Widget build(BuildContext context) {
    bool isSelected = value == groupValue; // Check if this button is selected

    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
          decoration: BoxDecoration(
              color: isSelected
                  ? AppColorsLight.primaryColor
                  : AppColorsLight.transparentColor,
              borderRadius: BorderRadius.circular(3.0),
              border: Border.all(
                  color: isSelected
                      ? AppColorsLight.whiteColor
                      : AppColorsLight.primaryColor)),
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 4),
          child: CustomText(
            text,
            fontSize: FontsSize.font_15,
            textAlign: TextAlign.center,
            color: isSelected
                ? AppColorsLight.whiteColor
                : AppColorsLight.grayColor,
          )),
    );
  }
}
