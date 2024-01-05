import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:task_pro/data/model/task_model.dart';
import 'package:task_pro/util/images.dart';
import 'package:task_pro/util/theme_colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  VideoScreen({Key? key, required this.videoData}) : super(key: key);
  HowToVideo videoData;


  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  TargetPlatform? _platform;


  YoutubePlayerController? _ytbPlayerController;
  PageController? _pageController;
  int activePage = 1;
  bool _fullScreen = false;
  String? videoId = "";
  String? descriptionText = "Description: Welcome to the world of Destek Infosolutions Private Limited, a trailblazing IT services and products company that is revolutionizing businesses through digital transformation. With an extensive portfolio of successful projects and a talented team of over 250 experts, Destek is at the forefront of driving innovation and reshaping the way organizations harness the power of technology.Join us on an awe-inspiring journey as we unveil the exceptional story of Destek, showcasing our unwavering commitment to empowering businesses worldwide. From E-commerce to Robotics, LegalTech to Media & Entertainment, our diverse range of offerings caters to a wide array of industries, bringing cutting-edge solutions to fuel growth and success.Explore our remarkable partnerships, renowned clientele, and groundbreaking products such as Elektrify, a game-changing EV charging solution that is shaping the future of sustainable transportation.Discover how Destek is paving the way for the future of IT services, enabling businesses to thrive in the digital era. Immerse yourself in our world of innovation, expertise, and transformation.Join us today and unlock the power of digital transformation with Destek Pro!";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        videoId =  widget.videoData.videoUrl;
        // videoId =  "GDtLnG-qzMU";
        _ytbPlayerController = YoutubePlayerController(
          // initialVideoId: "xcJtL7QggTI",
          initialVideoId: videoId.toString(),
          flags: const YoutubePlayerFlags(
            autoPlay: true,
            mute: false,
            controlsVisibleAtStart: true,
          ),
        )..addListener(listener);
      });
    });
  }

  void listener() {
    setState(() {
      _fullScreen = _ytbPlayerController!.value.isFullScreen;
    });
  }

  void dispose(){
    super.dispose();
    _ytbPlayerController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitUp, DeviceOrientation.portraitUp]);
        return true;
      },
      child: Scaffold(
        appBar: _fullScreen
            ? null
            : AppBar(
                backgroundColor: ThemeColors.whiteColor,
                leading: IconButton(
                  splashRadius: 20,
                  onPressed: () async {
                    // Get.back();
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 24,
                  ),
                ),
                title: Text(
                  'video_screen'.tr,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                      ),
                ),
                centerTitle: false,
                elevation: 4.0,
                bottomOpacity: 0.0,
              ),
        body: _ytbPlayerController != null
            ? _fullScreen ?
        YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: _ytbPlayerController!,
            showVideoProgressIndicator: true,
          ),
          builder: (context, player) {
            return player;
          },
        ):ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  YoutubePlayerBuilder(
                    player: YoutubePlayer(
                      controller: _ytbPlayerController!,
                      showVideoProgressIndicator: true,
                    ),
                    builder: (context, player) {
                      return player;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      ],
                    ),
                  ),
                  _fullScreen
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.videoData.title ?? "",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                  _fullScreen
                      ? Container()
                      : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.videoData.descirption ?? "",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                ],
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
