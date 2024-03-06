import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_pro/controller/auth_controller.dart';
import 'package:task_pro/util/constants.dart';
import 'package:task_pro/util/dimensions.dart';
import 'package:task_pro/util/theme_colors.dart';
import 'package:task_pro/view/base/app_button.dart';
import 'package:task_pro/view/base/custom_snackbar.dart';
import 'package:task_pro/view/screens/authentication/login_with_otp_screen.dart';
import 'package:task_pro/view/screens/bottom%20navigation/bottom_nav_bar.dart';
import 'package:sms_autofill/sms_autofill.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = false;
  final formKey = GlobalKey<FormState>();
  String? phone;
  String authStatus = "";
  bool loading = true;
  var verificationId;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    Future<void>.delayed(
        const Duration(milliseconds: 300), _tryPasteCurrentPhone);
    if (Get.find<AuthController>().getNumberTemporary() != "") {
      phoneController.text = Get.find<AuthController>().getNumberTemporary();
    }
  }

  Future _tryPasteCurrentPhone() async {
    if (!mounted) return;
    try {
      final autoFill = SmsAutoFill();
      final phone = await autoFill.hint;
      if (phone == null) return;
      if (!mounted) return;
      phoneController.text = phone;
    } on PlatformException catch (e) {
      print('Failed to get mobile number because of: ${e.message}');
    }
  }

  @override
  void dispose() {
    // SmsAutoFill().unregisterListener();
    super.dispose();
    phoneController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ThemeColors.secondaryColor,
      body: GetBuilder<AuthController>(builder: (authController) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    "login".tr,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: Dimensions.fontSizeOverLarge,
                      fontWeight: FontWeight.w600,
                      color: ThemeColors.whiteColor,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    "login_with_mobile_number".tr,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: Dimensions.fontSizeDefault,
                      fontWeight: FontWeight.w500,
                      color: ThemeColors.greyTextColor,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),

                  Text(
                    "mobile_no".tr,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: Dimensions.fontSizeDefault,
                      fontWeight: FontWeight.w500,
                      color: ThemeColors.whiteColor,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  ///Mobile number field
                  TextFormField(
                    scrollPadding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    controller: phoneController,
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.top,
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: ThemeColors.blackColor,
                          fontSize: 20,
                        ),
                    cursorColor: kOrangeColor,
                    autofocus: false,
                    autocorrect: false,
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      fillColor: ThemeColors.whiteColor,
                      filled: true,
                      hintText: 'enter_mobile_number'.tr,
                      hintStyle: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 17,
                          color: ThemeColors.greyTextColor),
                      focusedErrorBorder: kFocusedErrorBorder,
                      errorBorder: kErrorBorder,
                      enabledBorder: kEnabledBorder,
                      focusedBorder: kFocusedBorder,
                      border: kBorder,
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'phone_number_required'.tr;
                      }
                      return null;
                    },
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  Text(
                    "password".tr,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: Dimensions.fontSizeDefault,
                      fontWeight: FontWeight.w500,
                      color: ThemeColors.whiteColor,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  ///Password field
                  TextFormField(
                    obscureText: !_passwordVisible,
                    scrollPadding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    controller: passwordController,
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.top,
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: ThemeColors.blackColor,
                          fontSize: 20,
                        ),
                    cursorColor: kOrangeColor,
                    autofocus: false,
                    autocorrect: false,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      fillColor: ThemeColors.whiteColor,
                      filled: true,
                      hintText: 'enter_password'.tr,
                      hintStyle: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 17,
                          color: ThemeColors.greyTextColor),
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: ThemeColors.greyTextColor,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      focusedErrorBorder: kFocusedErrorBorder,
                      errorBorder: kErrorBorder,
                      enabledBorder: kEnabledBorder,
                      focusedBorder: kFocusedBorder,
                      border: kBorder,
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'password_required'.tr;
                      }
                      return null;
                    },
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  InkWell(
                    onTap: (){
                      Get.to(const LoginWithOTPScreen());
                    },
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text("login_with_otp".tr,
                        textAlign: TextAlign.right,
                        style: GoogleFonts.inter(
                          fontSize: Dimensions.fontSizeDefault,
                          fontWeight: FontWeight.w500,
                          color: ThemeColors.whiteColor,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 30.0, bottom: 10),
                    child: AppButton(
                      onPressed: () async {
                        // Get.offNamed(RouteHelper.getOtpVerifyRoute(
                        //     phoneController.text.trim(), '+91', ''));

                        if (formKey.currentState!.validate()) {
                          if (phoneController.text != null) {
                            // String? num = phoneController.text.trim();
                            phone = phoneController.text.trim();
                            // phone = num.substring(num.length - 10);
                          }
                          if (phone!.length < 10) {
                            showCustomSnackBar(
                                'please_enter_10_digit_number'.tr);
                          } else if (phone!.length > 13) {
                            showCustomSnackBar('please_enter_valid_number'.tr);
                          } else if (phone!.isEmpty) {
                            showCustomSnackBar('please_enter_phone_number'.tr);
                          } else if (passwordController.text == "") {
                            showCustomSnackBar('please_enter_password'.tr);
                          } else if (phoneController.text.trim() != null) {
                            FocusScopeNode currentfocus =
                                FocusScope.of(context);
                            if (!currentfocus.hasPrimaryFocus) {
                              currentfocus.unfocus();
                            }

                            if (phoneController.text.length > 10) {
                              String? num = phoneController.text.trim();
                              phone = num.substring((num.length - 10));
                              print(phone);
                            }
                            _login(authController, phoneController.text.trim());

                            setState(() {
                              loading = false;
                            });
                          }
                        }
                      },
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      text: Text(
                        'login'.tr,
                        style: GoogleFonts.inter(
                            color: ThemeColors.whiteColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      loading: loading,
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(
                            color: ThemeColors.primaryColor, width: 1),
                        backgroundColor: ThemeColors.primaryColor,
                        // color:Colors.red,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                      ),
                    ),
                  ),

                  // Align(
                  //   alignment: Alignment.bottomCenter,
                  //   child: Text(
                  //     "${"forget_password".tr}?",
                  //     textAlign: TextAlign.center,
                  //     style: GoogleFonts.inter(
                  //       fontSize: Dimensions.fontSizeDefault,
                  //       fontWeight: FontWeight.w500,
                  //       color: ThemeColors.whiteColor,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  void _login(AuthController authController, String number) async {
    String _numberWithCountryCode =
        number.length > 10 ? number : "${'+91' + number}";
    // String _numberWithCountryCode = number;

    var logData = await authController
        .login(_numberWithCountryCode, passwordController.text.trim(), "0")
        .then((status) async {
      if (status.status == true) {
        authController.saveUserToken(
            Get.find<AuthController>().loginModel!.userToken.toString());
        authController.saveUserNumber(number.trim());
        authController
            .saveUserId(Get.find<AuthController>().loginModel!.id!.toInt());
        // authController.saveUserId(85);
        showCustomSnackBar(status.message!, isError: false);
        Get.find<AuthController>().setNotificationActive(true);
        // Timer(await Duration(seconds: 5), () {
          Get.offAll(BottomNavigation(index: 0));
        // });
      } else {
        showCustomSnackBar(status.message!, isError: true);
        // authController.saveUserNumber(number.trim());
        // authController.saveUserId(1);
        // Get.offAll(WelcomeScreen());
        authController.clearUserNumber();
      }
      loading = authController.isLoading;
    });
    print(logData);
  }
}
