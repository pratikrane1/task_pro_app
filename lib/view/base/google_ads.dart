

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Googleads {


  // Open ads banner
  loadAppOpenAd ()
 async {
   await AppOpenAd.load(
        adUnitId: "ca-app-pub-3940256099942544/9257395921",
        request: AdRequest(),
        adLoadCallback: AppOpenAdLoadCallback(
            onAdLoaded:(ad)
            async{
              await ad.show();

            },
            onAdFailedToLoad: (error)
            {
              print('error');
            }
        ),
        orientation: AppOpenAd.orientationPortrait
    );
  }

  void initializeFullPageAd() async {
    await InterstitialAd.load(
      // adUnitId: "ca-app-pub-3940256099942544/1033173712",
      // adUnitId: "ca-app-pub-7017789760992330/1544118513",
      adUnitId: "ca-app-pub-3940256099942544/1033173712",
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad)async {
            print(ad);
            await ad.show();
          },
          onAdFailedToLoad: (err) {
            print(err);
          }
      ),
    );
  }

  /// Loads a banner ad.
  Future<BannerAd> loadBannerAd() async {
    var bannerad;
    bannerad = BannerAd(
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
            // isHomePageBannerLoaded = true;
          },
          onAdClosed: (ad) {
            ad.dispose();
            // isHomePageBannerLoaded = false;
          },
          onAdFailedToLoad: (ad, err) {
            log(err.toString());
            // isHomePageBannerLoaded = false;
          }
      ),
    );
    await bannerad.load();
    return bannerad;
  }


}
