import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:task_pro/data/api/api_client.dart';
import 'package:task_pro/util/app_constants.dart';

class ProfileRepo extends GetxService {
  final ApiClient apiClient;
  ProfileRepo({required this.apiClient});

  Future<Response> getProfileData() async {
    var fcmToken = await FirebaseMessaging.instance.getToken();
    print("FCM TOKEN : $fcmToken");
    return await apiClient
        .getData(AppConstants.PROFILE_DATA+"/$fcmToken",);
  }

  Future<Response> getPolicy(String policy, String termsAndConditions) async {
    return await apiClient.postData(AppConstants.POLICY, {
      "policy" : policy,
      "terms_and_condition" : termsAndConditions
    });
  }
}
