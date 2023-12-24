import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:task_pro/controller/task_controller.dart';
import 'package:task_pro/data/model/all_task_model.dart';
import 'package:task_pro/util/dimensions.dart';
import 'package:task_pro/util/theme_colors.dart';
import 'package:intl/intl.dart';
import 'package:task_pro/view/base/empty_card_widget.dart';
import 'package:task_pro/view/screens/task/task_screen.dart';

class AllTaskWidget extends StatefulWidget {
  const AllTaskWidget({super.key});

  @override
  State<AllTaskWidget> createState() => _AllTaskWidgetState();
}

class _AllTaskWidgetState extends State<AllTaskWidget> {
  List<AllTaskModel>? _allTaskList;
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    Get.find<TaskController>().getAllTask("");
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskController>(builder: (taskController) {
      _allTaskList = taskController.allTaskList;
      _isLoading = taskController.isGetAllTaskLoading;
        return Container(
          // color: ThemeColors.secondaryColor,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [360 / 600, 200 / 600, 1],
              colors: [ThemeColors.secondaryColor, Colors.transparent, Colors.transparent],
            ),
          ),
          child: Column(
            children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0,right: 14.0,left: 15.0,bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('all_task'.tr,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: Dimensions.fontSizeExtraLarge,
                          fontWeight: FontWeight.w600,
                          color: ThemeColors.whiteColor,
                        ),
                      ),

                      // const Icon(Icons.more_horiz,color: ThemeColors.whiteColor,)

                    ],
                  ),
                ),

              _isLoading ? _allTaskList!.isNotEmpty ?
              // CarouselSlider.builder(
              //   options: CarouselOptions(
              //     enableInfiniteScroll: false,
              //     autoPlay: false,
              //     enlargeCenterPage: false,
              //     disableCenter: false,
              //     viewportFraction: 0.5,
              //     autoPlayInterval: const Duration(seconds: 7),
              //     onPageChanged: (index, reason) {
              //       // bannerController.setCurrentIndex(index, true);
              //     },
              //   ),
              //   itemCount: _allTaskList!.length,
              //   itemBuilder: (context, index, _) {
              //     return InkWell(
              //       onTap: () {},
              //       child: Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Container(
              //           decoration: BoxDecoration(
              //             color: index == 0 ? ThemeColors.card1Color : index == 1 ? ThemeColors.card2Color : index == 2 ? ThemeColors.card3Color : Theme.of(context).cardColor,
              //             borderRadius: BorderRadius.circular(
              //                 Dimensions.RADIUS_EXTRA_LARGE),
              //             boxShadow: const [
              //               // BoxShadow(
              //               //   color: ThemeColors.greyTextColor,
              //               //   blurRadius: 2,
              //               //   spreadRadius: 0.3,
              //               // )
              //             ],
              //           ),
              //           child: Padding(
              //             padding: const EdgeInsets.only(top: 12.0,left: 19.0,right: 10.0),
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Text(DateFormat("d\nMMMM").format(DateTime.parse(_allTaskList![index].assignedAt.toString())),
              //                   textAlign: TextAlign.start,
              //                   style: GoogleFonts.inter(
              //                     fontSize: Dimensions.fontSizeOverLarge,
              //                     fontWeight: FontWeight.w700,
              //                     color: ThemeColors.blackColor,
              //                   ),
              //                 ),
              //
              //                 const SizedBox(height: 5,),
              //
              //                 Text('${_allTaskList![index].completedTask}/${_allTaskList![index].taskList!.length} Task'.tr,
              //                   textAlign: TextAlign.center,
              //                   style: GoogleFonts.inter(
              //                     fontSize: Dimensions.fontSizeExtraLarge,
              //                     fontWeight: FontWeight.w500,
              //                     color: ThemeColors.blackColor,
              //                   ),
              //                 ),
              //
              //                 const SizedBox(height: 5,),
              //
              //                 Row(
              //                   children: [
              //                     Transform.translate(
              //                       offset: const Offset(-10,0),
              //                       child: LinearPercentIndicator(
              //                         width: MediaQuery.of(context).size.width/3,
              //                         barRadius: const Radius.circular(20),
              //                         restartAnimation: true,
              //                         lineHeight: 10.0,
              //                         percent: double.parse(_allTaskList![index].taskProgress.toString()) ,
              //                         backgroundColor: Colors.white,
              //                         progressColor: Colors.blue,
              //                       ),
              //                     ),
              //                     _allTaskList![index].taskProgress == "1" ? const Icon(CupertinoIcons.heart_fill,
              //                       color: ThemeColors.redColor,
              //                       size: 15,) : const Icon(Icons.electric_bolt,
              //                       color: ThemeColors.orangeColor,
              //                       size: 15,),
              //                   ],
              //                 ),
              //
              //                 Text('Open for Today'.tr,
              //                   textAlign: TextAlign.center,
              //                   style: GoogleFonts.inter(
              //                     fontSize: Dimensions.fontSizeDefault,
              //                     fontWeight: FontWeight.w500,
              //                     color: ThemeColors.greyTextColor,
              //                   ),
              //                 ),
              //
              //                 const SizedBox(height: 10,),
              //
              //                 Row(
              //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                   children: [
              //                     Text('more_info'.tr,
              //                       textAlign: TextAlign.center,
              //                       style: GoogleFonts.inter(
              //                         fontSize: Dimensions.fontSizeLarge,
              //                         fontWeight: FontWeight.w600,
              //                         color: ThemeColors.blackColor,
              //                       ),
              //                     ),
              //                     InkWell(
              //                       // onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context)=>TaskScreen(assignTaskDate: _allTaskList![index].assignedAt.toString(),))),
              //                       onTap:() => Get.to(()=>TaskScreen(assignTaskDate: _allTaskList![index].assignedAt.toString(),)),
              //
              //                       child: Container(
              //                           decoration: BoxDecoration(
              //                             color: Theme.of(context).cardColor,
              //                             borderRadius: BorderRadius.circular(
              //                                 Dimensions.RADIUS_SMALL),
              //                             boxShadow: const [
              //                               // BoxShadow(
              //                               //   color: ThemeColors.greyTextColor,
              //                               //   blurRadius: 2,
              //                               //   spreadRadius: 0.3,
              //                               // )
              //                             ],
              //                           ),
              //                           child: const Padding(
              //                             padding: EdgeInsets.all(3.0),
              //                             child: Icon(Icons.arrow_forward,color: Color(
              //                                 0xFF756B7B),),
              //                           )),
              //                     )
              //                   ],
              //                 )
              //               ],
              //             ),
              //           ),
              //         ),
              //       )
              //     );
              //   },
              // )
              SizedBox(
                height: 210,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  // padding: const EdgeInsets.only(
                  //     top: 10, bottom: 15, left: 0, right: 10),
                  itemCount: _allTaskList!.length,
                  itemBuilder: (context, index,) {
                    return InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          // height: 100,
                          decoration: BoxDecoration(
                            color: index == 0 ? ThemeColors.card1Color : index == 1 ? ThemeColors.card2Color : index == 2 ? ThemeColors.card3Color : Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(
                                Dimensions.RADIUS_EXTRA_LARGE),
                            boxShadow: const [
                              // BoxShadow(
                              //   color: ThemeColors.greyTextColor,
                              //   blurRadius: 2,
                              //   spreadRadius: 0.3,
                              // )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12.0,left: 19.0,right: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(DateFormat("d\nMMMM").format(DateTime.parse(_allTaskList![index].assignedAt.toString())),
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.inter(
                                    fontSize: Dimensions.fontSizeOverLarge,
                                    fontWeight: FontWeight.w700,
                                    color: ThemeColors.blackColor,
                                  ),
                                ),

                                const SizedBox(height: 5,),

                                Text('${_allTaskList![index].completedTask}/${_allTaskList![index].taskList!.length} Task'.tr,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                    fontSize: Dimensions.fontSizeExtraLarge,
                                    fontWeight: FontWeight.w500,
                                    color: ThemeColors.blackColor,
                                  ),
                                ),

                                const SizedBox(height: 5,),

                                Row(
                                  children: [
                                    Transform.translate(
                                      offset: const Offset(-10,0),
                                      child: LinearPercentIndicator(
                                        width: MediaQuery.of(context).size.width/3,
                                        barRadius: const Radius.circular(20),
                                        restartAnimation: true,
                                        lineHeight: 10.0,
                                        percent: double.parse(_allTaskList![index].taskProgress.toString()) ,
                                        backgroundColor: Colors.white,
                                        progressColor: Colors.blue,
                                      ),
                                    ),
                                    _allTaskList![index].taskProgress == "1" ? const Icon(CupertinoIcons.heart_fill,
                                      color: ThemeColors.redColor,
                                      size: 15,) : const Icon(Icons.electric_bolt,
                                      color: ThemeColors.orangeColor,
                                      size: 15,),
                                  ],
                                ),

                                (DateFormat("d\nMMMM").format(DateTime.parse(_allTaskList![index].assignedAt.toString())) == DateFormat("d\nMMMM").format(DateTime.now())) ?
                                Text('Open for Today'.tr,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                    fontSize: Dimensions.fontSizeDefault,
                                    fontWeight: FontWeight.w500,
                                    color: ThemeColors.greyTextColor,
                                  ),
                                ): Text( "Closed",
                                  style: GoogleFonts.inter(
                                    color: ThemeColors.redColor,
                                    fontSize: Dimensions.fontSizeDefault,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ) ,

                                const SizedBox(height: 10,),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('more_info'.tr,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.inter(
                                        fontSize: Dimensions.fontSizeLarge,
                                        fontWeight: FontWeight.w600,
                                        color: ThemeColors.blackColor,
                                      ),
                                    ),
                                    const SizedBox(width: 30.0,),
                                    InkWell(
                                      // onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context)=>TaskScreen(assignTaskDate: _allTaskList![index].assignedAt.toString(),))),
                                      onTap:() => (DateFormat("d\nMMMM").format(DateTime.parse(_allTaskList![index].assignedAt.toString())) == DateFormat("d\nMMMM").format(DateTime.now())) ?
                                                  Get.to(()=>TaskScreen(assignTaskDate: _allTaskList![index].assignedAt.toString(),)) : null,

                                      child: Container(
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).cardColor,
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.RADIUS_SMALL),
                                            boxShadow: const [
                                              // BoxShadow(
                                              //   color: ThemeColors.greyTextColor,
                                              //   blurRadius: 2,
                                              //   spreadRadius: 0.3,
                                              // )
                                            ],
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(3.0),
                                            child: Icon(Icons.arrow_forward,color: Color(
                                                0xFF756B7B),),
                                          )),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    );
                  },
                ),
              )
                  : const AllTaskEmptyWidget() : allTaskShimmer()
            ],
          ),
        );
      }
    );
  }
}

