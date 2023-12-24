import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;


class NotificationHelper {
  static Future<void> initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize = AndroidInitializationSettings('ic_launcher');
    var iOSInitialize = IOSInitializationSettings();
    var initializationsSettings = new InitializationSettings(
        android: androidInitialize, iOS: iOSInitialize);
    flutterLocalNotificationsPlugin.initialize(initializationsSettings,
        onSelectNotification: (String? payload) async {
      try {

        // print(initializationsSettings);
        // if (payload != null && payload.isNotEmpty) {
          if (payload == "Autopull Repurchase") {
            // Get.toNamed(RouteHelper.getMembershipDetail());
          }
        // }
        else {
          // Get.toNamed(RouteHelper.getNotificationRoute());
          // showCustomSnackBar("Notification data fail to load");
        }
      } catch (e) {}
      return;
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(
          "onMessage: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
      NotificationHelper.showNotification(
          message, flutterLocalNotificationsPlugin, false);
      // if(Get.find<AuthController>().getUserNumber() != "") {
      //   Get.find<NotificationController>().getNotificationList();
      // }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(
          "onOpenApp: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
      try {
        if (message.notification!.title == "Autopull Repurchase") {
          // Get.to(()=>MembershipScreen(isGainZPro: true,));
          // Get.toNamed(RouteHelper.getMembershipDetail());
        } else {
          // Get.toNamed(RouteHelper.getNotificationRoute());
        }
      } catch (e) {}
    });
  }

  static Future<void> showNotification(RemoteMessage message,
      FlutterLocalNotificationsPlugin fln, bool data) async {
    if (!GetPlatform.isIOS) {
      String _title;
      String _body;
      _title = message.notification!.title!;
      _body = message.notification!.body!;

      await showTextNotification(_title, _body, "", fln);

    }
  }

  static Future<void> showBigTextNotification(String title, String body, String orderID, FlutterLocalNotificationsPlugin fln) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      body, htmlFormatBigText: true,
      contentTitle: title, htmlFormatContentTitle: true,
    );
    AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'destek-pro', 'destek-pro', importance: Importance.max,
      styleInformation: bigTextStyleInformation, priority: Priority.max, playSound: true,
      sound: RawResourceAndroidNotificationSound('notification'),
    );
    NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: orderID);
  }

  static Future<void> showTextNotification(String title, String body,
      String orderID, FlutterLocalNotificationsPlugin fln) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'high_importance_channel',
      'high_importance_channel',
      playSound: true,
      importance: Importance.max,
      priority: Priority.max,
      // sound: RawResourceAndroidNotificationSound('notification'),
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: title);
  }



  static Future<String> _downloadAndSaveFile(
      String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }
}

Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  print(
      "onBackground: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
  var androidInitialize = new AndroidInitializationSettings('ic_launcher');
  var iOSInitialize = new IOSInitializationSettings();
  var initializationsSettings = new InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  NotificationHelper.showNotification(message, flutterLocalNotificationsPlugin, true);
  // try {
  //   if (message.notification!.title == "Autopull Repurchase") {
  //     // Get.to(()=>MembershipScreen(isGainZPro: true,));
  //     Get.toNamed(RouteHelper.getMembershipDetail());
  //   } else {
  //     // Get.toNamed(RouteHelper.getNotificationRoute());
  //   }
  // } catch (e) {}
}
