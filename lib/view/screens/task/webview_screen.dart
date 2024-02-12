import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_pro/controller/task_controller.dart';
import 'package:task_pro/data/model/Duration_model.dart';
import 'package:task_pro/util/dimensions.dart';
import 'package:task_pro/util/theme_colors.dart';
import 'package:task_pro/view/base/custome_dialog.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:screenshot/screenshot.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WebviewScreen extends StatefulWidget {
  const WebviewScreen({required this.url,required this.howToDoText,required this.isYoutube,super.key});
  final String url;
  final String howToDoText;
  final bool isYoutube;

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  var loadingPercentage = 0;
  WebViewController controller = WebViewController();
  ScreenshotController _screenshotController = ScreenshotController();

  final GlobalKey webViewKey = GlobalKey();
  PullToRefreshController? pullToRefreshController = PullToRefreshController();
  InAppWebViewController? _inAppWebViewController;
  DurationModel? _durationData;

  int timerDuration = 0;
  bool isPageLoad = false;
  String? videoIdd;


  Timer? countdownTimer;
  Duration myDuration = Duration();

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
    //   crossPlatform: InAppWebViewOptions(
    //     javaScriptEnabled: true
    //   )
  );

  @override
  void initState() {
    super.initState();
    // if(widget.isYoutube) {
    //   videoIdd = YoutubePlayer.convertUrlToId(widget.url);
    //   apiCall();
    // }
    _inAppWebViewController;
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onUrlChange: (url){
          print(url);
        },
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
          });
          // showMemberMenu();
        },
        onProgress: (progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
            if(widget.isYoutube) {
              isPageLoad = true;
              startTimer();
            }
          });
        },
      ))
      ..loadRequest(
        Uri.parse(widget.url),
        // Uri.parse("https://play.google.com/store/apps/details?id=com.destek.proapp&pcampaignid=web_share"),
        // Uri.parse("https://play.google.com/store/apps"),
        // Uri.parse("market://details?id=com.meradoc"),
      );
  }

  apiCall()async{
    _durationData = await Get.find<TaskController>().getYoutubeTaskVideoDuration(videoIdd!);
    print(_durationData);
    setState(() {
      timerDuration = convertTime("${_durationData!.items![0].contentDetails!.duration}");
      myDuration= Duration(seconds: timerDuration);
    });
    print("Video Duration : $timerDuration");
  }

  /// Timer related methods ///
  // Step 3
  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 2), (_) => setCountDown());
  }
  // Step 4
  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }
  // Step 5
  void resetTimer() {
    stopTimer();
    setState(() => myDuration = Duration(days: 5));
  }

  // Step 6
  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }


  int convertTime(String duration) {

    RegExp regex = new RegExp(r'(\d+)');
    List<String> a = regex.allMatches(duration).map((e) => e.group(0)!).toList();

    if (duration.indexOf('M') >= 0 &&
        duration.indexOf('H') == -1 &&
        duration.indexOf('S') == -1) {
      a = ["0", a[0], "0"];
    }

    if (duration.indexOf('H') >= 0 && duration.indexOf('M') == -1) {
      a = [a[0], "0", a[1]];
    }
    if (duration.indexOf('H') >= 0 &&
        duration.indexOf('M') == -1 &&
        duration.indexOf('S') == -1) {
      a = [a[0], "0", "0"];
    }

    int seconds = 0;

    if (a.length == 3) {
      seconds = seconds + int.parse(a[0]) * 3600;
      seconds = seconds + int.parse(a[1]) * 60;
      seconds = seconds + int.parse(a[2]);
    }

    if (a.length == 2) {
      seconds = seconds + int.parse(a[0]) * 60;
      seconds = seconds + int.parse(a[1]);
    }

    if (a.length == 1) {
      seconds = seconds + int.parse(a[0]);
    }
    return seconds;
  }

  void showMemberMenu() async {
    await showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(100, 110, 10, 100),
      items: [
        PopupMenuItem(
          value: 1,
          child:  widget.isYoutube ? SizedBox(
              width:MediaQuery.of(context).size.width,
              // height: 50,
              child: Html(data: widget.howToDoText)) :
          RichText(
            text: TextSpan(
              text: "Steps:\n\n",
                style: GoogleFonts.inter(
                    fontSize: Dimensions.fontSizeSmall,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              children: [
                TextSpan(
                  text: "* Add 5 star rating,\n",
                  style: GoogleFonts.montserrat(
                    fontSize: Dimensions.fontSizeSmall,
                    fontWeight: FontWeight.w400,
                    color: ThemeColors.blackColor,
                  ),
                ),
                TextSpan(
                  text: '* Press and Hold on review textbox and paste the copied text.\n',
                  style: GoogleFonts.montserrat(
                    fontSize: Dimensions.fontSizeSmall,
                    fontWeight: FontWeight.w400,
                    color: ThemeColors.blackColor,
                  ),
                ),
                TextSpan(
                  text: '* After that click on the post button.\n',
                  style: GoogleFonts.montserrat(
                    fontSize: Dimensions.fontSizeSmall,
                    fontWeight: FontWeight.w400,
                    color: ThemeColors.blackColor,
                  ),
                ),
                TextSpan(
                  text: '* Then click on See Your Review button.\n',
                  style: GoogleFonts.montserrat(
                    fontSize: Dimensions.fontSizeSmall,
                    fontWeight: FontWeight.w400,
                    color: ThemeColors.blackColor,
                  ),
                ),
                TextSpan(
                  text: '* Then list out your name and press the above ScreenShot/Upload Button.\n',
                  style: GoogleFonts.montserrat(
                    fontSize: Dimensions.fontSizeSmall,
                    fontWeight: FontWeight.w400,
                    color: ThemeColors.blackColor,
                  ),
                ),
              ]
            ),
          )

        ),
      ],
      elevation: 8.0,
    ).then((value) {
      if (value != null) print(value);
    });
  }

  Uint8List?  capturedImage;

  @override
  Widget build(BuildContext context) {

    String strDigits(int n) => n.toString().padLeft(2, '0');

    // Step 7
    final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));


    return Screenshot(
      controller: _screenshotController,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeColors.whiteColor,
          automaticallyImplyLeading: false,
          title: InkWell(
            onTap: ()async{
              final capturedImage = await _screenshotController.capture();
              // capturedImage = await _inAppWebViewController!.takeScreenshot();
              if (kDebugMode) {
                print(capturedImage);
              }

              String imagePath = await Get.find<TaskController>().saveImage(capturedImage!,);
              print(imagePath);
              Navigator.pop(context, imagePath);
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width/2.5,
                decoration: const BoxDecoration(
                    color: ThemeColors.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Center(
                    child: Text("ScreenShot / Upload",
                      style: GoogleFonts.inter(
                          color: ThemeColors.whiteColor,
                          fontSize: Dimensions.fontSizeDefault,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                showMemberMenu();
              },
              child: Row(
                children: [
                  const Icon(Icons.info,color: ThemeColors.blackColor,),
                  const SizedBox(width: 5.0,),
                  Text("How to do?",
                    style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: Dimensions.fontSizeDefault,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10.0,),
          ],
        ),
        // floatingActionButton: widget.isYoutube ? isPageLoad ? FloatingActionButton.extended(
        //   backgroundColor: ThemeColors.redColor,
        //   label: Text('$hours:$minutes:$seconds'),
        //   onPressed: () {  },
        // ) : null : null,
        body: SafeArea(
          child: Stack(
            children: [

              // Platform.isAndroid ?
              WebViewWidget(
                controller: controller,
              ) ,
              //     :
            // InAppWebView(
            //     key: webViewKey,
            //     initialUrlRequest: URLRequest(url: Uri.parse(widget.url),),
            //     initialUserScripts: UnmodifiableListView<UserScript>([]),
            //     initialOptions: options,
            //   // pullToRefreshController: pullToRefreshController,
            //     onWebViewCreated: (controller) async {
            //       // _inAppWebViewController!.takeScreenshot();
            //       capturedImage = await controller.takeScreenshot();
            //     },
            //     onLoadStart: (controller, url) async {
            //       setState(() {
            //         loadingPercentage = 0;
            //       });
            //     },
            //     onScrollChanged: (controller,a,b)async{
            //       capturedImage = await controller.takeScreenshot();
            //     },
            //
            //     shouldOverrideUrlLoading:
            //         (controller, navigationAction) async {
            //       var uri = navigationAction.request.url!;
            //       capturedImage = await controller.takeScreenshot();
            //       // var uri = navigationAction.request.url!;
            //
            //       if (![
            //         "http",
            //         "https",
            //         "file",
            //         "chrome",
            //         "data",
            //         "javascript",
            //         "about"
            //       ].contains(uri.scheme)) {
            //         if (await canLaunchUrl(uri)) {
            //           // Launch the App
            //           await launchUrl(
            //             uri,
            //           );
            //           // and cancel the request
            //           return NavigationActionPolicy.CANCEL;
            //         }
            //       }
            //
            //       return NavigationActionPolicy.ALLOW;
            //     },
            //
            //     onLoadStop: (controller, url) async {
            //       capturedImage = await controller.takeScreenshot();
            //       pullToRefreshController?.endRefreshing();
            //       capturedImage = await controller.takeScreenshot();
            //       setState(() {
            //         loadingPercentage = 100;
            //         isPageLoad = true;
            //       });
            //
            //       // if(timerDuration != null){
            //       //   timerDuration++;
            //       //   // if(timerDuration == 10)
            //       // }
            //       // Timer(await Duration(seconds: 0,minutes: 1), () {
            //
            //       // });
            //     },
            //     onProgressChanged: (controller, progress) {
            //       if (progress == 100) {}
            //       setState(() {
            //         loadingPercentage = progress;
            //       });
            //       setState(() {
            //         // this.progress = progress / 100;
            //         // urlController.text = this.url;
            //       });
            //     },
            //     onUpdateVisitedHistory: (controller, url, isReload) {
            //       setState(() {
            //         // this.url = url.toString();
            //         // urlController.text = this.url;
            //       });
            //     },
            //     onConsoleMessage: (controller, consoleMessage) {
            //       print(consoleMessage);
            //     },
            //   ),


              if (loadingPercentage < 100)
                LinearProgressIndicator(
                  value: loadingPercentage / 100.0,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
