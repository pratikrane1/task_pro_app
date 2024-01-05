import 'dart:collection';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_pro/controller/task_controller.dart';
import 'package:task_pro/util/dimensions.dart';
import 'package:task_pro/util/theme_colors.dart';
import 'package:task_pro/view/base/custome_dialog.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:screenshot/screenshot.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

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

  @override
  void initState() {
    super.initState();
    // if (Platform.isAndroid) WebViewController.fromPlatform(platform) = WebViewController();
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
          });
        },
      ))
      ..loadRequest(
        Uri.parse(widget.url),
      );
  }

  void showMemberMenu() async {
    await showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(100, 110, 10, 100),
      items: [
        PopupMenuItem(
          value: 1,
          child: RichText(
            text: TextSpan(
              text: "Steps:\n\n",
                style: GoogleFonts.inter(
                    fontSize: Dimensions.fontSizeSmall,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              children: [
                TextSpan(
                  text: widget.isYoutube ? "* Watch full video\n" : "* Add 5 star rating,\n",
                  style: GoogleFonts.montserrat(
                    fontSize: Dimensions.fontSizeSmall,
                    fontWeight: FontWeight.w400,
                    color: ThemeColors.blackColor,
                  ),
                ),
                TextSpan(
                  text: widget.isYoutube ? "* After that like video and subscribe\n" : '* Press and Hold on review textbox and paste the copied text.\n',
                  style: GoogleFonts.montserrat(
                    fontSize: Dimensions.fontSizeSmall,
                    fontWeight: FontWeight.w400,
                    color: ThemeColors.blackColor,
                  ),
                ),
                TextSpan(
                  text: widget.isYoutube ? "* And then press the above ScreenShot/Upload Button.\n" : '* After that click on the post button.\n',
                  style: GoogleFonts.montserrat(
                    fontSize: Dimensions.fontSizeSmall,
                    fontWeight: FontWeight.w400,
                    color: ThemeColors.blackColor,
                  ),
                ),
                TextSpan(
                  text: widget.isYoutube ? " " : '* Then click on See Your Review button.\n',
                  style: GoogleFonts.montserrat(
                    fontSize: Dimensions.fontSizeSmall,
                    fontWeight: FontWeight.w400,
                    color: ThemeColors.blackColor,
                  ),
                ),
                TextSpan(
                  text: widget.isYoutube ? " " : '* Then list out your name and press the above ScreenShot/Upload Button.\n',
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.whiteColor,
        automaticallyImplyLeading: false,
        title: InkWell(
          onTap: ()async{
            // final capturedImage = await _screenshotController.capture();
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
      body: Screenshot(
        controller: _screenshotController,
        child: SafeArea(
          child: Stack(
            children: [
              // WebViewWidget(
              //   controller: controller,
              // ),


              InAppWebView(
                key: webViewKey,
                initialUrlRequest: URLRequest(url: Uri.parse(widget.url),),
                initialUserScripts: UnmodifiableListView<UserScript>([]),
                // pullToRefreshController: pullToRefreshController,
                onWebViewCreated: (controller) async {
                  // _inAppWebViewController!.takeScreenshot();
                },
                onLoadStart: (controller, url) async {
                  setState(() {
                    loadingPercentage = 0;
                  });
                },
                onScrollChanged: (controller,a,b)async{
                  capturedImage = await controller.takeScreenshot();
                },
                shouldOverrideUrlLoading:
                    (controller, navigationAction) async {
                  var uri = navigationAction.request.url!;

                  return NavigationActionPolicy.ALLOW;
                },
                onLoadStop: (controller, url) async {
                  capturedImage = await controller.takeScreenshot();
                  pullToRefreshController?.endRefreshing();
                  capturedImage = await controller.takeScreenshot();
                  setState(() {
                    loadingPercentage = 100;
                  });
                },
                onProgressChanged: (controller, progress) {
                  if (progress == 100) {}
                  setState(() {
                    loadingPercentage = progress;
                  });
                  setState(() {
                    // this.progress = progress / 100;
                    // urlController.text = this.url;
                  });
                },
                onUpdateVisitedHistory: (controller, url, isReload) {
                  setState(() {
                    // this.url = url.toString();
                    // urlController.text = this.url;
                  });
                },
                onConsoleMessage: (controller, consoleMessage) {
                  print(consoleMessage);
                },
              ),


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
