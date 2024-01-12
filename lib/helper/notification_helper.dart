import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:task_pro/view/screens/payout/payout_screen.dart';
import 'package:task_pro/view/screens/task/task_screen.dart';
import 'package:intl/intl.dart';

class NotificationModel {
  String? action;
  int? id;

  NotificationModel({this.action, this.id});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    action = json['action'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['action'] = this.action;
    data['id'] = this.id;
    return data;
  }
}


class NotificationHelper {



  static Future<void> initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    NotificationModel? data;
    var androidInitialize = const AndroidInitializationSettings('ic_launcher');
    var iOSInitialize = const IOSInitializationSettings();
    var initializationsSettings = InitializationSettings(
        android: androidInitialize, iOS: iOSInitialize);
    flutterLocalNotificationsPlugin.initialize(initializationsSettings,
        onSelectNotification: (String? payload) async {
      try {

        if (data!.action == "Payouts") {
          Get.to(()=>const RewardsScreen());
        }
        if (data!.action == "Tasks") {
          Get.to(()=>TaskScreen(assignTaskDate: "${DateFormat("yyyy-MM-dd").format(DateTime.now())}",));
        }

      } catch (e) {}
      return;
    });


    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      var model = json.decode(message.notification!.titleLocKey!);
      data = NotificationModel.fromJson(model);
      print(
          "onMessage: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
      NotificationHelper.showNotification(
          message, flutterLocalNotificationsPlugin, false);

      // if(Get.find<AuthController>().getUserNumber() != "") {
      //   Get.find<NotificationController>().getNotificationList();
      // }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      NotificationModel data;
      var model = json.decode(message.notification!.titleLocKey!);
      data = NotificationModel.fromJson(model);
      print(
          "onOpenApp: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
      try {
        if (data.action == "Payouts") {
          Get.to(()=>const RewardsScreen());
        }
        if (data.action == "Tasks") {
          Get.to(()=>TaskScreen(assignTaskDate: "${DateFormat("yyyy-MM-dd").format(DateTime.now())}",));
        }
        // if (data.action == "Tasks" && data.id == 0) {
        //   Get.to(()=>TaskDetailScreen(taskId: ,taskList: ,));
        // }
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
      'task-pro', 'task-pro', importance: Importance.max,
      styleInformation: bigTextStyleInformation, priority: Priority.max, playSound: true,
      sound: const RawResourceAndroidNotificationSound('notification'),
    );
    NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: orderID);
  }

  static Future<void> showTextNotification(String title, String body,
      String orderID, FlutterLocalNotificationsPlugin fln) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'task-pro',
      'task-pro',
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
