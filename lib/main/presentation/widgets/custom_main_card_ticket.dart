import 'package:flutter/material.dart';
import 'package:hollat/core/global/theme/app_color/app_color_light.dart';
import 'package:hollat/core/global/theme/font/fonts_size.dart';
import 'package:hollat/login/presentation/widgets/custom_text.dart';

class CustomMainCardTicket extends StatelessWidget {
  final int? ticketId;
  final String? ticketTime;
  final String? sectorName;
  final String? date;
  final String? product;

  const CustomMainCardTicket(
      {super.key,
        required this.ticketId,
        required this.sectorName,
        required this.ticketTime,
        required this.date,
        required this.product});

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    return Card(
      color: AppColorsLight.colorPrimaryDark,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: SizedBox(
        width: widthScreen * 0.8,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child:
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/saving_white.png',
                    width: 60,
                    height: 60,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomText(
                        ticketId.toString(),
                        color: AppColorsLight.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: FontsSize.font_18,
                      ),
                      CustomText(
                        date.toString(),
                        color: AppColorsLight.whiteColor,
                        fontSize: FontsSize.font_12,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColorsLight.yellowColor,
                            radius: 5.0,
                          ),
                          const SizedBox(width: 8),
                          CustomText(
                            sectorName.toString(),
                            color: AppColorsLight.whiteColor,
                            fontSize: FontsSize.font_14,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(width: 8),
                          CustomText(
                            sectorName.toString(),
                            color: AppColorsLight.whiteColor,
                            fontSize: FontsSize.font_14,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColorsLight.yellowColor,
                            radius: 5.0,
                          ),
                          const SizedBox(width: 8),
                          CustomText(
                            product.toString(),
                            color: AppColorsLight.whiteColor,
                            fontSize: FontsSize.font_14,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(width: 8),
                          CustomText(
                            product.toString(),
                            color: AppColorsLight.whiteColor,
                            fontSize: FontsSize.font_14,
                          ),
                        ],
                      ),

                    ],
                  ),
                  Row(
                    children: [

                      const SizedBox(width: 8),
                      CustomText(
                        ticketTime.toString(),
                        color: AppColorsLight.whiteColor,
                        fontSize: FontsSize.font_14,
                      ),
                    ],
                  ),
                ],

          ),
        ),
      ),
    );
  }
}
