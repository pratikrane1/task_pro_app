import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_pro/helper/route_helper.dart';
import 'package:task_pro/util/images.dart';
import 'package:task_pro/util/theme_colors.dart';
import 'package:task_pro/view/base/app_button.dart';

class WalkThroughScreen extends StatefulWidget {
  const WalkThroughScreen({super.key});

  @override
  State<WalkThroughScreen> createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends State<WalkThroughScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100,),

              ///WalkThorugh Image
              SvgPicture.asset(Images.walkthrough_logo),

              const SizedBox(height: 10,),

              ///Text
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "complete".tr,
                  style: GoogleFonts.montserrat(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: ThemeColors.blackColor),
                  children: <TextSpan>[
                    TextSpan(
                      text: " ${"task".tr} ",
                      style: const TextStyle(
                        fontSize: 30,
                        fontFamily: 'Montserrat-ExtraBold',
                        fontWeight: FontWeight.w700,
                        color: ThemeColors.primaryColor,
                      ),
                    ),
                    TextSpan(
                      text: 'earn_easily'.tr,
                      style: GoogleFonts.montserrat(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: ThemeColors.blackColor,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10,),

              Text("you_can_complete_your_task_and_earn_money".tr,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: ThemeColors.blackColor,
              ),
              ),

              const SizedBox(height: 100,),

              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10),
                child: AppButton(
                  onPressed: () async {
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const LogInScreen()));
                    Get.offNamed(RouteHelper.login);
                  },
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  text: Text(
                    'get_started'.tr,
                    style: GoogleFonts.inter(
                        color: ThemeColors.whiteColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  loading: true,
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                        color: ThemeColors.primaryColor, width: 1),
                    backgroundColor: ThemeColors.primaryColor,
                    // color:Colors.red,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
