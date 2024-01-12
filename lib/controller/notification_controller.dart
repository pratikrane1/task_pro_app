import 'package:get/get.dart';
import 'package:task_pro/data/repository/notification_repo.dart';

class NotificationController extends GetxController implements GetxService {
  final NotificationRepo notificationRepo;
  NotificationController({required this.notificationRepo});


  String? _fcmNotificationTitle;

  String get fcmNotificationTitle => _fcmNotificationTitle ?? "";


  Future<String> getFcmNotificationTitle(String fcmTitle) async {
    _fcmNotificationTitle = fcmTitle;
    update();
    // }
    return _fcmNotificationTitle!;
  }
}
