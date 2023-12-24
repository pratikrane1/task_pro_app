import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_pro/controller/rewards_controller.dart';
import 'package:task_pro/controller/task_controller.dart';
import 'package:task_pro/data/model/all_task_model.dart';
import 'package:task_pro/data/model/rewards_model.dart';
import 'package:task_pro/util/dimensions.dart';
import 'package:task_pro/util/images.dart';
import 'package:task_pro/util/theme_colors.dart';
import 'package:task_pro/view/base/empty_card_widget.dart';
import 'package:task_pro/view/screens/bottom%20navigation/bottom_nav_bar.dart';
import 'package:task_pro/view/screens/home/widget/todays_task_widget.dart';
import 'package:task_pro/view/screens/rewards/rewards_screen.dart';

class PayoutWidget extends StatefulWidget {
  const PayoutWidget({super.key});

  @override
  State<PayoutWidget> createState() => _PayoutWidgetState();
}

class _PayoutWidgetState extends State<PayoutWidget> {
  RewardsModel? _dashPayoutData;
  bool _isLoading = false;
  double? percentage;

  @override
  void initState(){
    super.initState();
    Get.find<RewardsController>().getTodaysPayoutData();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RewardsController>(builder: (rewardsController) {
      _dashPayoutData = rewardsController.dashPayoutData;
      _isLoading = rewardsController.isTodaysPayoutLoading;
      return Column(
        children: [
          _isLoading ? _dashPayoutData != null ?  Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: ThemeColors.todaysPayoutCardColor,
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
                          Row(
                            children: [
                              Text("Pay Out",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: Dimensions.fontSizeOverLarge,
                                  fontWeight: FontWeight.w700,
                                  color: ThemeColors.whiteColor,
                                ),
                              ),
                              const SizedBox(width: 5.0,),
                              SvgPicture.asset(
                                Images.payout_icon_1,
                              )
                            ],
                          ),
                          const SizedBox(height: 10.0,),
                          Row(
                            children: [
                              Text("Today's Payout : ".tr,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: Dimensions.fontSizeExtraLarge,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF343D5C),
                                ),
                              ),
                              Text("\u{20B9} ${_dashPayoutData!.today}".tr,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: Dimensions.fontSizeExtraLarge,
                                  fontWeight: FontWeight.w700,
                                  color: ThemeColors.whiteColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0,),

                          Row(
                            children: [
                              Text("Total Payout : ".tr,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: Dimensions.fontSizeExtraLarge,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF343D5C),
                                ),
                              ),
                              Text("\u{20B9} ${_dashPayoutData!.total}".tr,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: Dimensions.fontSizeExtraLarge,
                                  fontWeight: FontWeight.w700,
                                  color: ThemeColors.whiteColor,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10.0,),

                          Container(
                            width: MediaQuery.of(context).size.width/2.5,
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(
                                  Dimensions.RADIUS_EXTRA_LARGE),
                              boxShadow: const [
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                // onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigation(index: 2))),
                                // onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context)=>const RewardsScreen())),
                                // onTap:() => Get.to(()=>BottomNavigation(index: 2)),
                                onTap:() => Get.to(()=>const RewardsScreen()),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Open Payout'.tr,
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
