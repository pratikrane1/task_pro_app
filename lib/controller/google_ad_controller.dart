import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:task_pro/data/api/api_checker.dart';
import 'package:task_pro/data/model/validity_model.dart';
import 'package:task_pro/data/repository/google_ad_repo.dart';
import 'package:task_pro/data/repository/notification_repo.dart';
import 'package:task_pro/data/repository/validity_repo.dart';

class GoogleAdController extends GetxController implements GetxService {
  final GoogleAdRepo googleAdRepo;
  GoogleAdController({required this.googleAdRepo});


  bool _isLoading = false;
  AppOpenAd? _appOpenAd;


  bool get isLoading => _isLoading;
  AppOpenAd? get appOpenAd => _appOpenAd;


  // Open ads banner
  Future<AppOpenAd> loadAppOpenAd() async {
    await AppOpenAd.load(
        adUnitId: "ca-app-pub-3940256099942544/9257395921",
        request: AdRequest(),
        adLoadCallback: AppOpenAdLoadCallback(onAdLoaded: (ad) async {
          _appOpenAd = ad;
          // await ad.show();

        }, onAdFailedToLoad: (error) {
          print('error');
        }),
        orientation: AppOpenAd.orientationPortrait);

    return _appOpenAd!;
  }

  void initializeFullPageAd() async {
    await InterstitialAd.load(
      // adUnitId: "ca-app-pub-3940256099942544/1033173712",
      // adUnitId: "ca-app-pub-7017789760992330/1544118513",
      adUnitId: "ca-app-pub-3940256099942544/1033173712",
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) async {
        print(ad);
        await ad.show();
      }, onAdFailedToLoad: (err) {
        print(err);
      }),
    );
  }

}
