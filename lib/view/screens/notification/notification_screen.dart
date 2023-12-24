import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:task_pro/util/dimensions.dart';
import 'package:task_pro/util/images.dart';
import 'package:task_pro/util/theme_colors.dart';
import 'package:task_pro/view/base/custom_image.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // NotificationScreen({Key? key}) : super(key: key);
  String lastMessage = '';
  // List<NotificationModel>? _notificationList;
  bool _hasNotification = false;

  void initState() {
    // TODO: implement initState
    super.initState();
    // Get.find<NotificationController>().getNotificationList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // toolbarHeight: 100,
          backgroundColor: ThemeColors.secondaryColor,
          title: Text(
            'notification'.tr,
            style: GoogleFonts.inter(
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: IconButton(
            splashRadius: 20,
            onPressed: () async {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 24,
            ),
          ),
          centerTitle: false,
          elevation: 0.0,
          bottomOpacity: 0.0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(Images.notification_empty),
              Text(
                'No Notifications Yet'.tr,
                style: GoogleFonts.inter(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8),
              //   child: ListView.builder(
              //     primary: false,
              //     shrinkWrap: true,
              //     physics: const BouncingScrollPhysics(),
              //     itemCount: 10,
              //     itemBuilder: (context, index) {
              //       return Padding(
              //         padding: const EdgeInsets.all(5.0),
              //         child: Container(
              //           decoration: BoxDecoration(
              //             color: Theme.of(context).cardColor,
              //             borderRadius: BorderRadius.circular(15),
              //             boxShadow: const [
              //               BoxShadow(
              //                 color: ThemeColors.greyTextColor,
              //                 blurRadius: 3,
              //                 spreadRadius: 0.5,
              //               )
              //             ],
              //           ),
              //           child: Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Flexible(
              //                   child: Column(
              //                     children: [
              //                       RichText(
              //                         // maxLines: _notificationList![index]
              //                         //     .title!.length,
              //                         textAlign: TextAlign.start,
              //                         text: const TextSpan(
              //                           text: "Title",
              //                           style: TextStyle(
              //                               fontSize: 14,
              //                               fontFamily: 'Montserrat',
              //                               fontWeight: FontWeight.w600,
              //                               color: ThemeColors.blackColor
              //                           ),
              //                           children: <TextSpan>[
              //                             TextSpan(
              //                               text:  "12:00 am",
              //                               style: TextStyle(
              //                                 fontSize: 12,
              //                                 color: Colors.grey,
              //                               ),
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                       // _notificationList![index]
              //                       //     .body != null ?
              //                       const Padding(
              //                         padding: EdgeInsets.only(
              //                             top: 5.0),
              //                         child: Text(
              //                                 "body",
              //                             // maxLines:
              //                             // _notificationList![index]
              //                             //     .body!
              //                             //     .length,
              //                             style: TextStyle(
              //                                 fontSize: 12,
              //                                 fontFamily: 'Montserrat',
              //                                 fontWeight:
              //                                 FontWeight.w400,
              //                                 color: ThemeColors
              //                                     .blackColor)),
              //                       ),
              //                           // : Container(),
              //                     ],
              //                   ),
              //                 ),
              //                 // _notificationList![index].image != null ?
              //                 ClipRRect(
              //                   borderRadius:
              //                   BorderRadius.circular(
              //                       Dimensions
              //                           .RADIUS_SMALL),
              //                   child: CustomImage(
              //                     image:"",
              //                     // 'http://mone.ezii.live/uploads/products/coffee-mug_JCEKFWH9O7.webp',
              //                     height: 50,
              //                     width: 50,
              //                     fit: BoxFit.cover,
              //                   ),
              //                 ),
              //                     // : Container(),
              //               ],
              //             ),
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // )
            ],
          ),
        )
        // GetBuilder<NotificationController>(
        //     builder: (notificationController) {
        //       _notificationList = notificationController.notificationList;
        //       _hasNotification = notificationController.hasNotification;
        //       return _hasNotification
        //           ? _notificationList!.length != 0
        //           ? SingleChildScrollView(
        //         child: Column(
        //           children: [
        //             Padding(
        //               padding: const EdgeInsets.all(8),
        //               child: ListView.builder(
        //                 primary: false,
        //                 shrinkWrap: true,
        //                 physics: const BouncingScrollPhysics(),
        //                 itemCount: _notificationList!.length,
        //                 itemBuilder: (context, index) {
        //                   return Padding(
        //                     padding: const EdgeInsets.all(5.0),
        //                     child: Container(
        //                       decoration: BoxDecoration(
        //                         color: Theme.of(context).cardColor,
        //                         borderRadius: BorderRadius.circular(15),
        //                         boxShadow: const [
        //                           BoxShadow(
        //                             color: ThemeColors.greyTextColor,
        //                             blurRadius: 3,
        //                             spreadRadius: 0.5,
        //                           )
        //                         ],
        //                       ),
        //                       child: Padding(
        //                         padding: const EdgeInsets.all(8.0),
        //                         child: Row(
        //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                           children: [
        //                             Flexible(
        //                               child: Column(
        //                                 children: [
        //                                   RichText(
        //                                     maxLines: _notificationList![index]
        //                                         .title!.length,
        //                                     textAlign: TextAlign.start,
        //                                     text: TextSpan(
        //                                       text: "${
        //                                           _notificationList![index]
        //                                               .title
        //                                               .toString()
        //                                       } ",
        //                                       style: const TextStyle(
        //                                           fontSize: 14,
        //                                           fontFamily: 'Montserrat',
        //                                           fontWeight: FontWeight.w600,
        //                                           color: ThemeColors.blackColor
        //                                       ),
        //                                       children: <TextSpan>[
        //                                         TextSpan(
        //                                           text: _notificationList![
        //                                           index]
        //                                               .time ?? "",
        //                                           style: const TextStyle(
        //                                             fontSize: 12,
        //                                             color: Colors.grey,
        //                                           ),
        //                                         ),
        //                                       ],
        //                                     ),
        //                                   ),
        //                                   _notificationList![index]
        //                                       .body != null ?
        //                                   Padding(
        //                                     padding: const EdgeInsets.only(
        //                                         top: 5.0),
        //                                     child: Text(
        //                                         _notificationList![index]
        //                                             .body ??
        //                                             "",
        //                                         maxLines:
        //                                         _notificationList![index]
        //                                             .body!
        //                                             .length,
        //                                         style: const TextStyle(
        //                                             fontSize: 12,
        //                                             fontFamily: 'Montserrat',
        //                                             fontWeight:
        //                                             FontWeight.w400,
        //                                             color: ThemeColors
        //                                                 .blackColor)),
        //                                   ) : Container(),
        //                                 ],
        //                               ),
        //                             ),
        //                             _notificationList![index].image != null ?
        //                             ClipRRect(
        //                               borderRadius:
        //                               BorderRadius.circular(
        //                                   Dimensions
        //                                       .RADIUS_SMALL),
        //                               child: CustomImage(
        //                                 image:
        //                                 _notificationList![index].image,
        //                                 // 'http://mone.ezii.live/uploads/products/coffee-mug_JCEKFWH9O7.webp',
        //                                 height: 50,
        //                                 width: 50,
        //                                 fit: BoxFit.cover,
        //                               ),
        //                             ) : Container(),
        //                           ],
        //                         ),
        //                       ),
        //                     ),
        //                   );
        //                 },
        //               ),
        //             )
        //           ],
        //         ),
        //       )
        //           : Padding(
        //         padding: const EdgeInsets.only(top: 50.0),
        //         child: Column(
        //           // mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Center(
        //               child: Container(
        //                 height: 40,
        //                 width: 40,
        //                 decoration: BoxDecoration(
        //                   color: Colors.blue[100],
        //                   borderRadius: BorderRadius.circular(
        //                       Dimensions.RADIUS_DEFAULT),
        //                   boxShadow: const [
        //                     BoxShadow(
        //                       color: ThemeColors.greyTextColor,
        //                       blurRadius: 2,
        //                       spreadRadius: 0.1,
        //                     )
        //                   ],
        //                 ),
        //                 child: Icon(
        //                   Icons.notifications_none_rounded,
        //                   color: Colors.blue[900],
        //                 ),
        //               ),
        //             ),
        //             const SizedBox(
        //               height: 10,
        //             ),
        //             const Text(
        //               "No notifications yet",
        //               style: TextStyle(
        //                 fontSize: 20,
        //                 fontWeight: FontWeight.bold,
        //                 fontFamily: 'Montserrat',
        //               ),
        //             ),
        //             const SizedBox(
        //               height: 10,
        //             ),
        //             const Text(
        //               "You'll see useful information here soon.Stay tuned.",
        //               textAlign: TextAlign.center,
        //               style: TextStyle(
        //                 fontSize: 15,
        //                 fontWeight: FontWeight.w500,
        //                 fontFamily: 'Montserrat',
        //               ),
        //             ),
        //           ],
        //         ),
        //       )
        //           : NotificationShimmer();
        //     })
    );
  }
}

class NotificationShimmer extends StatelessWidget {
  const NotificationShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          scrollDirection: Axis.vertical,
          padding:
          const EdgeInsets.only(top: 10, bottom: 15, left: 10, right: 10),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                // height: MediaQuery.of(context).size.height*0.11,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: ListTile(
                        title: Container(
                            height: 10, width: 20, color: Colors.grey[300]),
                        subtitle: Container(
                            height: 10, width: 100, color: Colors.grey[300]),
                        trailing: Container(
                            height: 10, width: 30, color: Colors.grey[300]),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}