import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:task_pro/controller/auth_controller.dart';
import 'package:task_pro/controller/profile_controller.dart';
import 'package:task_pro/data/api/api_client.dart';
import 'package:task_pro/data/model/profile_model.dart';
import 'package:task_pro/helper/route_helper.dart';
import 'package:task_pro/util/dimensions.dart';
import 'package:task_pro/util/theme_colors.dart';

import '../../../../util/app_constants.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool _isLoading = false;
  ProfileModel? _profileData;

  bool isHomePageBannerLoaded = false;
  BannerAd? homePageBanner;

  /// Loads a banner ad.
  Future<void> _loadAd() async {
    homePageBanner = BannerAd(
      // adUnitId: AdHelper.homePageBanner(),
      adUnitId:AppConstants.banneradUnitId,
      //  adUnitId:"ca-app-pub-8652359680658191/5924662321",
      //adUnitId:"ca-app-pub-7017789760992330/47449969281",
      size: AdSize.banner,
      // request: request,
      request: const AdRequest(
        //contentUrl: "https://www.freepik.com"
      ),
      listener: BannerAdListener(
          onAdLoaded: (ad) {
            log("HomePage Banner Loaded!");
            isHomePageBannerLoaded = true;
          },
          onAdClosed: (ad) {
            ad.dispose();
            isHomePageBannerLoaded = false;
          },
          onAdFailedToLoad: (ad, err) {
            log(err.toString());
            isHomePageBannerLoaded = false;
          }
      ),
    );

    await homePageBanner!.load();
  }


  @override
  void initState(){
    super.initState();
    Get.find<ProfileController>().getProfileData();
    _loadAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.secondaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: ThemeColors.whiteColor,),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0,bottom: 15.0),
            child: Row(
              children: [
                Text('profile_details'.tr,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: Dimensions.fontSizeOverOverLarge,
                    fontWeight: FontWeight.w600,
                    color: ThemeColors.whiteColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: GetBuilder<ProfileController>(builder: (profileController) {
        _profileData = profileController.profileData;
        _isLoading = profileController.isLoading;
          return _isLoading ? _profileData != null ? SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration:  const BoxDecoration(
                      color: Color(0xFFF4F4F4),
                      border: Border(
                        bottom: BorderSide(width: 1)
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0,left: 20.0,bottom: 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('name'.tr,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              fontSize: Dimensions.fontSizeDefault,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF4F4F51),
                            ),
                          ),
                          Text(_profileData!.name ?? "",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              fontSize: Dimensions.fontSizeExtraLarge,
                              fontWeight: FontWeight.w400,
                              color: ThemeColors.blackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 25.0,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration:  const BoxDecoration(
                      color: Color(0xFFF4F4F4),
                      border: Border(
                        bottom: BorderSide(width: 1)
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0,left: 20.0,bottom: 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('mobile_number'.tr,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              fontSize: Dimensions.fontSizeDefault,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF4F4F51),
                            ),
                          ),
                          Text(_profileData!.mobileNo ?? "",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              fontSize: Dimensions.fontSizeExtraLarge,
                              fontWeight: FontWeight.w400,
                              color: ThemeColors.blackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 25.0,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration:  const BoxDecoration(
                      color: Color(0xFFF4F4F4),
                      border: Border(
                        bottom: BorderSide(width: 1)
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0,left: 20.0,bottom: 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('email'.tr,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              fontSize: Dimensions.fontSizeDefault,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF4F4F51),
                            ),
                          ),
                          Text(_profileData!.email ?? "",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              fontSize: Dimensions.fontSizeExtraLarge,
                              fontWeight: FontWeight.w400,
                              color: ThemeColors.blackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          : Text('No Data Found'.tr,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: Dimensions.fontSizeOverOverLarge,
              fontWeight: FontWeight.w600,
              color: ThemeColors.whiteColor,
            ),
          )
          : const Center(child: CircularProgressIndicator(color: ThemeColors.primaryColor,),);
        }
      ),
      bottomNavigationBar:SizedBox(
        // width: widget.adSize.width.toDouble(),
        // height: widget.adSize.height.toDouble(),
        width: 200,
        height:50,
        child: homePageBanner == null
        // Nothing to render yet.
            ? SizedBox()
        // The actual ad.
            : AdWidget(ad: homePageBanner!),
      ),
    );
  }
}
