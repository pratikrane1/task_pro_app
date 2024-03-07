import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:task_pro/controller/rewards_controller.dart';
import 'package:task_pro/data/model/rewards_model.dart';
import 'package:task_pro/util/dimensions.dart';
import 'package:task_pro/util/images.dart';
import 'package:task_pro/util/theme_colors.dart';
import 'package:task_pro/view/screens/payout/widget/level_card_widget.dart';
import 'package:intl/intl.dart';

import '../../../util/app_constants.dart';
import '../../base/google_ads.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  bool _isLoading = false;
  RewardsModel? _rewardsData;
  int? earnRewards = 0;
  int? totalCompletedTask = 0;
  int? todaysPayout = 0;
  int? totalUser = 0;
  int? totalPayout = 0;
  DateTime currentDate = DateTime.now();
  String? selectedDate;

  bool isHomePageBannerLoaded = false;
   BannerAd? homePageBanner;


  @override
  void initState(){
    super.initState();
    // Googleads().initializeFullPageAd();
    selectedDate = DateFormat('yyyy-MM-dd').format(currentDate);
    Get.find<RewardsController>().getRewardsData(selectedDate!,);
    callBannerAd();
  }

  void callBannerAd()async
  {
    homePageBanner = await Googleads().loadBannerAd();
    setState((){

    });
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      // initialDate: selectedDate,
      initialDate: currentDate == null ? DateTime.now() : currentDate,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(1945),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        currentDate = picked;
        if (currentDate != null) {
          selectedDate = DateFormat('yyyy-MM-dd').format(currentDate);
          print(selectedDate);
          Get.find<RewardsController>().getRewardsData(selectedDate!,);

        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.secondaryColor,
        title: Padding(
          padding: const EdgeInsets.only(left: 20.0,bottom: 15.0,top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Payout'.tr,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: Dimensions.fontSizeOverLarge,
                          fontWeight: FontWeight.w600,
                          color: ThemeColors.whiteColor,
                        ),
                      ),
                      const SizedBox(width: 4,),
                      SvgPicture.asset(Images.trophy_icon,height: 30),
                    ],
                  ),
                  // const SizedBox(height: 10.0,),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text("${'earned_rewards'.tr} - ",
                  //       textAlign: TextAlign.center,
                  //       style: GoogleFonts.inter(
                  //         fontSize: Dimensions.fontSizeExtraLarge,
                  //         fontWeight: FontWeight.w500,
                  //         color: const Color(0xFFB3B8C8),
                  //       ),
                  //     ),
                  //     Text("$earnRewards",
                  //       textAlign: TextAlign.center,
                  //       style: GoogleFonts.inter(
                  //         fontSize: Dimensions.fontSizeExtraLarge,
                  //         fontWeight: FontWeight.w500,
                  //         color: const Color(0xFFB3B8C8),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
              // PopupMenuButton(
              //   // iconSize: 90,
              //     icon: const Icon(
              //       Icons.filter_list_alt,
              //       color: ThemeColors.whiteColor,
              //     ),
              //     itemBuilder: (context) => function(context)),
            ],
          ),
        ),
        actions: [
          IconButton(
              onPressed: ()=>_selectDate(context),
              icon: const Icon(Icons.filter_list_alt,color: ThemeColors.whiteColor,)
          )
        ],
      ),
      body: GetBuilder<RewardsController>(builder: (rewardsController) {
        _rewardsData = rewardsController.rewardsData;
        _isLoading = rewardsController.isLoading;
        WidgetsBinding.instance.addPostFrameCallback((_){

          if(_rewardsData != null){
            setState(() {
              earnRewards = _rewardsData!.total!.toInt();
              totalCompletedTask = _rewardsData!.completed!.toInt();
              todaysPayout = _rewardsData!.today!.toInt();
              totalUser = _rewardsData!.totalUser!.toInt();
              totalPayout = _rewardsData!.total!.toInt();
            });
          }
        });

        return RefreshIndicator(
            onRefresh: () async{
              await Get.find<RewardsController>().getRewardsData(selectedDate!,);
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _rewardsData != null ?
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,bottom: 5.0),
                      child: Text("Date: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(_rewardsData!.date!))}",
                        style: GoogleFonts.inter(
                          fontSize: Dimensions.fontSizeLarge,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ): const SizedBox(),

                    _rewardsData != null ?
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: Theme.of(context).cardColor,
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          minLeadingWidth: 5,
                          leading: Padding(
                            padding: const EdgeInsets.only(top: 0.0),
                            child: SvgPicture.asset(Images.trophy_icon_2,height: 30,color: ThemeColors.primaryColor,),
                          ),
                          title: Text("Task ${_rewardsData!.completed}/${_rewardsData!.totalTask}".tr,
                            style: GoogleFonts.inter(
                              fontSize: Dimensions.fontSizeLarge,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(_rewardsData!.datalist![index].assignTask!.task!.title ?? "",
                              //   style: GoogleFonts.inter(
                              //     fontSize: Dimensions.fontSizeDefault,
                              //     fontWeight: FontWeight.w600,
                              //   ),
                              // ),

                              const SizedBox(height: 8,),

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(Icons.calendar_today,color: ThemeColors.primaryColor,size: 15,),
                                  const SizedBox(width: 4,),
                                  Text("Today",
                                    style: GoogleFonts.inter(
                                      fontSize: Dimensions.fontSizeSmall,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  // Text("Date : ${DateFormat("d MMM").format(DateTime.parse(_rewardsData!.datalist![index].createdAt.toString()))}",
                                  //   style: GoogleFonts.inter(
                                  //     fontSize: Dimensions.fontSizeSmall,
                                  //     fontWeight: FontWeight.w600,
                                  //   ),
                                  // ),
                                ],
                              ),
                              const SizedBox(height: 10,),
                              Container(
                                decoration: const BoxDecoration(
                                    color: Color(0xFFFFEEE4),
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("${_rewardsData!.datalist![0].userCount} x ${_rewardsData!.datalist![0].payoutPerTask} = ${_rewardsData!.datalist![0].amount}",
                                    style: GoogleFonts.inter(
                                        fontSize: Dimensions.fontSizeLarge,
                                        fontWeight: FontWeight.w600,
                                        color: ThemeColors.secondaryColor
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ) : const SizedBox(),

                    // Image.asset(Images.rewards_steps,),
                    _isLoading ? _rewardsData!.datalist!.isNotEmpty ?
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        padding:
                        const EdgeInsets.only(top: 15, bottom: 15, left: 0, right: 10),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          int indesId = index + 1;
                          return LevelCardWidget(level: "${_rewardsData!.datalist![index+1].level}",
                              userCount: "${_rewardsData!.datalist![index+1].userCount}", amount: "${_rewardsData!.datalist![index+1].amount}");
                        })
                    : Padding(
                      padding: const EdgeInsets.only(top: 100.0),
                      child: Text('No Rewards found.'.tr,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: Dimensions.fontSizeExtraLarge,
                          fontWeight: FontWeight.w500,
                          color: ThemeColors.blackColor,
                        ),
                      ),
                    )
                    : const Padding(
                      padding: EdgeInsets.only(top: 100.0),
                      child: Center(child: CircularProgressIndicator(color: ThemeColors.primaryColor,),),
                    ),

                    // const LevelCardWidget(level: "1",userCount: "15", amount: "75"),
                    // const LevelCardWidget(level: "2",userCount: "15", amount: "75"),
                    // const LevelCardWidget(level: "3",userCount: "15", amount: "75"),
                    // const LevelCardWidget(level: "4",userCount: "15", amount: "75"),
                    // const LevelCardWidget(level: "5",userCount: "15", amount: "75"),


                    // Container(
                    //   color: ThemeColors.secondaryColor,
                    //
                    //   child: Column(
                    //
                    //     children: [
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //
                    //           Padding(
                    //             padding: const EdgeInsets.only(left: 50.0,top: 10.0),
                    //             child: Column(
                    //               children: [
                    //                 Text("Total Task".tr,
                    //                   style: GoogleFonts.inter(
                    //                     color: ThemeColors.whiteColor,
                    //                     fontSize: Dimensions.fontSizeLarge,
                    //                     fontWeight: FontWeight.w700,
                    //                   ),
                    //                 ),
                    //                 const SizedBox(height: 5,),
                    //                 Text("50".tr,
                    //                   style: GoogleFonts.inter(
                    //                     color: ThemeColors.whiteColor,
                    //                     fontSize: Dimensions.fontSizeLarge,
                    //                     fontWeight: FontWeight.w700,
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //           const SizedBox(
                    //               height:60,
                    //               width: 10,
                    //               child: VerticalDivider(color: ThemeColors.whiteColor,thickness: 2,)),
                    //           Padding(
                    //             padding: const EdgeInsets.only(right: 50.0,top: 10.0),
                    //             child: Column(
                    //
                    //               children: [
                    //                 Text("Total User".tr,
                    //                   style: GoogleFonts.inter(
                    //                     color: ThemeColors.whiteColor,
                    //                     fontSize: Dimensions.fontSizeLarge,
                    //                     fontWeight: FontWeight.w700,
                    //                   ),
                    //                 ),
                    //                 const SizedBox(height: 5,),
                    //                 Text("150".tr,
                    //                   style: GoogleFonts.inter(
                    //                     color: ThemeColors.whiteColor,
                    //                     fontSize: Dimensions.fontSizeLarge,
                    //                     fontWeight: FontWeight.w700,
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //       const Divider(color: ThemeColors.whiteColor,thickness: 2,),
                    //       Padding(
                    //         padding: const EdgeInsets.all(10.0),
                    //         child: Column(
                    //           children: [
                    //             Text("Total Payout".tr,
                    //               style: GoogleFonts.inter(
                    //                 color: ThemeColors.whiteColor,
                    //                 fontSize: Dimensions.fontSizeLarge,
                    //                 fontWeight: FontWeight.w700,
                    //               ),
                    //             ),
                    //             const SizedBox(height: 5,),
                    //             Text("1500".tr,
                    //               style: GoogleFonts.inter(
                    //                 color: ThemeColors.whiteColor,
                    //                 fontSize: Dimensions.fontSizeLarge,
                    //                 fontWeight: FontWeight.w700,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          );
        }),
      bottomNavigationBar: Container(
        height: 180,
        color: ThemeColors.secondaryColor,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.only(left: 50.0,top: 10.0),
                  child: Column(
                    children: [
                      Text("Todays Payout".tr,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: ThemeColors.whiteColor,
                          fontSize: Dimensions.fontSizeLarge,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 5,),
                      Text("$todaysPayout".tr,
                        style: GoogleFonts.inter(
                          color: ThemeColors.whiteColor,
                          fontSize: Dimensions.fontSizeLarge,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                    height:60,
                    width: 10,
                    child: VerticalDivider(indent: 5,endIndent: 0,color: ThemeColors.whiteColor,thickness: 1.5,)),
                Padding(
                  padding: const EdgeInsets.only(right: 50.0,top: 10.0,left: 0.0),
                  child: Column(

                    children: [
                      Text("Total User's".tr,
                        style: GoogleFonts.inter(
                          color: ThemeColors.whiteColor,
                          fontSize: Dimensions.fontSizeLarge,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 5,),
                      Text("$totalUser".tr,
                        style: GoogleFonts.inter(
                          color: ThemeColors.whiteColor,
                          fontSize: Dimensions.fontSizeLarge,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(color: ThemeColors.whiteColor,thickness: 1.5,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text("Total Payout".tr,
                    style: GoogleFonts.inter(
                      color: ThemeColors.whiteColor,
                      fontSize: Dimensions.fontSizeLarge,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Text("$totalPayout".tr,
                    style: GoogleFonts.inter(
                      color: ThemeColors.whiteColor,
                      fontSize: Dimensions.fontSizeLarge,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              // width: widget.adSize.width.toDouble(),
              // height: widget.adSize.height.toDouble(),
              width: 320,
              height:40,
              child: homePageBanner == null
              // Nothing to render yet.
                  ? SizedBox()
              // The actual ad.
                  : AdWidget(ad: homePageBanner!),
            ),
          ],
        ),
      ),

    );
  }
}
