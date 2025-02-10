import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hollat/core/global/theme/app_color/app_color_light.dart';
import 'package:hollat/core/global/theme/font/fonts_size.dart';
import 'package:hollat/core/global/validation/validation.dart';
import 'package:hollat/core/init/gen/translations.g.dart';
import 'package:hollat/login/presentation/widgets/custom_data_picker.dart';
import 'package:hollat/login/presentation/widgets/custom_text.dart';
import 'package:hollat/login/presentation/widgets/custom_text_field.dart';
import 'package:hollat/main/presentation/widgets/custom_radio_group.dart';
import 'package:hollat/main/riverpod/providers.dart';

class MyComplaintPage extends ConsumerStatefulWidget {
  const MyComplaintPage({super.key});

  @override
  ConsumerState<MyComplaintPage> createState() => _MyComplaintPageState();
}

class _MyComplaintPageState extends ConsumerState<MyComplaintPage> {
  TextEditingController searchTextEditingController = TextEditingController();
  TextEditingController dateTextEditingController = TextEditingController();
  DateTime? _selectedBirthDate;
@override
  void initState() {

    super.initState();
    Future.microtask(() {
      ref.read(serviceConfigDatabaseViewModelProvider).getAllConfig();
      print('config ${ref.watch(serviceConfigDatabaseViewModelProvider).config}');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColorsLight.colorPrimaryDark,
            ),
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                children: [
                  CustomTextField(
                    controller: searchTextEditingController,
                    labelText: LocaleKeys.search.tr(),
                    hintText: LocaleKeys.search.tr(),
                    prefixIcon: Icon(Icons.search),
                    fillColor: AppColorsLight.whiteColor,
                    filled: true,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                  ),
                  SizedBox(height: 12),
                  CustomTextField(
                    controller: dateTextEditingController,
                    labelText: LocaleKeys.date.tr(),
                    hintText: _selectedBirthDate != null
                        ? '${LocaleKeys.date.tr()}: ${Validation.formatDateTimeToString(_selectedBirthDate!)}'
                        : LocaleKeys.date.tr(),
                    prefixIcon: Icon(Icons.calendar_month),
                    fillColor: AppColorsLight.whiteColor,
                    filled: true,
                    onTap: () async {
                      final date = await CustomDatePicker.show(
                          context: context,
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now());
                      if (date != null) {
                        setState(() => _selectedBirthDate = date);
                      }
                    },
                    readOnly: true,
                  ),
                  SizedBox(height: 12),
                  CustomRadioGroup(),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Material(
                    elevation: 5,
                    color: AppColorsLight.whiteColor,
                    shadowColor: AppColorsLight.primaryColor,
                    // Shadow color
                    borderRadius: BorderRadius.circular(5),
                    // Corner radius
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/saving_green.png',
                            width: 40,
                            height: 40,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      '12345678',
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomText(
                                      '3:00pm',
                                      fontSize: FontsSize.font_12,
                                      color: AppColorsLight.colorPrimaryDark,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4),
                                CustomText(
                                  'المنتج  الحسابات الجارية' * 5,
                                  // Placeholder for actual details
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  color: AppColorsLight.grayColor,
                                ),
                                SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      '25/12/2023',
                                      color: AppColorsLight.grayColor,
                                      fontSize: FontsSize.font_12,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color:
                                          AppColorsLight.colorPrimaryDark,
                                          borderRadius:
                                          BorderRadius.circular(3.0)),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 4),
                                      child: CustomText(
                                        'جديد',
                                        color: AppColorsLight.whiteColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
