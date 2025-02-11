import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hollat/core/global/theme/app_color/app_color_light.dart';
import 'package:hollat/core/global/theme/font/fonts_size.dart';
import 'package:hollat/core/init/gen/translations.g.dart';
import 'package:hollat/login/Navigator.dart';
import 'package:hollat/login/data/viewmodel/config_viewmodel.dart';
import 'package:hollat/login/presentation/widgets/custom_text.dart';
import 'package:hollat/login/presentation/widgets/custom_text_field.dart';
import 'package:hollat/main/presentation/views/information/information_bank_page.dart';
import 'package:hollat/main/presentation/views/information/who_are_we_page.dart';
import 'package:hollat/main/presentation/widgets/custom_info_page.dart';
import 'package:hollat/main/presentation/widgets/custom_main_card_ticket.dart';
import 'package:hollat/main/presentation/widgets/custom_number_ticket.dart';
import 'package:hollat/main/riverpod/ticket_providers.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _MyComplaintPageState();
}

class _MyComplaintPageState extends ConsumerState<HomePage> {
  TextEditingController searchTextEditingController = TextEditingController();
  TextEditingController dateTextEditingController = TextEditingController();
  DateTime? _selectedBirthDate;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(oldTicketProvide.notifier).oldTickets(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;
    final oldTicketState = ref.watch(oldTicketProvide);
    return Scaffold(
      backgroundColor: AppColorsLight.lightGray,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: heightScreen * 0.17,
              decoration: BoxDecoration(
                  color: AppColorsLight.colorPrimaryDark,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15.0),
                      bottomLeft: Radius.circular(15.0))),
              child: Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    CustomText(
                      "We in the hollat ",
                      color: AppColorsLight.whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: FontsSize.font_16,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    CustomTextField(
                      controller: searchTextEditingController,
                      labelText: LocaleKeys.search.tr(),
                      hintText: LocaleKeys.search.tr(),
                      prefixIcon: Icon(Icons.search),
                      fillColor: AppColorsLight.whiteColor,
                      filled: true,
                      keyboardType: TextInputType.number,
                      maxLength: null,
                    ),
                  ],
                ),
              ),
            ),
            oldTicketState.isLoading || oldTicketState.isInitial
                ? Center(child: CircularProgressIndicator())
                : (oldTicketState as ConfigSuccess).data.data.length <= 0
                ? Center(child: CustomText(LocaleKeys.noDataFound.tr()))
                : SizedBox(
              height: heightScreen * 0.2,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: (oldTicketState as ConfigSuccess)
                    .data
                    .data
                    .length,
                itemBuilder: (context, index) {
                  if (index ==
                      (oldTicketState as ConfigSuccess)
                          .data
                          .data
                          .length) {
                    return Center(
                        child:
                        CircularProgressIndicator()); //Loader at bottom
                  }
                  final tickets = (oldTicketState as ConfigSuccess)
                      .data
                      .data[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: CustomMainCardTicket(
                        ticketId: 1544465,
                        date: "20/10/2024",
                        product: "Insurance",
                        sectorName: "Banking",
                        ticketTime: "3:00pm"),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: AppColorsLight.lightGreen,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            bottomLeft: Radius.circular(15.0))),
                    height: 150.0,
                    width: 100.0,
                    child: Image.asset(
                      'assets/images/man.png',
                    ),
                  ),
                   Expanded(child:Container(
                         height: 150,
                    decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(15.0),
                    bottomRight:  Radius.circular(15.0),
                    ),
                      color: AppColorsLight.whiteColor,),
                    child: Padding(padding: EdgeInsets.only(left: 15.0,right: 15.0),
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          LocaleKeys.textTotalCompliant.tr(),
                          color: AppColorsLight.grayColor,
                        ),
                        SizedBox(height: 15.0,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomNumberTicket(number: '02',state: LocaleKeys.new_),
                            CustomNumberTicket(number: '03',state: LocaleKeys.underProcess),
                            CustomNumberTicket(number: '02',state: LocaleKeys.close),

                          ],
                        ),
                      ],
                    ),
                  )),)
                ],
              ),
            ),
            InkWell(
              onTap: () {
                navigatorControllerPush(context, WhoAreWePage());
              },
              child: CustomInfoPage(
                text: LocaleKeys.whoAreWe.tr(),
                description: 'How are you',
                imagePath: 'assets/images/info.svg',
              ),
            ),
            InkWell(
              onTap: () {
                navigatorControllerPush(context, InformationBankPage());
              },
              child: CustomInfoPage(
                imagePath: 'assets/images/phone.svg',
                text: LocaleKeys.informationBank.tr(),
                description: 'How are you',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
