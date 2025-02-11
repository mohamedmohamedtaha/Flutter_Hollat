import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hollat/core/global/theme/app_color/app_color_light.dart';
import 'package:hollat/core/global/theme/font/fonts_size.dart';
import 'package:hollat/core/global/validation/validation.dart';
import 'package:hollat/core/init/gen/translations.g.dart';
import 'package:hollat/login/data/viewmodel/config_viewmodel.dart';
import 'package:hollat/login/presentation/widgets/custom_data_picker.dart';
import 'package:hollat/login/presentation/widgets/custom_text.dart';
import 'package:hollat/login/presentation/widgets/custom_text_field.dart';
import 'package:hollat/main/presentation/widgets/custom_radio_group.dart';
import 'package:hollat/main/riverpod/providers.dart';
import 'package:hollat/main/riverpod/ticket_providers.dart';

class MyComplaintPage extends ConsumerStatefulWidget {
  const MyComplaintPage({super.key});

  @override
  ConsumerState<MyComplaintPage> createState() => _MyComplaintPageState();
}

class _MyComplaintPageState extends ConsumerState<MyComplaintPage> {
  TextEditingController searchTextEditingController = TextEditingController();
  TextEditingController dateTextEditingController = TextEditingController();
  DateTime? _selectedBirthDate;
  final ScrollController _scrollController = ScrollController();
  final int _perPage = 1;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(oldTicketProvide.notifier).oldTickets(_perPage);
      ref.read(serviceConfigDatabaseViewModelProvider).getAllConfig();
      print(
          'config ${ref.watch(serviceConfigDatabaseViewModelProvider).config}');
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_isLoadingMore) return; //Prevent multiple requests

        _isLoadingMore = true;
        ref.read(oldTicketProvide.notifier).oldTickets(_perPage);
        _isLoadingMore = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final oldTicketState = ref.watch(oldTicketProvide);
    return Scaffold(
      backgroundColor: AppColorsLight.lightGray,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColorsLight.colorPrimaryDark,
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25),
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
                  CustomRadioGroup(),
                ],
              ),
            ),
          ),
          Expanded(
            child: oldTicketState.isLoading || oldTicketState.isInitial
                ? Center(child: CircularProgressIndicator())
                : (oldTicketState as ConfigSuccess).data.data.length <= 0
                ? Center(child: CustomText(LocaleKeys.noDataFound.tr()))
                : ListView.builder(
              controller: _scrollController,
              itemCount:
              (oldTicketState as ConfigSuccess).data.data.length +
                  (_isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index ==
                    (oldTicketState as ConfigSuccess)
                        .data
                        .data
                        .length &&
                    _isLoadingMore) {
                  return Center(
                      child:
                      CircularProgressIndicator()); //Loader at bottom
                }
                final tickets = (oldTicketState as ConfigSuccess)
                    .data
                    .data[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 20),
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
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      '3:00pm',
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomText(
                                      '3:00pm',
                                      fontSize: FontsSize.font_12,
                                      color: AppColorsLight
                                          .colorPrimaryDark,
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
                                          color: AppColorsLight
                                              .colorPrimaryDark,
                                          borderRadius:
                                          BorderRadius.circular(
                                              3.0)),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 4),
                                      child: CustomText(
                                        'جديد',
                                        color:
                                        AppColorsLight.whiteColor,
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
