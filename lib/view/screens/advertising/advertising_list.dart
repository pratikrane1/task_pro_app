import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:task_pro/util/dimensions.dart';
import 'package:task_pro/util/images.dart';
import 'package:task_pro/util/theme_colors.dart';
import 'package:task_pro/view/base/custome_dialog.dart';
import 'package:task_pro/view/screens/payout/payout_screen.dart';
import 'package:task_pro/view/screens/profile/policy%20screen/policy_screen.dart';
import 'package:task_pro/view/screens/profile/user%20profile/user_profile_details.dart';
import 'dart:io';


import 'package:provider/provider.dart';

import 'appOpen/app_lifecycle_reactor.dart';
import 'appOpen/app_open_ad_manager.dart';



class AdsListScreen extends StatefulWidget {
  const AdsListScreen({super.key});

  @override
  State<AdsListScreen> createState() => _AdsListScreenState();
}


class _AdsListScreenState extends State<AdsListScreen> {

  // bool intertitialLoaded = false;
  // late InterstitialAd intertitialAd;

  bool isHomePageBannerLoaded = false;
  late BannerAd homePageBanner;

  late AppLifecycleReactor _appLifecycleReactor;

  late NativeAd _ad;
  bool isLoaded = false;


  AppOpenAd? appOpenAd;

  void loadNativeAd() {
    _ad = NativeAd(
        request: const AdRequest(),
        ///This is a test adUnitId make sure to change it
        adUnitId: 'ca-app-pub-3940256099942544/2247696110',
        factoryId: 'listTile',
        listener: NativeAdListener(
            onAdLoaded: (ad){
              setState(() {
                isLoaded = true;
              });
            },
            onAdFailedToLoad: (ad, error){
              ad.dispose();
              print('failed to load the ad ${error.message}, ${error.code}');
            }
        )
    );

    _ad.load();
  }



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

  /// Loads a banner ad.
  Future<void> _loadAd() async {
    homePageBanner = BannerAd(
      // adUnitId: AdHelper.homePageBanner(),
      adUnitId:"ca-app-pub-3940256099942544/6300978111",
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

    await homePageBanner.load();
  }

  // void initializeFullPageAd() async {
  //   await InterstitialAd.load(
  //     // adUnitId: "ca-app-pub-3940256099942544/1033173712",
  //    // adUnitId: "ca-app-pub-7017789760992330/1544118513",
  //     adUnitId: "ca-app-pub-3940256099942544/1033173712",
  //     request: AdRequest(),
  //     adLoadCallback: InterstitialAdLoadCallback(
  //         onAdLoaded: (ad) {
  //           setState(() {
  //             intertitialAd = ad;
  //             intertitialLoaded = true;
  //           });
  //         },
  //         onAdFailedToLoad: (err) {
  //           print(err);
  //           intertitialAd.dispose();
  //           intertitialLoaded = false;
  //         }
  //     ),
  //   );
  // }


  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    // AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
    // _appLifecycleReactor = AppLifecycleReactor(appOpenAdManager: appOpenAdManager);
    // _appLifecycleReactor.listenToAppStateChanges();
   // initializeFullPageAd();
    _loadAd();
    loadNativeAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.secondaryColor,
        title: Text('Advertising List'.tr,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: Dimensions.fontSizeOverLarge,
            fontWeight: FontWeight.w600,
            color: ThemeColors.whiteColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [

          Container(
          child: AdWidget(ad: _ad,),
          alignment: Alignment.center,
          height: 170,
          color: Colors.black12,
        ),
              // Ad mob
              InkWell(
                onTap: (){
                  // if(intertitialLoaded == true)
                  // {
                  //   intertitialAd.show();
                  // }
                  //nativeloadAd();
                },
                child: ListTile(
                  minLeadingWidth: 1,
                  shape: const Border(
                      bottom: BorderSide(width: 0.5,color: ThemeColors.greyTextColor)
                  ),
                  leading: SvgPicture.asset("assets/images/privacy_policy_logo.svg",),
                  title: Text('Interztitial Ad'.tr,
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

              // Open app
              InkWell(
                onTap: (){
                  // AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
                  // _appLifecycleReactor = AppLifecycleReactor(appOpenAdManager: appOpenAdManager);
                  // _appLifecycleReactor.listenToAppStateChanges();
                  loadAppOpenAd();

                },
                child: ListTile(
                  minLeadingWidth: 1,
                  shape: const Border(
                      bottom: BorderSide(width: 0.5,color: ThemeColors.greyTextColor)
                  ),
                  leading: SvgPicture.asset("assets/images/privacy_policy_logo.svg",),
                  title: Text('Open app'.tr,
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
            ],
          ),
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
            : AdWidget(ad: homePageBanner),
      ),
    );
  }

  @override
  void dispose() {
    homePageBanner?.dispose();
    _ad.dispose();
    super.dispose();
  }

}