Widget allTaskShimmer(){
  return CarouselSlider.builder(
    options: CarouselOptions(
      autoPlay: false,
      enlargeCenterPage: false,
      disableCenter: true,
      viewportFraction: 0.5,
      autoPlayInterval: Duration(seconds: 7),
      onPageChanged: (index, reason) {
        // bannerController.setCurrentIndex(index, true);
      },
    ),
    itemCount: 3,
    itemBuilder: (context, index, _) {
      return InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color:  Colors.grey[300],
                borderRadius: BorderRadius.circular(
                    Dimensions.RADIUS_EXTRA_LARGE),
                boxShadow: const [
                  BoxShadow(
                    color: ThemeColors.greyTextColor,
                    blurRadius: 2,
                    spreadRadius: 0.3,
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Shimmer(
                  colorOpacity: 0.8,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12.0,left: 19.0,right: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: 15,
                            width: 100,
                            color: Colors.grey),

                        const SizedBox(height: 20,),

                        Container(
                            height: 15,
                            width: 80,
                            color: Colors.grey),
                        const SizedBox(height: 15,),

                        Row(
                          children: [
                            Transform.translate(
                              offset: const Offset(-10,0),
                              child: LinearPercentIndicator(
                                width: MediaQuery.of(context).size.width/3,
                                barRadius: const Radius.circular(20),
                                restartAnimation: true,
                                lineHeight: 10.0,
                                percent: double.parse("0.0") ,
                                backgroundColor: Colors.white,
                                progressColor: Colors.blue,
                              ),
                            ),
                            const Icon(Icons.electric_bolt,
                              color: ThemeColors.greyTextColor,
                              size: 15,),
                          ],
                        ),

                        const SizedBox(height: 15.0,),

                        Container(
                            height: 10,
                            width: 100,
                            color: Colors.grey),

                        const SizedBox(height: 10,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                height: 12,
                                width: 80,
                                color: Colors.grey),

                            InkWell(
                              // onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context)=>TaskScreen(assignTaskDate: _allTaskList![index].assignedAt.toString(),))),

                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.RADIUS_SMALL),
                                    boxShadow: const [
                                      // BoxShadow(
                                      //   color: ThemeColors.greyTextColor,
                                      //   blurRadius: 2,
                                      //   spreadRadius: 0.3,
                                      // )
                                    ],
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(3.0),
                                    child: Icon(Icons.arrow_forward,color: Color(
                                        0xFF756B7B),),
                                  )),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
      );
    },
  );
}