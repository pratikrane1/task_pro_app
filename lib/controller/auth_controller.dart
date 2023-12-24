import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:task_pro/data/model/login_model.dart';
import 'package:task_pro/data/repository/auth_repo.dart';
import 'package:device_info_plus/device_info_plus.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({required this.authRepo}) {
    _notification = authRepo.isNotificationActive();
  }

  bool _notification = true;
  bool _isLoading = false;
  bool _isVerifyEmailLoading = false;
  bool _isVerifyOtpLoading = false;
  LoginModel? _loginModel;
  LoginModel? _forgetPassword;
  bool get notification => _notification;


  bool get isLoading => _isLoading;
  bool get isVerifyEmailLoading => _isVerifyEmailLoading;
  bool get isVerifyOtpLoading => _isVerifyOtpLoading;
  LoginModel? get loginModel => _loginModel;
  LoginModel? get forgetPassword => _forgetPassword;

  Future<LoginModel> login(String phone,String password,String loginwith) async {
    var fcmToken = await FirebaseMessaging.instance.getToken();
    print(fcmToken);

    String deviceId = await getUniqueDeviceId();
    print(deviceId);
    update();
    Response response = await authRepo.login(
      phone: phone,
      token: fcmToken,
      deviceId: deviceId,
      password: password,
      loginwith: loginwith,
    );
    // LoginModel loginModel;
    if (response.statusCode == 200) {
      _loginModel = LoginModel(response.body['success'], response.body['data']['user']['id'],
          '${response.body['message']}','${response.body['data']['token']}' );
    } else {
      _loginModel = LoginModel(response.body['success'], 0, '${response.body['message']}', '${response.body['token']}');
    }
    _isLoading = true;
    update();
    return _loginModel!;
  }

  Future<LoginModel> verifySMSOTP(String mobileNumber,String otp) async {

    Response response = await authRepo.verifySMSOTP(mobileNumber: mobileNumber,otp: otp);
    // LoginModel loginModel;
    if (response.statusCode == 200) {
      _forgetPassword = LoginModel(response.body['success'], response.body['data']['user']['id'], '${response.body['message']}','${response.body['data']['token']}' );
    } else {
      _forgetPassword = LoginModel(response.body['success'], 0, '${response.body['message']}', '${response.body['data']['token']}');
    }
    _isVerifyOtpLoading = true;
    update();
    return _forgetPassword!;
  }

  // Future<LoginModel> verifyEmail(String email,String mobileNo) async {
  //
  //   Response response = await authRepo.sendOTP(email: email,mobileNo: mobileNo);
  //   // LoginModel loginModel;
  //   if (response.statusCode == 200) {
  //     _forgetPassword = LoginModel(response.body['status'], 0, '${response.body['message']}', );
  //   } else {
  //     _forgetPassword = LoginModel(0, 0, '${response.body['message']}', );
  //   }
  //   _isVerifyEmailLoading = true;
  //   update();
  //   return _forgetPassword!;
  // }

  // Future<LoginModel> verifyOTP(String email,String otp) async {
  //
  //   Response response = await authRepo.verifyOTP(email: email,otp: otp);
  //   // LoginModel loginModel;
  //   if (response.statusCode == 200) {
  //     _forgetPassword = LoginModel(response.body['status'], response.body['user_id'], '${response.body['message']}', );
  //   } else {
  //     _forgetPassword = LoginModel(0, 0, '${response.body['message']}', );
  //   }
  //   _isVerifyOtpLoading = true;
  //   update();
  //   return _forgetPassword!;
  // }



  // Future<LoginModel> resetPassword(String userId,String password) async {
  //
  //   Response response = await authRepo.resetPassword(userId: userId,password: password);
  //   // LoginModel loginModel;
  //   if (response.statusCode == 200) {
  //     _loginModel = LoginModel(response.body['status'], response.body['id'],
  //         '${response.body['message']}', );
  //   } else {
  //     _loginModel = LoginModel(0, 0, '${response.body['message']}', );
  //   }
  //   _isLoading = true;
  //   update();
  //   return _loginModel!;
  // }

  String _verificationCode = '';

  String get verificationCode => _verificationCode;

  bool setNotificationActive(bool isActive) {
    _notification = isActive;
    authRepo.setNotificationActive(isActive);
    update();
    return _notification;
  }

  void saveUserNumber(
    String number,
  ) {
    authRepo.saveUserNumber(number.trim());
  }

  void saveUserToken(
      String userToken,
      ) {

    authRepo.saveUserToken(userToken.trim());
  }

  void saveNumberTemp(
      String number,
      ) {
    authRepo.saveNumberTemporary(number.trim());
  }

  void saveUserId(
    int id,
  ) {
    authRepo.saveUserId(id);
  }

  void saveReferalCode(String referalCode) {
    authRepo.saveReferalCode(referalCode);
  }

  String getReferalCode() {
    return authRepo.getReferalCode() ?? "";
  }

  Future<bool> removeTempNumber() {
    return authRepo.removeTempNumber();
  }

  int getUserId() {
    return authRepo.getUserId() ?? 0;
  }

  String getUserToken() {
    return authRepo.getUserToken() ?? "";
  }


  String getUserNumber() {
    return authRepo.getUserNumber() ?? "";
  }

  String getNumberTemporary() {
    return authRepo.getNumberTemporary() ?? "";
  }

  Future<bool> clearUserNumber() async {
    return authRepo.clearUserNumber();
  }

  Future<bool> clearUserToken() async {
    return authRepo.clearUserToken();
  }

  Future<String> getUniqueDeviceId() async {
    String uniqueDeviceId = '';

    var deviceInfo = DeviceInfoPlugin();

    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      uniqueDeviceId =
          '${iosDeviceInfo.name}:${iosDeviceInfo.identifierForVendor}'; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      uniqueDeviceId =
          '${androidDeviceInfo.model}:${androidDeviceInfo.id}'; // unique ID on Android
    }

    return uniqueDeviceId;
  }
}
