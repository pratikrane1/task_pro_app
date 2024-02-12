import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_pro/data/model/validity_model.dart';
import 'package:task_pro/util/dimensions.dart';
import 'package:task_pro/util/images.dart';
import 'package:task_pro/util/theme_colors.dart';
import 'package:task_pro/view/base/app_button.dart';
import 'package:task_pro/view/base/custome_dialog.dart';
import 'package:intl/intl.dart';

class ValidityCard extends StatelessWidget {
  const ValidityCard({super.key,required this.isActive,required this.activeValidity});

  final bool isActive;
  final ActiveValidity? activeValidity;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
          border: Border.all(color: ThemeColors.primaryColor.withOpacity(0.3))
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("task_pro_validity".tr,style: GoogleFonts.montserrat(
                            fontSize: Dimensions.fontSizeLarge,
                            color: ThemeColors.blackColor,
                            fontWeight: FontWeight.w700
                        ),),
                        const SizedBox(width: 2.0,),
                        // Text("(valid for 2 months)",style: GoogleFonts.montserrat(
                        //   fontSize: Dimensions.fontSizeExtraSmall,
                        //   color: ThemeColors.primaryColor,
                        // ),),
                      ],
                    ),
                    const SizedBox(height: 5.0,),

                    Row(
                      children: [
                        Text("Start from: ",style: GoogleFonts.montserrat(
                            fontSize: Dimensions.fontSizeDefault,
                            fontWeight: FontWeight.w600,
                            color: ThemeColors.greyTextColor
                        ),),
                        Text(DateFormat('dd-MM-yyyy').format(DateTime.parse(activeValidity!.startDate!)) ?? "",style: GoogleFonts.montserrat(
                            fontSize: Dimensions.fontSizeDefault,
                            fontWeight: FontWeight.w600,
                            color: ThemeColors.primaryColor
                        ),),
                        Text(" | ",style: GoogleFonts.montserrat(
                          color: ThemeColors.blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: Dimensions.fontSizeLarge,

                        ),),
                        Text(activeValidity!.isActive == "1" ? "Expires on: " : "Expired on: ",style: GoogleFonts.montserrat(
                            fontSize: Dimensions.fontSizeDefault,
                            fontWeight: FontWeight.w600,
                            color: ThemeColors.greyTextColor
                        ),),
                        Text(DateFormat('dd-MM-yyyy').format(DateTime.parse(activeValidity!.endDate!)) ?? "",style: GoogleFonts.montserrat(
                            fontSize: Dimensions.fontSizeDefault,
                            fontWeight: FontWeight.w600,
                            color: ThemeColors.primaryColor
                        ),),
                      ],
                    ),

                    Row(
                      children: [
                        Text("Reason: ",style: GoogleFonts.montserrat(
                            fontSize: Dimensions.fontSizeDefault,
                            fontWeight: FontWeight.w600,
                            color: ThemeColors.greyTextColor
                        ),),
                        Text(activeValidity!.reason ?? "",style: GoogleFonts.montserrat(
                            fontSize: Dimensions.fontSizeDefault,
                            fontWeight: FontWeight.w600,
                            color: ThemeColors.primaryColor
                        ),),
                      ],
                    ),
                  ],
                )
              ],
            ),
            Positioned(
              right: 0,
              child: Row(
                children: [
                  Icon(Icons.circle,size: 10,color: activeValidity!.isActive == "1" ? ThemeColors.primaryColor : ThemeColors.redColor,),
                  const SizedBox(width: 2.0,),
                  Text(activeValidity!.isActive == "1" ? "Active" : "Expired",style: GoogleFonts.montserrat(
                      fontSize: Dimensions.fontSizeDefault,
                      color: ThemeColors.blackColor,
                      fontWeight: FontWeight.w700
                  ),),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
