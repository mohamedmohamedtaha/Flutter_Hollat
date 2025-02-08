import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hollat/core/global/theme/app_color/app_color_light.dart';
import 'package:hollat/core/init/gen/translations.g.dart';

class PhoneNumberField extends StatelessWidget {
  final TextEditingController controller;
  final CountryCode? initialCountry;
  final ValueChanged<CountryCode>? onCountryChanged;
  final String? Function(String?)? validator;
  final String? labelText;
  final String? hintText;
  final InputDecoration? decoration;

  const PhoneNumberField(
      {super.key,
        required this.controller,
        this.initialCountry,
        this.onCountryChanged,
        this.validator,
        this.labelText,
        this.hintText,
        this.decoration});

  @override
  Widget build(BuildContext context) {
    CountryCode selectedCountry =
        initialCountry ?? CountryCode.fromCountryCode('SA');
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      validator: validator,
      decoration: (decoration ?? const InputDecoration()).copyWith(
          prefixIcon: CountryCodePicker(
            //  barrierColor: AppColorsLight.grayColor,
            backgroundColor: AppColorsLight.transparentColor,
            //dialogBackgroundColor: AppColorsLight.transparentColor ,
            // flagDecoration: BoxDecoration(
            //   color :AppColorsLight.whiteColor,
            //   borderRadius: BorderRadius.circular(4)
            // ),
            onChanged: (country) {
              selectedCountry = country;
              onCountryChanged?.call(country);
            },
            // --- Icon/Text Styling ---
            closeIcon: Icon(
              Icons.close,
              color: AppColorsLight.redColor, // Custom close icon
            ),
            searchStyle: TextStyle(
              color: AppColorsLight.grayColor, // Search text
            ),
            initialSelection: selectedCountry.code,
            favorite: const ['IN', 'EG', 'SA'],
            showCountryOnly: false,
            showOnlyCountryWhenClosed: false,
            alignLeft: false,
            // textStyle: TextStyle(
            //   color: Colors.white, // Text color
            //   backgroundColor: AppColorsLight.transparentColor,
            // ),
            // searchStyle: TextStyle(
            //   color: Colors.white, // Search text color
            //   backgroundColor: AppColorsLight.transparentColor,
            // ),
          ),
          labelText: labelText ?? LocaleKeys.phoneNumber.tr(),
          hintText: hintText ?? LocaleKeys.phoneHint.tr(),
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );
  }
}
