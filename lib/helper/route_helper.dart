import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_pro/view/screens/authentication/login_screen.dart';
import 'package:task_pro/view/screens/authentication/login_with_otp_screen.dart';
import 'package:task_pro/view/screens/bottom%20navigation/bottom_nav_bar.dart';
import 'package:task_pro/view/screens/splash%20screen/splashscreen.dart';
import 'package:task_pro/view/screens/walkthrough/walkthrough_screen.dart';

class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String walkThrough = '/walkThrough';
  static const String login = '/login';
  static const String loginOTP = '/loginOTP';
  static const String otpVerify = '/otpVerify';


  static String getInitialRoute(String index) => '$initial?index=$index';
  static String getSplashRoute(String title) {
    return '$splash?title=$title';
  }

  static String getWalkThroughRoute() => '$walkThrough';
  static String getLoginRoute() {
    return '$login';
  }
  static String getLoginOTPRoute() {
    return '$loginOTP';
  }

  static String getOtpVerifyRoute(
    String number,
    String countryCode,
    String token,
  ) {
    return '$otpVerify?number=$number&country_code=$countryCode&token=$token';
  }



  static List<GetPage> routes = [
    GetPage(
        name: splash,
        page: () {
          return const Splashscreen();
        }),
    GetPage(
        name: initial,
        page: () => getRoute(BottomNavigation(index: 0))),
    GetPage(
        name: walkThrough,
        page: () {
          return const WalkThroughScreen();
        }),
    GetPage(
        name: login,
        page: () {
          return const LoginScreen();
        }),
    GetPage(
        name: loginOTP,
        page: () {
          return const LoginWithOTPScreen();
        }),
  ];

  static getRoute(Widget navigateTo) {
    return navigateTo;
  }
}
