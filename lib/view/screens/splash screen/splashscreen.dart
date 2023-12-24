import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_pro/controller/auth_controller.dart';
import 'package:task_pro/helper/route_helper.dart';
import 'package:task_pro/util/images.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  final int splashDuration = 6;

  @override
  void initState() {
    // startTime();
    super.initState();
    startTime();
  }

  _route() {
    if (Get.find<AuthController>().getUserToken() != "") {
      Get.offNamed(RouteHelper.getInitialRoute(0.toString()));
    } else {
      Get.toNamed(RouteHelper.walkThrough);
    }
  }

  startTime() async {
    return Timer(await Duration(seconds: splashDuration), () {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      // Get.toNamed(RouteHelper.walkThrough);
      _route();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width/2,
          child: Image.asset(
              Images.splashscreen,),
        ),
      ),
    );
  }
}
