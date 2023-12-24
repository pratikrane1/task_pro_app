import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_pro/data/api/api_client.dart';
import 'package:task_pro/util/app_constants.dart';
import '../../controller/auth_controller.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> login(
      {String? phone, String? token, String? deviceId,String? password,String? loginwith}) async {
    return await apiClient.postData(AppConstants.LOGIN, {
      "mobile_no": phone,
      // "authorization_key": token,
      // "device_token": deviceId,
      "password": password,
      "login_with": loginwith,
    });
  }

  Future<Response> verifySMSOTP(
      {String? mobileNumber,String? otp}) async {
    return await apiClient.postData(AppConstants.VERIFY_SMS_OTP, {
      "mobile_no": mobileNumber,
      "otp": otp,
    });
  }

  // Future<Response> sendOTP(
  //     {String? email,String? mobileNo}) async {
  //   return await apiClient.postData(AppConstants.SEND_OTP, {
  //     // "email": email,
  //     "mobile": mobileNo
  //   });
  // }

  // Future<Response> verifyOTP(
  //     {String? email,String? otp}) async {
  //   return await apiClient.postData(AppConstants.VERIFY_OTP, {
  //     "number": email,
  //     "otp": otp,
  //   });
  // }



  // Future<Response> resetPassword(
  //     {String? userId,String? password,}) async {
  //   return await apiClient.postData(AppConstants.RESET_PASSWORD, {
  //     "user_id": userId,
  //     "new_password": password,
  //   });
  // }

  // Future<Response> updateFirebaseFCM(String userId,String fcmId,String isNotification) async {
  //
  //   return await apiClient.postData(AppConstants.UPDATE_FCM, {
  //     "user_id": userId,
  //     "fcm_id": fcmId,
  //     "is_notification": isNotification});
  // }


  Future<void> saveUserNumber(String number) async {
    try {
      await sharedPreferences.setString(
          AppConstants.USER_NUMBER, number.trim());
    } catch (e) {
      throw e;
    }
  }

  Future<void> saveUserToken(String userToken) async {
    try {
      apiClient.token = userToken;
      apiClient.updateHeader(
        userToken, sharedPreferences.getString(AppConstants.LANGUAGE_CODE).toString(),
      );

      await sharedPreferences.setString(
          AppConstants.USER_TOKEN, userToken.trim());
    } catch (e) {
      throw e;
    }
  }

  Future<void> saveNumberTemporary(String number) async {
    try {
      await sharedPreferences.setString(
          AppConstants.NUMBER_TEMPORARY, number.trim());
    } catch (e) {
      throw e;
    }
  }

  Future<void> saveUserId(int id) async {
    try {
      await sharedPreferences.setInt(AppConstants.USER_ID, id);
    } catch (e) {
      throw e;
    }
  }

  Future<void> saveReferalCode(String referalCode) async {
    try {
      await sharedPreferences.setString(AppConstants.REFERAL_CODE, referalCode);
    } catch (e) {
      throw e;
    }
  }

  String getReferalCode() {
    return sharedPreferences.getString(AppConstants.REFERAL_CODE) ?? "";
  }

  Future<bool> removeTempNumber() {
    return sharedPreferences.remove(AppConstants.NUMBER_TEMPORARY);
  }

  int getUserId() {
    return sharedPreferences.getInt(AppConstants.USER_ID) ?? 0;
  }

  String getUserNumber() {
    return sharedPreferences.getString(AppConstants.USER_NUMBER) ?? "";
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.USER_TOKEN) ?? "";
  }

  String getNumberTemporary() {
    return sharedPreferences.getString(AppConstants.NUMBER_TEMPORARY) ?? "";
  }

  Future<bool> clearUserNumber() async {
    return await sharedPreferences.remove(AppConstants.USER_NUMBER);
  }

  Future<bool> clearUserToken() async {
    return await sharedPreferences.remove(AppConstants.USER_TOKEN);
  }

  bool isNotificationActive() {
    return sharedPreferences.getBool(AppConstants.NOTIFICATION) ?? true;
  }

  Future<void> setNotificationActive(bool isActive) async {
    var fcmToken = await FirebaseMessaging.instance.getToken();
    print(fcmToken);
    if(isActive) {
      // updateFirebaseFCM(Get.find<AuthController>().getUserId().toString(),fcmToken.toString(),1.toString());
    }else {
      // updateFirebaseFCM(Get.find<AuthController>().getUserId().toString(),"",0.toString());
    }
    sharedPreferences.setBool(AppConstants.NOTIFICATION, isActive);
  }
}
