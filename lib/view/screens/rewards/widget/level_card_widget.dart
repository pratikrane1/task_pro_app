import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_pro/util/dimensions.dart';
import 'package:task_pro/util/images.dart';
import 'package:task_pro/util/theme_colors.dart';

class LevelCardWidget extends StatelessWidget {
  const LevelCardWidget({required this.level,required this.userCount,required this.amount,super.key});
  final String level;
  final String userCount;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Theme.of(context).cardColor,
          )),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          minLeadingWidth: 5,
          leading: Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: SvgPicture.asset(Images.trophy_icon_2,height: 30,color: ThemeColors.primaryColor,),
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text("Level $level".tr,
              style: GoogleFonts.inter(
                fontSize: Dimensions.fontSizeLarge,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              decoration: const BoxDecoration(
                  color: Color(0xFFFFEEE4),
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${(userCount != "0" && userCount != "1") ? "Users" : 'User'} : $userCount",
                      style: GoogleFonts.inter(
                          fontSize: Dimensions.fontSizeLarge,
                          fontWeight: FontWeight.w500,
                          color: ThemeColors.secondaryColor
                      ),
                    ),
                    Text("Amount: \u{20B9} $amount",
                      style: GoogleFonts.inter(
                          fontSize: Dimensions.fontSizeLarge,
                          fontWeight: FontWeight.w500,
                          color: ThemeColors.secondaryColor
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
