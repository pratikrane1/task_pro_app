import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:task_pro/controller/localization_controller.dart';
import 'package:task_pro/helper/route_helper.dart';
import 'package:task_pro/util/app_constants.dart';
import 'package:task_pro/util/messages.dart';
import 'package:task_pro/view/base/custom_snackbar.dart';
import 'helper/get_di.dart' as di;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:in_app_update/in_app_update.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false, 
    provisional: false,
    sound: true,
  );

  ///For Android In app update
  if (Platform.isAndroid) {
    InAppUpdate.checkForUpdate().then((updateInfo) {
      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        //Logic to perform an update
        if (updateInfo.immediateUpdateAllowed) {
          // Perform immediate update
          InAppUpdate.performImmediateUpdate().then((appUpdateResult) {
            if (appUpdateResult == AppUpdateResult.success) {
              //App Update successful
              showCustomSnackBar("App Updated.");
            }
          });
        }
      }
    });
  }


  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }

  Map<String, Map<String, String>> _languages = await di.init();

  runApp(MyApp(
    languages: _languages,fcmTitle: "",
  ));
}


class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;
  final String fcmTitle;
  MyApp({
    required this.languages,
    required this.fcmTitle,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // initializeDateFormatting();
    return GetBuilder<LocalizationController>(builder: (localizeController) {
      return GetMaterialApp(
        // useInheritedMediaQuery: true,
        // locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        title: AppConstants.APP_NAME,
        navigatorKey: Get.key,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        locale: localizeController.locale,
        translations: Messages(languages: languages),
        fallbackLocale: Locale(AppConstants.languages[0].languageCode,
            AppConstants.languages[0].countryCode),
        initialRoute: RouteHelper.getSplashRoute(""),
        getPages: RouteHelper.routes,
        localizationsDelegates: const [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      );
    });
  }
}
