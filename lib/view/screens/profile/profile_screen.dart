import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_pro/util/dimensions.dart';
import 'package:task_pro/util/images.dart';
import 'package:task_pro/util/theme_colors.dart';
import 'package:task_pro/view/base/custome_dialog.dart';
import 'package:task_pro/view/screens/payout/payout_screen.dart';
import 'package:task_pro/view/screens/profile/policy%20screen/policy_screen.dart';
import 'package:task_pro/view/screens/profile/user%20profile/user_profile_details.dart';

import 'delete account/delete_account_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.secondaryColor,
        title: Text('profile'.tr,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: Dimensions.fontSizeOverLarge,
            fontWeight: FontWeight.w600,
            color: ThemeColors.whiteColor,
          ),
        ),
        centerTitle: true,
        // bottom: PreferredSize(
        //   preferredSize: const Size.fromHeight(kToolbarHeight),
        //   child: Padding(
        //     padding: const EdgeInsets.only(left: 20.0,bottom: 15.0),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Row(
        //           children: [
        //             Text('profile'.tr,
        //               textAlign: TextAlign.center,
        //               style: GoogleFonts.inter(
        //                 fontSize: Dimensions.fontSizeOverLarge,
        //                 fontWeight: FontWeight.w600,
        //                 color: ThemeColors.whiteColor,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              ///Profile Details
              InkWell(
                onTap: (){
                  Get.to(() => const UserProfileScreen());
                },
                child: ListTile(
                  minLeadingWidth: 1,
                  shape: const Border(
                    bottom: BorderSide(width: 0.5,color: ThemeColors.greyTextColor)
                  ),
                  leading: SvgPicture.asset(Images.profile_icon),
                  title: Text('profile'.tr,
                    // textAlign: TextAlign.start,
                    style: GoogleFonts.inter(
                      fontSize: Dimensions.fontSizeExtraLarge,
                      fontWeight: FontWeight.w400,
                      color: ThemeColors.blackColor,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),

              const SizedBox(height: 10.0,),

              ///Rewards
              InkWell(
                onTap: (){
                  Get.to(()=> const RewardsScreen());
                },
                child: ListTile(
                  minLeadingWidth: 1,
                  shape: const Border(
                    bottom: BorderSide(width: 0.5,color: ThemeColors.greyTextColor)
                  ),
                  leading: SvgPicture.asset(Images.payout_icon),
                  title: Text('rewards'.tr,
                    // textAlign: TextAlign.start,
                    style: GoogleFonts.inter(
                      fontSize: Dimensions.fontSizeExtraLarge,
                      fontWeight: FontWeight.w400,
                      color: ThemeColors.blackColor,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),

              const SizedBox(height: 10.0,),

              ///Terms and conditions
              InkWell(
                onTap: (){
                  Get.to(()=> const PolicyScreen(isPrivacyPolicy: 1,));
                },
                child: ListTile(
                  minLeadingWidth: 1,
                  shape: const Border(
                    bottom: BorderSide(width: 0.5,color: ThemeColors.greyTextColor)
                  ),
                  leading: SvgPicture.asset("assets/images/terms_condition_logo.svg"),
                  title: Text('terms_and_conditions'.tr,
                    // textAlign: TextAlign.start,
                    style: GoogleFonts.inter(
                      fontSize: Dimensions.fontSizeExtraLarge,
                      fontWeight: FontWeight.w400,
                      color: ThemeColors.blackColor,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),

              const SizedBox(height: 10.0,),

              ///Privacy Policy
              InkWell(
                onTap: (){
                  Get.to(()=> const PolicyScreen(isPrivacyPolicy: 0,));
                },
                child: ListTile(
                  minLeadingWidth: 1,
                  shape: const Border(
                    bottom: BorderSide(width: 0.5,color: ThemeColors.greyTextColor)
                  ),
                  leading: SvgPicture.asset("assets/images/privacy_policy_logo.svg",),
                  title: Text('privacy_policy'.tr,
                    // textAlign: TextAlign.start,
                    style: GoogleFonts.inter(
                      fontSize: Dimensions.fontSizeExtraLarge,
                      fontWeight: FontWeight.w400,
                      color: ThemeColors.blackColor,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),

              const SizedBox(height: 10.0,),

              ///Delete account
              InkWell(
                onTap: (){
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => DeleteAcooountScreen());
                },
                child: ListTile(
                  minLeadingWidth: 1,
                  shape: const Border(
                      bottom: BorderSide(width: 0.5,color: ThemeColors.greyTextColor)
                  ),
                  leading: const Icon(Icons.delete_outline,color: ThemeColors.redColor,),
                  title: Text('delete_account'.tr,
                    // textAlign: TextAlign.start,
                    style: GoogleFonts.inter(
                      fontSize: Dimensions.fontSizeExtraLarge,
                      fontWeight: FontWeight.w400,
                      color: ThemeColors.redColor,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),


              const SizedBox(height: 10.0,),

              ///Logout
              InkWell(
                onTap: (){
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => LogOutDialog());
                },
                child: ListTile(
                  minLeadingWidth: 1,
                  shape: const Border(
                    bottom: BorderSide(width: 0.5,color: ThemeColors.greyTextColor)
                  ),
                  leading: const Icon(Icons.logout,color: ThemeColors.redColor,),
                  title: Text('logout'.tr,
                    // textAlign: TextAlign.start,
                    style: GoogleFonts.inter(
                      fontSize: Dimensions.fontSizeExtraLarge,
                      fontWeight: FontWeight.w400,
                      color: ThemeColors.redColor,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
