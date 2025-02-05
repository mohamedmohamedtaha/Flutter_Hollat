import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hollat/core/global/theme/app_color/app_color_light.dart';
import 'package:hollat/core/init/gen/translations.g.dart';
import 'package:hollat/login/presentation/widgets/custom_text.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColorsLight.moreLightGray,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: AppColorsLight.whiteColor
          ),
          automaticallyImplyLeading: true,
          title:CustomText( LocaleKeys.contactUs.tr(),
          color: AppColorsLight.whiteColor,
          fontWeight: FontWeight.bold,),
        ),
        body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Card(
                    color: AppColorsLight.whiteColor,
                    elevation: 5,
                    shadowColor: AppColorsLight.primaryColor,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: AppColorsLight.primaryColor, width: 0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/icon_address.svg',
                                width: 15,
                                height: 15,
                              ),
                              SizedBox(width: 10),
                              Text(
                                LocaleKeys.address.tr(),
                                // Replace with desired text or localization
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Text(
                            'الرياض- المملكة العربية السعودية', // Sample text
                          ),
                          Divider(height: 20, color: Colors.grey),
                          // Horizontal divider

                          // Post Office Image
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/icon_post_office.svg',
                                // Replace with your SVG image
                                width: 15,
                                height: 15,
                              ),
                              SizedBox(width: 10),
                              Text(
                                LocaleKeys.postBox.tr(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Text('2992'),
                          // Example post office number
                          Divider(height: 20, color: Colors.grey),
                          // Horizontal divider

                          // Phone Image
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/icon_phone.svg',
                                // Replace with your SVG image
                                width: 15,
                                height: 15,
                              ),
                              SizedBox(width: 10),
                              Text(
                                LocaleKeys.phoneNumber.tr(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Text('+966535020871'),
                          // Sample phone number
                          Divider(height: 20, color: Colors.grey),
                          // Horizontal divider

                          // Fax Image
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/icon_fax.svg',
                                // Replace with your SVG image
                                width: 25,
                                height: 25,
                              ),
                              SizedBox(width: 10),
                              Text(
                                LocaleKeys.fax.tr(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Text('Sample Fax Number'),
                          // Placeholder for actual fax number
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Card(
                    color: AppColorsLight.whiteColor,
                    shadowColor: AppColorsLight.primaryColor,
                    elevation: 5,
                    // Elevation for shadow effect
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(
                            color: AppColorsLight.primaryColor, width: 0.5)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0), // Inner padding
                      child: Row(
                        children: [
                          SvgPicture.asset(
                              width: 10, 'assets/images/icon_follow_us.svg'),
                          SizedBox(width: 10),
                          SizedBox(width: 10),
                          Expanded(
                              child: Text(
                                LocaleKeys.followUs.tr(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          SizedBox(width: 20),
                          SvgPicture.asset(
                              colorFilter: ColorFilter.mode(
                                  AppColorsLight.redColor, BlendMode.srcIn),
                              width: 20,
                              'assets/images/youtube.svg'),
                          SizedBox(width: 20),
                          SvgPicture.asset(width: 20, 'assets/images/linkedin.svg'),
                          SizedBox(width: 20),
                          SvgPicture.asset(width: 20, 'assets/images/x.svg'),
                          SizedBox(width: 20),
                          SvgPicture.asset(width: 10, 'assets/images/facebook.svg'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
