import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hollat/core/global/theme/app_color/app_color_light.dart';
import 'package:hollat/core/init/gen/translations.g.dart';
import 'package:hollat/main/presentation/widgets/custom_radio_button.dart';

class CustomRadioGroup extends ConsumerStatefulWidget {
  const CustomRadioGroup({super.key});

  @override
  ConsumerState<CustomRadioGroup> createState() => _CustomRadioGroupState();
}

class _CustomRadioGroupState extends ConsumerState<CustomRadioGroup> {
  String? selectedRadio;// Holds the currently selected radio button
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColorsLight.whiteColor,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Theme.of(context).primaryColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CustomRadioButton(
                value: LocaleKeys.new_.tr(),
                groupValue: selectedRadio,
                onChanged: (val) {
                  setState(() {
                    selectedRadio = val; // Update selected radio
                  });
                },
                text:  LocaleKeys.new_.tr(),
              ),
              CustomRadioButton(
                value: LocaleKeys.underApply.tr(),
                groupValue: selectedRadio,
                onChanged: (val) {
                  setState(() {
                    selectedRadio = val;
                  });
                },
                text: LocaleKeys.underApply.tr(),
              ),
              CustomRadioButton(
                value: LocaleKeys.close.tr(),
                groupValue: selectedRadio,
                onChanged: (val) {
                  setState(() {
                    selectedRadio = val;
                  });
                },
                text: LocaleKeys.close.tr(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
