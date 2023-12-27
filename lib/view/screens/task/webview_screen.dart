import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  const WebviewScreen({required this.url,super.key});
  final String url;

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  var loadingPercentage = 0;
  WebViewController controller = WebViewController();
  ScreenshotController _screenshotController = ScreenshotController();

  // final GlobalKey webViewKey = GlobalKey();
  // InAppWebViewController? webViewController;
  // InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
  //     crossPlatform: InAppWebViewOptions(
  //       useShouldOverrideUrlLoading: true,
  //       allowFileAccessFromFileURLs: true,
  //       allowUniversalAccessFromFileURLs: true,
  //       javaScriptCanOpenWindowsAutomatically: true,
  //       useOnLoadResource: true,
  //       useOnDownloadStart: true,
  //       mediaPlaybackRequiresUserGesture: false,
  //     ),
  //     android: AndroidInAppWebViewOptions(
  //       useHybridComposition: true,
  //     ),
  //     ios: IOSInAppWebViewOptions(
  //       allowsInlineMediaPlayback: true,
  //     ));
  //
  // String url = "https://play.google.com/store/apps/details?id=com.destek.proapp&pcampaignid=web_share";
  //
  // final urlController = TextEditingController();
  //
  // PullToRefreshController pullToRefreshController = PullToRefreshController();
  // double progress = 0;
  //
  // num position = 1;
  // int selectedIndex = 1;
  // String cookiesString = '';
  //
  // Future<void> updateCookies(Uri url) async {
  //   // List<Cookie> cookies = await CookieManager().getCookies(url: url);
  //   List<Cookie> cookies = await CookieManager.instance().getCookies(url: url);
  //   cookiesString = '';
  //   for (Cookie cookie in cookies) {
  //     cookiesString += '${cookie.name}=${cookie.value};';
  //   }
  //   print(cookiesString);
  // }


  @override
  void initState() {
    super.initState();
    // if (Platform.isAndroid) WebViewController.fromPlatform(platform) = WebViewController();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onUrlChange: (url){
          print(url);
        },
        onPageStarted: (url) {
          // launchUrl(
          //   Uri.parse(
          //       url),
          //   mode: LaunchMode.platformDefault,
          // );
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

        // Uri.parse('https://maps.app.goo.gl/rU5LjE6RzhzoAdBs6'),
        // Uri.parse('https://g.page/r/CcM2nPzaehd_EAI/review'),
        // Uri.parse('https://play.google.com/store/apps/details?id=com.destek.proapp&pcampaignid=web_share'),
        Uri.parse(widget.url),
      );
  }

  void showMemberMenu() async {
    await showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(10, 110, 100, 100),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.whiteColor,
        automaticallyImplyLeading: false,
        title: InkWell(
          onTap: ()async{
            final capturedImage = await _screenshotController.capture();
            if (kDebugMode) {
              print(capturedImage);
            }
            // showDialog(
            //     context: context,
            //     builder: (BuildContext context) => UploadDialog(capturePath: capturedImage,));

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
              WebViewWidget(
                controller: controller,
              ),
              // InAppWebView(
              //   key: webViewKey,
              //   initialUrlRequest:
              //   URLRequest(url: Uri.parse("https://play.google.com/store/apps/details?id=com.destek.proapp&pcampaignid=web_share")),
              //   // URLRequest(url: Uri.parse("https://maps.app.goo.gl/rU5LjE6RzhzoAdBs6")),
              //   // URLRequest(url: Uri.parse("https://play.google.com/store/apps/details?id=com.destek.proapp")),
              //   // URLRequest(url: Uri.parse("https://g.page/r/CcM2nPzaehd_EAI/review")),
              //   // URLRequest(url: Uri.parse(widget.url)),
              //   initialOptions: options,
              //   // pullToRefreshController: pullToRefreshController,
              //   onWebViewCreated: (controller) {
              //     webViewController = controller;
              //   },
              //   onLoadStart: (controller, url) {
              //     setState(() {
              //       selectedIndex = 0;
              //       this.url = url.toString();
              //       urlController.text = this.url;
              //     });
              //   },
              //   androidOnPermissionRequest: (controller, origin, resources) async {
              //     return PermissionRequestResponse(
              //         resources: resources,
              //         action: PermissionRequestResponseAction.GRANT);
              //   },
              //   onDownloadStart: (controller, url) async {
              //     print("onDownloadStart $url");
              //     final String _url_files = "$url";
              //     void _launchURL_files() async => await canLaunch(_url_files)
              //         ? await launch(
              //       _url_files,
              //       enableDomStorage: true,
              //       enableJavaScript: true,
              //       universalLinksOnly: true,
              //
              //       // forceSafariVC: true,
              //       // forceWebView: true,
              //     )
              //         : throw 'Could not launch $_url_files';
              //     _launchURL_files();
              //     // final taskId = await FlutterDownloader.enqueue(
              //     //   // headers: {
              //     //   //   HttpHeaders.authorizationHeader: 'Basic ',
              //     //   //   HttpHeaders.connectionHeader: 'keep-alive',
              //     //   //   HttpHeaders.cookieHeader: cookiesString,
              //     //   // },
              //     //   // fileName: "$url",
              //     //   url: "$url",
              //     //   savedDir: (await getExternalStorageDirectory())!.path,
              //     //   saveInPublicStorage: true,
              //     //   showNotification: true,
              //     //   openFileFromNotification: true,
              //     // );
              //   },
              //   // onDownloadStartRequest: (controller, url) async {
              //   //   print("onDownloadStart $url");
              //   //   final taskId = await FlutterDownloader.enqueue(
              //   //     url: url.toString(),
              //   //     savedDir: (await getExternalStorageDirectory())!.path,
              //   //     showNotification:
              //   //         true, // show download progress in status bar (for Android)
              //   //     openFileFromNotification:
              //   //         true, // click on notification to open downloaded file (for Android)
              //   //     saveInPublicStorage: true,
              //   //   );
              //   // },
              //   // onDownloadStart: (controller, url) async {
              //   //   print("onDownloadStart $url");
              //   //   final taskId = await FlutterDownloader.enqueue(
              //   //     url: "$url",
              //   //     savedDir: (await getExternalStorageDirectory())!.path,
              //   //     showNotification:
              //   //         true, // show download progress in status bar (for Android)
              //   //     openFileFromNotification:
              //   //         true, // click on notification to open downloaded file (for Android)
              //   //   );
              //   // },
              //   // shouldOverrideUrlLoading: (controller, navigationAction) async {
              //   //   var uri = navigationAction.request.url!;
              //   //
              //   //   if (![
              //   //     "http",
              //   //     "https",
              //   //     "file",
              //   //     "chrome",
              //   //     "data",
              //   //     "javascript",
              //   //     "about"
              //   //   ].contains(uri.scheme)) {
              //   //     if (await canLaunch(url)) {
              //   //       // Launch the App
              //   //       await launch(
              //   //         url,
              //   //       );
              //   //       // and cancel the request
              //   //       return NavigationActionPolicy.CANCEL;
              //   //     }
              //   //   }
              //   //
              //   //   return NavigationActionPolicy.ALLOW;
              //   // },
              //   onLoadStop: (controller, url) async {
              //     pullToRefreshController.endRefreshing();
              //     if (url != null) {
              //       await updateCookies(url);
              //     }
              //     setState(() {
              //       this.url = url.toString();
              //       urlController.text = this.url;
              //     });
              //   },
              //   onLoadError: (controller, url, code, message) {
              //     pullToRefreshController.endRefreshing();
              //   },
              //   onProgressChanged: (controller, progress) {
              //     if (progress == 100) {
              //       pullToRefreshController.endRefreshing();
              //     }
              //     setState(() {
              //       this.progress = progress / 100;
              //       urlController.text = this.url;
              //     });
              //   },
              //   onUpdateVisitedHistory: (controller, url, androidIsReload) {
              //     setState(() {
              //       this.url = url.toString();
              //       urlController.text = this.url;
              //     });
              //   },
              //   onConsoleMessage: (controller, consoleMessage) {
              //     print(consoleMessage);
              //   },
              // ),

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
