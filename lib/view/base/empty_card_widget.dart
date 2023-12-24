import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:task_pro/util/dimensions.dart';
import 'package:task_pro/util/theme_colors.dart';
import 'package:intl/intl.dart';

class AllTaskEmptyWidget extends StatelessWidget {
  const AllTaskEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        scrollDirection: Axis.horizontal,
        // padding: const EdgeInsets.only(
        //     top: 10, bottom: 15, left: 0, right: 10),
        itemCount: 3,
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
                        Text(DateFormat("d\nMMMM").format(DateTime.now()),
                          textAlign: TextAlign.start,
                          style: GoogleFonts.inter(
                            fontSize: Dimensions.fontSizeOverLarge,
                            fontWeight: FontWeight.w700,
                            color: ThemeColors.blackColor,
                          ),
                        ),

                        const SizedBox(height: 15,),

                        Row(
                          children: [
                            const Icon(Icons.lock_outline_sharp,
                            size: 20),
                            Text('Task Live Soon'.tr,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: Dimensions.fontSizeLarge,
                                fontWeight: FontWeight.w500,
                                color: ThemeColors.blackColor,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20,),

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
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFF3F3849),
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
                                        0xFFFFC6BC),),
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
    );
  }
}


class TodayTaskEmptyCardWidget extends StatelessWidget {
  const TodayTaskEmptyCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    Text(DateFormat("d MMMM").format(DateTime.now()),
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
                            percent: 0.0,
                            backgroundColor: const Color(0xFFF9C594),
                            progressColor: Colors.white,
                          ),
                        ),

                        Text('0%'.tr,
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Locked'.tr,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: Dimensions.fontSizeLarge,
                                  fontWeight: FontWeight.w500,
                                  color: ThemeColors.blackColor,
                                ),
                              ),
                              const SizedBox(height: 10,),
                              const Icon(Icons.lock_outline_sharp,color: ThemeColors.blackColor,size: 20,)
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
    );
  }
}

