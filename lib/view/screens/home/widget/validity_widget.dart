import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:task_pro/controller/auth_controller.dart';
import 'package:task_pro/controller/profile_controller.dart';
import 'package:task_pro/controller/validity_controller.dart';
import 'package:task_pro/data/model/profile_model.dart';
import 'package:task_pro/data/model/validity_model.dart';
import 'package:task_pro/util/dimensions.dart';
import 'package:task_pro/util/theme_colors.dart';
import 'package:intl/intl.dart';
import 'package:task_pro/view/screens/validity%20screen/validity_screen.dart';

class ValidityWidget extends StatefulWidget {
  const ValidityWidget({super.key});

  @override
  State<ValidityWidget> createState() => _ValidityWidgetState();
}

class _ValidityWidgetState extends State<ValidityWidget> {
  bool _isLoading = false;
  ValidityModel? _taskProDashValidity;
  ProfileModel? _profileData;


  @override
  void initState(){
    super.initState();
    fetchUserProfile();
  }

  void fetchUserProfile() async {
    _profileData = await Get.find<ProfileController>().profileData;
    if (_profileData == null) {
      _profileData = await Get.find<ProfileController>().getProfileData();
      Get.find<ValidityController>().getTaskProValidityData(_profileData!.gainzProUserId.toString());
    }
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<ValidityController>(builder: (validityController) {
      _isLoading = validityController.isLoading;
      _taskProDashValidity = validityController.taskProDashValidity;
      return _isLoading
          ? _taskProDashValidity != null ? Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: const Color(0xFFE3EFFF),
              borderRadius: BorderRadius.circular(
                  Dimensions.RADIUS_EXTRA_LARGE),
              boxShadow: const [
                BoxShadow(
                  // color: ThemeColors.greyTextColor,
                  // blurRadius: 2,
                  // spreadRadius: 0.3,
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("task_pro_validity".tr,style: GoogleFonts.inter(
                              fontSize: Dimensions.fontSizeExtraLarge,
                              color: ThemeColors.blackColor,
                              fontWeight: FontWeight.w700
                          ),),
                          const SizedBox(width: 2.0,),
                          _taskProDashValidity!.validFor != "" ? Text(("${_taskProDashValidity!.validFor ?? ""}"),style: GoogleFonts.inter(
                            fontSize: Dimensions.fontSizeSmall,
                            fontWeight: FontWeight.w600,
                            color: ThemeColors.primaryColor,
                          ),) : const SizedBox(),
                        ],
                      ),
                      const SizedBox(height: 5.0,),

                      _taskProDashValidity!.endDate != null ?
                      Row(
                        children: [
                          // Text("Start from: ",style: GoogleFonts.inter(
                          //     fontSize: Dimensions.fontSizeDefault,
                          //     fontWeight: FontWeight.w600,
                          //     color: ThemeColors.blackColor.withOpacity(0.7)
                          // ),),
                          // Text("36/1/2024",style: GoogleFonts.inter(
                          //     fontSize: Dimensions.fontSizeDefault,
                          //     fontWeight: FontWeight.w600,
                          //     color: ThemeColors.primaryColor
                          // ),),
                          // Text(" | ",style: GoogleFonts.inter(
                          //   color: ThemeColors.blackColor,
                          //   fontWeight: FontWeight.w600,
                          //   fontSize: Dimensions.fontSizeLarge,
                          //
                          // ),),
                          Text(_taskProDashValidity!.isActive == "1" ? "Expires on: " : "Expired on: ",style: GoogleFonts.inter(
                              fontSize: Dimensions.fontSizeDefault,
                              fontWeight: FontWeight.w600,
                              color: ThemeColors.blackColor.withOpacity(0.7)
                          ),),
                          Text(DateFormat('dd-MM-yyyy').format(DateTime.parse(_taskProDashValidity!.endDate!)) ?? "",style: GoogleFonts.inter(
                              fontSize: Dimensions.fontSizeDefault,
                              fontWeight: FontWeight.w600,
                              color: ThemeColors.primaryColor
                          ),),
                        ],
                      ) : SizedBox(),
                      const SizedBox(height: 10.0,),

                      InkWell(
                        onTap: (){
                          Get.to(()=>const ValidityScreen());
                        },
                        child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width/2.5,
                          decoration: const BoxDecoration(
                            color: Color(0xFFC3DDFF),
                            borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Know More'.tr,
                                  style: GoogleFonts.inter(
                                      color: ThemeColors.blackColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                const Icon(Icons.arrow_forward,color: ThemeColors.blackColor,)
                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                  Positioned(
                    right: 0,
                    child: Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 10,
                          color: _taskProDashValidity!.isActive == "1" ? ThemeColors.primaryColor : ThemeColors.redColor,
                        ),
                        const SizedBox(
                          width: 2.0,
                        ),
                        Text(
                          _taskProDashValidity!.isActive == "1" ? "Active" :"Expired",
                          style: GoogleFonts.montserrat(
                              fontSize: Dimensions.fontSizeDefault,
                              color: ThemeColors.blackColor,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
          : const SizedBox()
          : Shimmer(
        duration: const Duration(seconds: 2),
        enabled: true,
        child: Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              borderRadius:
              BorderRadius.circular(Dimensions.RADIUS_SMALL),
              color: Colors.grey[300],
            )),
      );
      }
    );
  }
}
