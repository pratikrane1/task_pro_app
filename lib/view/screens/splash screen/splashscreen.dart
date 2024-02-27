import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_pro/controller/auth_controller.dart';
import 'package:task_pro/helper/route_helper.dart';
import 'package:task_pro/util/images.dart';
import 'package:video_player/video_player.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  final int splashDuration = 7;
  VideoPlayerController? _controller;

  @override
  void initState() {
    // startTime();
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    videoController();
    startTime();
  }

  @override
  void dispose() {
    super.dispose();
    if (_controller != null) {
      _controller!.dispose();
      _controller = null;
    }
  }

  videoController(){
    _controller = VideoPlayerController.asset("assets/video/task_pro_splash.mp4")
      ..addListener(() => setState(() {}))
      ..setLooping(false)
      ..initialize().then((value) => _controller!.play());
  }

  _getVideoBackground() {
    return VideoPlayer(_controller!);
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

  // hello

  @override
  Widget build(BuildContext context) {
    // var height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Color(0xff000000),
        body: Center(
        child: _getVideoBackground(),


          // Container(
        //   decoration: const BoxDecoration(
        //     image: DecorationImage(
        //         image: AssetImage(Images.splashscreen), fit: BoxFit.fill
        //         // fit: BoxFit.cover,
        //         ),
        //   ),
        // ),
      )
      // Center(
      //   child: SizedBox(
      //     width: MediaQuery.of(context).size.width/2,
      //     child: Image.asset(
      //         Images.splashscreen,),
      //   ),
      // ),
    );
  }
}
