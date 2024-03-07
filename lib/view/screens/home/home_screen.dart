import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_pro/controller/auth_controller.dart';
import 'package:task_pro/controller/google_ad_controller.dart';
import 'package:task_pro/controller/profile_controller.dart';
import 'package:task_pro/controller/rewards_controller.dart';
import 'package:task_pro/controller/task_controller.dart';
import 'package:task_pro/controller/validity_controller.dart';
import 'package:task_pro/data/model/profile_model.dart';
import 'package:task_pro/util/dimensions.dart';
import 'package:task_pro/util/theme_colors.dart';
import 'package:task_pro/view/base/google_ads.dart';
import 'package:task_pro/view/screens/home/widget/all_task_widget.dart';
import 'package:task_pro/view/screens/home/widget/payout_widget.dart';
import 'package:task_pro/view/screens/home/widget/todays_task_widget.dart';
import 'package:task_pro/view/screens/home/widget/validity_widget.dart';
import 'package:task_pro/view/screens/notification/notification_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:developer';

import '../../../util/app_constants.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool _isLoading = false;
  ProfileModel? _profileData;

  bool isHomePageBannerLoaded = false;
  BannerAd? homePageBanner;

  AppOpenAd? appOpenAd;

  // Open ads banner
  loadAppOpenAd()
  {
    AppOpenAd.load(
        adUnitId: "ca-app-pub-3940256099942544/9257395921",
        request: AdRequest(),
        adLoadCallback: AppOpenAdLoadCallback(
            onAdLoaded: (ad)
            {
              appOpenAd=ad;
              appOpenAd!.show();
            },
            onAdFailedToLoad: (error)
            {
              print('error');
            }
        ),
        orientation: AppOpenAd.orientationPortrait
    );
  }




  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    Get.find<TaskController>().autoAssignTask();
    Get.find<TaskController>().getAllTask("");
    Get.find<ProfileController>().getProfileData();
     // _loadAd();
    callBannerAd();
    // loadAppOpenAd();
    Get.find<GoogleAdController>().appOpenAd!.show();
  }

  void callBannerAd()async
  {
    homePageBanner = await Googleads().loadBannerAd();
    setState((){

    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          color: ThemeColors.primaryColor,
          onRefresh: () async {
            await Get.find<TaskController>().getAllTask("");
            await Get.find<ProfileController>().getProfileData();
            await Get.find<RewardsController>().getTodaysPayoutData();
            await Get.find<ValidityController>().getTaskProValidityData(Get.find<ProfileController>().profileData!.gainzProUserId.toString());

          },
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              ///AppBar
              SliverAppBar(
                floating: true,
                // forceElevated: true,
                automaticallyImplyLeading: false,
                backgroundColor: ThemeColors.secondaryColor,
                toolbarHeight: 90,
                title: SizedBox(
                  height: 55,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GetBuilder<ProfileController>(builder: (profileController) {
                            _profileData = profileController.profileData;
                            _isLoading = profileController.isLoading;
                              return _isLoading ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${"hello".tr},",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                      fontSize: Dimensions.fontSizeLarge,
                                      fontWeight: FontWeight.w400,
                                      color: ThemeColors.whiteColor,
                                    ),
                                  ),
                                  const SizedBox(height: 5,),
                                  Text(_profileData!.name ?? "",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                      fontSize: Dimensions.fontSizeOverLarge,
                                      fontWeight: FontWeight.w700,
                                      color: ThemeColors.whiteColor,
                                    ),
                                  ),
                                ],
                              ) : const SizedBox();
                            }
                          ),

                          // IconButton(
                          //     onPressed: (){
                          //       Navigator.push(context, MaterialPageRoute(builder: (context)=> const NotificationScreen()));
                          //     },
                          //     icon: const Icon(Icons.notifications_rounded,color: ThemeColors.whiteColor,size: 25,),
                          // ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),


              ///Body
              SliverToBoxAdapter(
                child: Center(
                  child: SizedBox(
                    width: Dimensions.WEB_MAX_WIDTH,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        ///All Task
                        AllTaskWidget(),

                        //Validity Widget
                        ValidityWidget(),

                        ///Todays Task
                        TodaysTaskWidget(),

                        ///TOdays Payout
                        PayoutWidget(),
                      ],
                    ),
                  ),
                ),
              ),

            ],
          ),
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
      ),
    );
  }

  @override
  void dispose() {
    homePageBanner?.dispose();
    super.dispose();
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget? child;

  SliverDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child!;
  }

  @override
  double get maxExtent => 55;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 50 ||
        oldDelegate.minExtent != 50 ||
        child != oldDelegate.child;
  }
}
