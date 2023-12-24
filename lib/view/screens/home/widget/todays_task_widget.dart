import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:task_pro/controller/task_controller.dart';
import 'package:task_pro/data/model/all_task_model.dart';
import 'package:task_pro/util/dimensions.dart';
import 'package:task_pro/util/theme_colors.dart';
import 'package:task_pro/view/base/empty_card_widget.dart';
import 'package:task_pro/view/screens/task/task_screen.dart';
import 'package:intl/intl.dart';

class TodaysTaskWidget extends StatefulWidget {
  const TodaysTaskWidget({super.key});

  @override
  State<TodaysTaskWidget> createState() => _TodaysTaskWidgetState();
}

class _TodaysTaskWidgetState extends State<TodaysTaskWidget> {
  List<AllTaskModel>? _allTaskList;
  bool _isLoading = false;
  double? percentage;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskController>(builder: (taskController) {
      _allTaskList = taskController.allTaskList;
      _isLoading = taskController.isGetAllTaskLoading;
      if(_allTaskList!.isNotEmpty) {
        percentage = (_allTaskList![0].completedTask! /
            (_allTaskList![0].completedTask! +
                _allTaskList![0].inCompletedTask!) *
            100);
      }
      return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0,right: 14.0,left: 15.0,bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('todays_task'.tr,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: Dimensions.fontSizeExtraLarge,
                      fontWeight: FontWeight.w600,
                      color: ThemeColors.blackColor,
                    ),
                  ),

                  // Text('see_more'.tr,
                  //   textAlign: TextAlign.center,
                  //   style: GoogleFonts.inter(
                  //     fontSize: Dimensions.fontSizeDefault,
                  //     fontWeight: FontWeight.w600,
                  //     color: ThemeColors.blackColor,
                  //   ),
                  // ),
                ],
              ),
            ),

            _isLoading ? _allTaskList!.isNotEmpty ?  Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: ThemeColors.todaysTaskCardColor,
                  borderRadius: BorderRadius.circular(
                      Dimensions.RADIUS_EXTRA_LARGE),
                  boxShadow: const [
                    BoxShadow(
                      // color: ThemeColors.greyTextColor,
                      // blurRadius: 2,
                      // spreadRadius: 0.3,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(DateFormat("d MMMM").format(DateTime.parse(_allTaskList![0].assignedAt.toString())),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: Dimensions.fontSizeOverLarge,
                                fontWeight: FontWeight.w700,
                                color: ThemeColors.blackColor,
                              ),
                            ),
                            const SizedBox(height: 10.0,),
                            Text('Hurry Up!!!'.tr,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: Dimensions.fontSizeExtraLarge,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFCE8440),
                              ),
                            ),
                            const SizedBox(height: 10.0,),

                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Transform.translate(
                                  offset: const Offset(-8,0),
                                  child: LinearPercentIndicator(
                                    width: MediaQuery.of(context).size.width/2,
                                    barRadius: const Radius.circular(20),
                                    restartAnimation: true,
                                    lineHeight: 14.0,
                                    percent: double.parse(_allTaskList![0].taskProgress.toString()),
                                    backgroundColor: const Color(0xFFF9C594),
                                    progressColor: Colors.white,
                                  ),
                                ),

                                Text('${percentage!.toStringAsFixed(0)}%'.tr,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                    fontSize: Dimensions.fontSizeExtraLarge,
                                    fontWeight: FontWeight.w600,
                                    color: ThemeColors.blackColor,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10.0,),

                            Container(
                              width: MediaQuery.of(context).size.width/3,
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
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
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  // onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context)=>TaskScreen(assignTaskDate: _allTaskList![0].assignedAt.toString(),))),
                                  onTap:() => Get.to(()=>TaskScreen(assignTaskDate: _allTaskList![0].assignedAt.toString(),)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('open_task'.tr,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.inter(
                                          fontSize: Dimensions.fontSizeLarge,
                                          fontWeight: FontWeight.w500,
                                          color: ThemeColors.blackColor,
                                        ),
                                      ),
                                      const SizedBox(height: 10,),
                                      const Icon(Icons.arrow_forward,color: ThemeColors.blackColor,size: 20,)
                                    ],
                                  ),
                                ),
                              ),
                            )


                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(
                              Dimensions.RADIUS_EXTRA_EXTRA_LARGE),
                          boxShadow: const [
                            // BoxShadow(
                            //   color: ThemeColors.greyTextColor,
                            //   blurRadius: 2,
                            //   spreadRadius: 0.3,
                            // )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                width: 30,height: 30,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF9C594),
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.RADIUS_EXTRA_EXTRA_LARGE),
                                  boxShadow: const [
                                    // BoxShadow(
                                    //   color: ThemeColors.greyTextColor,
                                    //   blurRadius: 2,
                                    //   spreadRadius: 0.3,
                                    // )
                                  ],
                                ),
                                child: Center(
                                  child: Text('1'.tr,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                      fontSize: Dimensions.fontSizeExtraLarge,
                                      fontWeight: FontWeight.w700,
                                      color: ThemeColors.blackColor,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Container(
                                width: 30,height: 30,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF9C594),
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.RADIUS_EXTRA_EXTRA_LARGE),
                                  boxShadow: const [
                                    // BoxShadow(
                                    //   color: ThemeColors.greyTextColor,
                                    //   blurRadius: 2,
                                    //   spreadRadius: 0.3,
                                    // )
                                  ],
                                ),
                                child: Center(
                                  // padding: const EdgeInsets.all(8.0),
                                  child: Text('2'.tr,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                      fontSize: Dimensions.fontSizeExtraLarge,
                                      fontWeight: FontWeight.w700,
                                      color: ThemeColors.blackColor,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Container(
                                width: 30,height: 30,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF9C594),
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.RADIUS_EXTRA_EXTRA_LARGE),
                                  boxShadow: const [
                                    // BoxShadow(
                                    //   color: ThemeColors.greyTextColor,
                                    //   blurRadius: 2,
                                    //   spreadRadius: 0.3,
                                    // )
                                  ],
                                ),
                                child: Center(
                                  // padding: const EdgeInsets.all(8.0),
                                  child: Text('3'.tr,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                      fontSize: Dimensions.fontSizeExtraLarge,
                                      fontWeight: FontWeight.w700,
                                      color: ThemeColors.blackColor,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Container(
                                width: 30,height: 30,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.RADIUS_EXTRA_EXTRA_LARGE),
                                  boxShadow: const [
                                    // BoxShadow(
                                    //   color: ThemeColors.greyTextColor,
                                    //   blurRadius: 2,
                                    //   spreadRadius: 0.3,
                                    // )
                                  ],
                                ),
                                child: const Center(
                                  // padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.electric_bolt,
                                    color: Colors.amber,size: 20,)
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ) : const TodayTaskEmptyCardWidget() : todaysCardShimmer()

          ],
        );
      }
    );
  }
}

Widget todaysCardShimmer(){
  return Shimmer(
    // duration: Duration(seconds: 2),
    colorOpacity: 0.8,
    enabled: true,
    child: Container(
        height: 200,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(Dimensions.RADIUS_SMALL),
          color: Colors.grey[300],
        )),
  );
}