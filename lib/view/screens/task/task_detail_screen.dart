import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_pro/controller/rewards_controller.dart';
import 'package:task_pro/controller/task_controller.dart';
import 'package:task_pro/data/model/task_model.dart';
import 'package:task_pro/util/dimensions.dart';
import 'package:task_pro/util/images.dart';
import 'package:task_pro/util/theme_colors.dart';
import 'package:task_pro/view/base/app_button.dart';
import 'package:task_pro/view/base/custom_snackbar.dart';
import 'package:task_pro/view/base/custome_dialog.dart';
import 'package:intl/intl.dart';
import 'package:task_pro/view/base/image_widget.dart';
import 'package:task_pro/view/screens/task/video_screen.dart';
import 'package:task_pro/view/screens/task/webview_screen.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../base/google_ads.dart';

class TaskDetailScreen extends StatefulWidget {
  const TaskDetailScreen(
      {required this.taskId, required this.taskList, super.key});
  final int taskId;
  final TaskListModel? taskList;

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  bool _isLoading = false;
  bool _isSubmit = false;
  TaskListModel? _taskData;
  String? imagePath;

  @override
  void initState() {
    super.initState();
    Get.find<TaskController>().initData();
    Get.find<TaskController>().getSpecificTask(widget.taskList!.id.toString());
  }

  Future<void> openUrl(String url) async {
    if (await canLaunchUrlString(url)) {
      launchUrlString(url,mode: LaunchMode.externalNonBrowserApplication);
    } else {
      showCustomSnackBar('${'can_not_launch'.tr} $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.secondaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: ThemeColors.whiteColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${'task'.tr} #${widget.taskId}",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: Dimensions.fontSizeOverLarge,
                    fontWeight: FontWeight.w600,
                    color: ThemeColors.whiteColor,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.calendar_month_outlined,
                          color: Color(0xFFF9C594),
                          size: 18,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          "${'date'.tr} : ",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: Dimensions.fontSizeDefault,
                            fontWeight: FontWeight.w500,
                            color: ThemeColors.whiteColor,
                          ),
                        ),
                        // Text('20 Dec'.tr,
                        Text(
                          DateFormat("d MMM").format(DateTime.parse(
                              widget.taskList!.createdAt.toString())),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: Dimensions.fontSizeDefault,
                            fontWeight: FontWeight.w500,
                            color: ThemeColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.access_time_outlined,
                          color: Color(0xFFF9C594),
                          size: 18,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          "${'time_till'.tr} : ",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: Dimensions.fontSizeDefault,
                            fontWeight: FontWeight.w500,
                            color: ThemeColors.whiteColor,
                          ),
                        ),
                        // Text(DateFormat("h:mm a").format(DateTime.parse(widget.taskList!.createdAt.toString())),
                        Text("12:00 PM",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: Dimensions.fontSizeDefault,
                            fontWeight: FontWeight.w500,
                            color: ThemeColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      body: GetBuilder<TaskController>(builder: (taskController) {
        _taskData = taskController.taskData;
        _isLoading = taskController.isSpecificTaskLoading;
        return _isLoading ? _taskData != null ? RefreshIndicator(
          onRefresh: () async {
            await Get.find<TaskController>().getSpecificTask(widget.taskList!.id.toString());
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),

            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _taskData!.task!.title ?? "",
                    // textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: Dimensions.fontSizeOverLarge,
                      fontWeight: FontWeight.w600,
                      color: ThemeColors.blackColor,
                    ),
                  ),

                  const SizedBox(
                    height: 15.0,
                  ),


                  ///Task Number and How to do?
                  Row(
                    children: [
                      ///Task Number
                      Container(
                        width: MediaQuery.of(context).size.width/4,
                        height: 40,
                        decoration: BoxDecoration(
                          color: ThemeColors.card3Color,
                          borderRadius: BorderRadius.circular(
                              Dimensions.RADIUS_EXTRA_LARGE),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text("${'task'.tr} #${widget.taskId}",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: Dimensions.fontSizeLarge,
                                fontWeight: FontWeight.w600,
                                color: ThemeColors.blackColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0,),
                      ///How to do?
                      InkWell(
                                onTap: () => Get.to(()=>VideoScreen(videoData: _taskData!.howToVideo!,)),
                                child: Container(
                                  width: MediaQuery.of(context).size.width/3,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: ThemeColors.greyTextColor.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.RADIUS_EXTRA_LARGE),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text("How to do?",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.inter(
                                          fontSize: Dimensions.fontSizeLarge,
                                          fontWeight: FontWeight.w600,
                                          color: ThemeColors.blackColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                    ],
                  ),

                  const SizedBox(
                    height: 15.0,
                  ),

                  _taskData!.screenShotRejectDes != null ? (_taskData!.status != "Completed" && _taskData!.status != "In-Review") ?
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      // color: ThemeColors.card3Color,
                      border: Border.all(color: ThemeColors.redColor.withOpacity(0.4)),
                      borderRadius: BorderRadius.circular(
                          Dimensions.RADIUS_EXTRA_LARGE),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'reason_for_rejection'.tr,
                            textAlign: TextAlign.start,
                            style: GoogleFonts.inter(
                              fontSize: Dimensions.fontSizeExtraLarge,
                              fontWeight: FontWeight.w700,
                              color: ThemeColors.blackColor,
                            ),
                          ),

                          Text(
                            '${_taskData!.screenShotRejectDes}'.tr,
                            textAlign: TextAlign.start,
                            style: GoogleFonts.inter(
                              fontSize: Dimensions.fontSizeDefault,
                              fontWeight: FontWeight.w400,
                              color: ThemeColors.redColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ) : const SizedBox() : const SizedBox(),

                  const SizedBox(
                    height: 15.0,
                  ),

                  ///Google Business page review
                  _taskData!.task!.taskType == "Business Pages" ?
                  Column(
                    children: [
                      ///Step 1 and check uncheck button
                      Container(
                        decoration: BoxDecoration(
                          // color: ThemeColors.card3Color,
                          border: Border.all(color: ThemeColors.greyTextColor.withOpacity(0.4)),
                          borderRadius: BorderRadius.circular(
                              Dimensions.RADIUS_EXTRA_LARGE),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ///Step 1 and check uncheck button
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment : CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Step 1'.tr,
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.inter(
                                          fontSize: Dimensions.fontSizeExtraLarge,
                                          fontWeight: FontWeight.w700,
                                          color: ThemeColors.blackColor,
                                        ),
                                      ),
                                      Text(
                                        'copy_name'.tr,
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.inter(
                                          fontSize: Dimensions.fontSizeDefault,
                                          fontWeight: FontWeight.w400,
                                          color: ThemeColors.blackColor,
                                        ),
                                      ),
                                    ],
                                  ),

                            (_taskData!.status != "Completed" && _taskData!.status != "In-Review") ?
                                  const Icon(Icons.circle_outlined) : const Icon(Icons.check_circle,color: ThemeColors.primaryColor,),
                                ],
                              ),

                              const SizedBox(height: 5,),
                              SizedBox(
                                  child: Html(
                                    data: _taskData!.task!.description ?? "",
                                  )
                              ),

                              ///Copy Name Widget
                              if((DateFormat("d\nMMMM").format(DateTime.parse(_taskData!.assignedAt.toString())) == DateFormat("d\nMMMM").format(DateTime.now())))
                            (_taskData!.status != "Completed" && _taskData!.status != "In-Review") ?
                            _taskData!.task!.businessName != null? Padding(
                                padding: const EdgeInsets.only(left: 0.0, right: 15.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.5, color: ThemeColors.greyTextColor),
                                      borderRadius:
                                      const BorderRadius.all(Radius.circular(10))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        _taskData!.task!.businessName != null ?
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            // Text(
                                            //   "Name: ",
                                            //   style: GoogleFonts.inter(
                                            //       fontSize: Dimensions.fontSizeDefault,
                                            //       fontWeight: FontWeight.w500,
                                            //       color: ThemeColors.blackColor),
                                            // ),
                                            Flexible(
                                              child: Text(
                                                _taskData!.task!.businessName ?? "",
                                                style: GoogleFonts.inter(
                                                    fontSize: Dimensions.fontSizeDefault,
                                                    fontWeight: FontWeight.w500,
                                                    color: const Color(0xFF6C748F)),
                                              ),
                                            ),
                                            const SizedBox(width: 5,),
                                            InkWell(
                                                onTap: (){
                                                  Clipboard.setData(ClipboardData(
                                                      text: _taskData!.task!.businessName ?? ""))
                                                      .then((_) {
                                                    showCustomSnackBar('Name Copied.',
                                                        isError: false);
                                                  });
                                                },
                                                child: const Icon(Icons.copy,size: 20,color: Color(0xFF6C748F)))
                                          ],
                                        ) : const SizedBox(),
                                        const SizedBox(height: 6,),

                                        // _taskData!.task!.comments![0].comment!.isNotEmpty ?
                                        // Row(
                                        //   crossAxisAlignment: CrossAxisAlignment.start,
                                        //   children: [
                                        //     Text(
                                        //       "Review: ",
                                        //       style: GoogleFonts.inter(
                                        //           fontSize: Dimensions.fontSizeDefault,
                                        //           fontWeight: FontWeight.w500,
                                        //           color: ThemeColors.blackColor),
                                        //     ),
                                        //     Flexible(
                                        //       child: Text(
                                        //         _taskData!.task!.comments![0].comment ?? "",
                                        //         style: GoogleFonts.inter(
                                        //             fontSize: Dimensions.fontSizeDefault,
                                        //             fontWeight: FontWeight.w500,
                                        //             color: const Color(0xFF6C748F)),
                                        //       ),
                                        //     ),
                                        //     InkWell(
                                        //         onTap: (){
                                        //           Clipboard.setData(ClipboardData(
                                        //               text: _taskData!.task!.comments![0].comment ?? ""))
                                        //               .then((_) {
                                        //             showCustomSnackBar('Review Copied.',
                                        //                 isError: false);
                                        //           });
                                        //         },child: const Icon(Icons.copy,size: 20,color: Color(0xFF6C748F)))
                                        //   ],
                                        // ) : const SizedBox(),
                                      ],
                                    ),
                                  ),
                                ),
                              ) : const SizedBox()
                                :const SizedBox(),

                              const SizedBox(height: 10,),

                              ///Copy Name and Continue
                              if((DateFormat("d\nMMMM").format(DateTime.parse(_taskData!.assignedAt.toString())) == DateFormat("d\nMMMM").format(DateTime.now())))
                                (_taskData!.status != "Completed" && _taskData!.status != "In-Review") ?
                              Center(
                                child: Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width/1.8,
                                  padding: const EdgeInsets.only(left: 0.0, right: 10),
                                  child: AppButton(
                                    onPressed: () async{
                                      if(_taskData!.task!.businessName != null) {
                                        Clipboard.setData(ClipboardData(
                                            text: _taskData!.task!
                                                .businessName ?? ""))
                                            .then((_) {
                                          showCustomSnackBar(
                                              'Name Copied.',
                                              isError: false);

                                        taskController.launchUrl(
                                            _taskData!.task!.url.toString());


                                        });
                                      }else{
                                        showCustomSnackBar(
                                            'No name to copy.',
                                            isError: true);
                                      }
                                      // imagePath = await Navigator.push(context, MaterialPageRoute(builder: (context)=>WebviewScreen(url: _taskData!.task!.url.toString(),howToDoText: _taskData!.howToVideo!.howToDo!,isYoutube : _taskData!.task!.taskType == "Youtube Video" ? true : false)));
                                      // if(imagePath != null) {
                                      //                   if (taskController
                                      //                           .pickedFile !=
                                      //                       null) {
                                      //                     await Get.find<
                                      //                             TaskController>()
                                      //                         .uploadScreenShot(
                                      //                             _taskData!.id
                                      //                                 .toString());
                                      //                     await Get.find<
                                      //                             TaskController>()
                                      //                         .getSpecificTask(
                                      //                             widget
                                      //                                 .taskList!.id
                                      //                                 .toString());
                                      //                     showCustomSnackBar(
                                      //                         'Task Submitted Successfully.'
                                      //                             .tr,isError: false);
                                      //                     Get.find<RewardsController>().getTodaysPayoutData();
                                      //                     Get.find<RewardsController>().getRewardsData("",);
                                      //
                                      //                   } else {
                                      //                     showCustomSnackBar(
                                      //                         'Please upload screenshot.'
                                      //                             .tr);
                                      //                   }
                                      //                 }
                                      //                 setState(() {
                                      //   imagePath;
                                      // });
                                    },
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(50))),
                                    icon: const Icon(
                                      Icons.copy,
                                      size: 15,
                                    ),
                                    text: Text("${'copy_name'.tr} & ${'continue'.tr}",
                                      style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: Dimensions.fontSizeDefault,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    // loading: login is LoginLoading,
                                    loading: true,
                                    color: ThemeColors.whiteColor,
                                    textColor: ThemeColors.whiteColor,
                                    style: ElevatedButton.styleFrom(
                                      side: const BorderSide(
                                          color: ThemeColors.primaryColor, width: 1),
                                      backgroundColor: ThemeColors.primaryColor,
                                      // color:Colors.red,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(30))),
                                    ),
                                  ),
                                ),
                              ) : const SizedBox(),


                            ],
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 15.0,
                      ),
                      
                      ///Step 2, Copy Review
                      Container(
                        decoration: BoxDecoration(
                          // color: ThemeColors.card3Color,
                          border: Border.all(color: ThemeColors.greyTextColor.withOpacity(0.4)),
                          borderRadius: BorderRadius.circular(
                              Dimensions.RADIUS_EXTRA_LARGE),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ///Step 2 and check uncheck button
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment : CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Step 2'.tr,
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.inter(
                                          fontSize: Dimensions.fontSizeExtraLarge,
                                          fontWeight: FontWeight.w700,
                                          color: ThemeColors.blackColor,
                                        ),
                                      ),
                                      Text(
                                        'copy_review'.tr,
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.inter(
                                          fontSize: Dimensions.fontSizeDefault,
                                          fontWeight: FontWeight.w400,
                                          color: ThemeColors.blackColor,
                                        ),
                                      ),
                                    ],
                                  ),

                                  (_taskData!.status != "Completed" && _taskData!.status != "In-Review") ?
                                  const Icon(Icons.circle_outlined) : const Icon(Icons.check_circle,color: ThemeColors.primaryColor,),
                                ],
                              ),

                              const SizedBox(height: 5,),
                              // SizedBox(
                              //     child: Html(
                              //       data: _taskData!.task!.description ?? "",
                              //     )
                              // ),

                              ///Review
                              if((DateFormat("d\nMMMM").format(DateTime.parse(_taskData!.assignedAt.toString())) == DateFormat("d\nMMMM").format(DateTime.now())))
                                (_taskData!.status != "Completed" && _taskData!.status != "In-Review") ?
                                _taskData!.task!.comments!.length != 0 ? Padding(
                                  padding: const EdgeInsets.only(left: 0.0, right: 15.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 0.5, color: ThemeColors.greyTextColor),
                                        borderRadius:
                                        const BorderRadius.all(Radius.circular(10))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          // _taskData!.task!.businessName != null ?
                                          // Row(
                                          //   crossAxisAlignment: CrossAxisAlignment.start,
                                          //   children: [
                                          //     Text(
                                          //       "Name: ",
                                          //       style: GoogleFonts.inter(
                                          //           fontSize: Dimensions.fontSizeDefault,
                                          //           fontWeight: FontWeight.w500,
                                          //           color: ThemeColors.blackColor),
                                          //     ),
                                          //     Flexible(
                                          //       child: Text(
                                          //         _taskData!.task!.businessName ?? "",
                                          //         style: GoogleFonts.inter(
                                          //             fontSize: Dimensions.fontSizeDefault,
                                          //             fontWeight: FontWeight.w500,
                                          //             color: const Color(0xFF6C748F)),
                                          //       ),
                                          //     ),
                                          //     InkWell(
                                          //         onTap: (){
                                          //           Clipboard.setData(ClipboardData(
                                          //               text: _taskData!.task!.businessName ?? ""))
                                          //               .then((_) {
                                          //             showCustomSnackBar('Name Copied.',
                                          //                 isError: false);
                                          //           });
                                          //         },
                                          //         child: const Icon(Icons.copy,size: 20,color: Color(0xFF6C748F)))
                                          //   ],
                                          // ) : const SizedBox(),
                                          // const SizedBox(height: 6,),
                                          _taskData!.task!.comments![0].comment!.isNotEmpty ?
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              // Text(
                                              //   "Review: ",
                                              //   style: GoogleFonts.inter(
                                              //       fontSize: Dimensions.fontSizeDefault,
                                              //       fontWeight: FontWeight.w500,
                                              //       color: ThemeColors.blackColor),
                                              // ),
                                              Flexible(
                                                child: Text(
                                                  _taskData!.task!.comments![0].comment ?? "",
                                                  style: GoogleFonts.inter(
                                                      fontSize: Dimensions.fontSizeDefault,
                                                      fontWeight: FontWeight.w500,
                                                      color: const Color(0xFF6C748F)),
                                                ),
                                              ),
                                              const SizedBox(width: 5,),
                                              InkWell(
                                                  onTap: (){
                                                    Clipboard.setData(ClipboardData(
                                                        text: _taskData!.task!.comments![0].comment ?? ""))
                                                        .then((_) {
                                                      showCustomSnackBar('Review Copied.',
                                                          isError: false);
                                                    });
                                                  },child: const Icon(Icons.copy,size: 20,color: Color(0xFF6C748F)))
                                            ],
                                          ) : const SizedBox(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ) : const SizedBox()
                                    :const SizedBox(),

                              const SizedBox(height: 10,),

                              ///Copy text and Continue
                              if((DateFormat("d\nMMMM").format(DateTime.parse(_taskData!.assignedAt.toString())) == DateFormat("d\nMMMM").format(DateTime.now())))
                                (_taskData!.status != "Completed" && _taskData!.status != "In-Review") ?
                                Center(
                                  child: Container(
                                    height: 40,
                                    width: MediaQuery.of(context).size.width/1.8,
                                    padding: const EdgeInsets.only(left: 0.0, right: 10),
                                    child: AppButton(
                                      onPressed: () async{
                                        if(_taskData!.task!.comments!.isNotEmpty) {
                                          Clipboard.setData(ClipboardData(
                                              text: _taskData!.task!
                                                  .comments![0].comment ?? ""))
                                              .then((_) {
                                            showCustomSnackBar(
                                                'Review Text Copied.',
                                                isError: false);
                                          });
                                          // taskController.launchUrl("https://www.google.com/maps");
                                          taskController.launchUrl(
                                              _taskData!.task!.url.toString());
                                        }else{
                                          showCustomSnackBar(
                                              'No review to copy.',
                                              isError: false);
                                        }
                                        
                                        // imagePath = await Navigator.push(context, MaterialPageRoute(builder: (context)=>WebviewScreen(url: _taskData!.task!.url.toString(),howToDoText: _taskData!.howToVideo!.howToDo!,isYoutube : _taskData!.task!.taskType == "Youtube Video" ? true : false)));
                                        // if(imagePath != null) {
                                        //                   if (taskController
                                        //                           .pickedFile !=
                                        //                       null) {
                                        //                     await Get.find<
                                        //                             TaskController>()
                                        //                         .uploadScreenShot(
                                        //                             _taskData!.id
                                        //                                 .toString());
                                        //                     await Get.find<
                                        //                             TaskController>()
                                        //                         .getSpecificTask(
                                        //                             widget
                                        //                                 .taskList!.id
                                        //                                 .toString());
                                        //                     showCustomSnackBar(
                                        //                         'Task Submitted Successfully.'
                                        //                             .tr,isError: false);
                                        //                     Get.find<RewardsController>().getTodaysPayoutData();
                                        //                     Get.find<RewardsController>().getRewardsData("",);
                                        //
                                        //                   } else {
                                        //                     showCustomSnackBar(
                                        //                         'Please upload screenshot.'
                                        //                             .tr);
                                        //                   }
                                        //                 }
                                        //                 setState(() {
                                        //   imagePath;
                                        // });
                                      },
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(50))),
                                      icon: const Icon(
                                        Icons.copy,
                                        size: 15,
                                      ),
                                      text: Text("${'copy_review'.tr} & ${'continue'.tr}",
                                        style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontSize: Dimensions.fontSizeDefault,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      // loading: login is LoginLoading,
                                      loading: true,
                                      color: ThemeColors.whiteColor,
                                      textColor: ThemeColors.whiteColor,
                                      style: ElevatedButton.styleFrom(
                                        side: const BorderSide(
                                            color: ThemeColors.primaryColor, width: 1),
                                        backgroundColor: ThemeColors.primaryColor,
                                        // color:Colors.red,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(30))),
                                      ),
                                    ),
                                  ),
                                ) : const SizedBox(),


                            ],
                          ),
                        ),
                      ),

                      // Container(
                      //   decoration: BoxDecoration(
                      //     // color: ThemeColors.card3Color,
                      //     border: Border.all(color: ThemeColors.greyTextColor.withOpacity(0.4)),
                      //     borderRadius: BorderRadius.circular(
                      //         Dimensions.RADIUS_EXTRA_LARGE),
                      //   ),
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         ///Step 1 and check uncheck button
                      //         Row(
                      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             Column(
                      //               crossAxisAlignment : CrossAxisAlignment.start,
                      //               children: [
                      //                 Text(
                      //                   'Step 1'.tr,
                      //                   textAlign: TextAlign.start,
                      //                   style: GoogleFonts.inter(
                      //                     fontSize: Dimensions.fontSizeExtraLarge,
                      //                     fontWeight: FontWeight.w700,
                      //                     color: ThemeColors.blackColor,
                      //                   ),
                      //                 ),
                      //                 Text(
                      //                   'add_review'.tr,
                      //                   textAlign: TextAlign.start,
                      //                   style: GoogleFonts.inter(
                      //                     fontSize: Dimensions.fontSizeDefault,
                      //                     fontWeight: FontWeight.w400,
                      //                     color: ThemeColors.blackColor,
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //
                      //             (_taskData!.status != "Completed" && _taskData!.status != "In-Review") ?
                      //             const Icon(Icons.circle_outlined) : const Icon(Icons.check_circle,color: ThemeColors.primaryColor,),
                      //           ],
                      //         ),
                      //
                      //         const SizedBox(height: 10,),
                      //
                      //         ///Review
                      //         if((DateFormat("d\nMMMM").format(DateTime.parse(_taskData!.assignedAt.toString())) == DateFormat("d\nMMMM").format(DateTime.now())))
                      //           (_taskData!.status != "Completed" && _taskData!.status != "In-Review") ?
                      //           _taskData!.task!.comments!.length != 0 ? Padding(
                      //             padding: const EdgeInsets.only(left: 0.0, right: 15.0),
                      //             child: Container(
                      //               decoration: BoxDecoration(
                      //                   border: Border.all(
                      //                       width: 0.5, color: ThemeColors.greyTextColor),
                      //                   borderRadius:
                      //                   const BorderRadius.all(Radius.circular(10))),
                      //               child: Padding(
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: Text(
                      //                   _taskData!.task!.comments![0].comment ?? "",
                      //                   style: GoogleFonts.inter(
                      //                       fontSize: Dimensions.fontSizeDefault,
                      //                       fontWeight: FontWeight.w500,
                      //                       color: const Color(0xFF6C748F)),
                      //                 ),
                      //               ),
                      //             ),
                      //           ) : const SizedBox()
                      //               :const SizedBox(),
                      //
                      //         const SizedBox(height: 10,),
                      //
                      //         ///Copy text and Continue
                      //         if((DateFormat("d\nMMMM").format(DateTime.parse(_taskData!.assignedAt.toString())) == DateFormat("d\nMMMM").format(DateTime.now())))
                      //           (_taskData!.status != "Completed" && _taskData!.status != "In-Review") ?
                      //           Center(
                      //             child: Container(
                      //               height: 40,
                      //               width: MediaQuery.of(context).size.width/1.8,
                      //               padding: const EdgeInsets.only(left: 0.0, right: 10),
                      //               child: AppButton(
                      //                 onPressed: () async{
                      //                   Clipboard.setData(ClipboardData(
                      //                       text: _taskData!.task!.comments![0].comment ?? ""))
                      //                       .then((_) {
                      //                     showCustomSnackBar('Review Text Copied.',
                      //                         isError: false);
                      //                   });
                      //
                      //
                      //                   imagePath = await Navigator.push(context, MaterialPageRoute(builder: (context)=>WebviewScreen(url: _taskData!.task!.url.toString(),howToDoText: _taskData!.howToVideo!.howToDo!,isYoutube : _taskData!.task!.taskType == "Youtube Video" ? true : false)));
                      //                   if(imagePath != null) {
                      //                     if (taskController
                      //                         .pickedFile !=
                      //                         null) {
                      //                       await Get.find<
                      //                           TaskController>()
                      //                           .uploadScreenShot(
                      //                           _taskData!.id
                      //                               .toString());
                      //                       await Get.find<
                      //                           TaskController>()
                      //                           .getSpecificTask(
                      //                           widget
                      //                               .taskList!.id
                      //                               .toString());
                      //                       showCustomSnackBar(
                      //                           'Task Submitted Successfully.'
                      //                               .tr,isError: false);
                      //                       Get.find<RewardsController>().getTodaysPayoutData();
                      //                       Get.find<RewardsController>().getRewardsData("",);
                      //
                      //                     } else {
                      //                       showCustomSnackBar(
                      //                           'Please upload screenshot.'
                      //                               .tr);
                      //                     }
                      //                   }
                      //                   setState(() {
                      //                     imagePath;
                      //                   });
                      //                 },
                      //                 shape: const RoundedRectangleBorder(
                      //                     borderRadius: BorderRadius.all(Radius.circular(50))),
                      //                 icon: const Icon(
                      //                   Icons.copy,
                      //                   size: 15,
                      //                 ),
                      //                 text: Text("${'copy_text'.tr} / ${'continue'.tr}",
                      //                   style: GoogleFonts.inter(
                      //                       color: Colors.white,
                      //                       fontSize: Dimensions.fontSizeDefault,
                      //                       fontWeight: FontWeight.w600),
                      //                 ),
                      //                 // loading: login is LoginLoading,
                      //                 loading: true,
                      //                 color: ThemeColors.whiteColor,
                      //                 textColor: ThemeColors.whiteColor,
                      //                 style: ElevatedButton.styleFrom(
                      //                   side: const BorderSide(
                      //                       color: ThemeColors.primaryColor, width: 1),
                      //                   backgroundColor: ThemeColors.primaryColor,
                      //                   // color:Colors.red,
                      //                   shape: const RoundedRectangleBorder(
                      //                       borderRadius: BorderRadius.all(Radius.circular(30))),
                      //                 ),
                      //               ),
                      //             ),
                      //           ) : const SizedBox(),
                      //
                      //
                      //       ],
                      //     ),
                      //   ),
                      // ),

                      const SizedBox(
                        height: 15.0,
                      ),

                      ///Step 3 and submit image
                      Container(
                        decoration: BoxDecoration(
                          // color: ThemeColors.card3Color,
                          border: Border.all(color: ThemeColors.greyTextColor.withOpacity(0.4)),
                          borderRadius: BorderRadius.circular(
                              Dimensions.RADIUS_EXTRA_LARGE),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ///Step 3 and check uncheck button
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment : CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Step 3'.tr,
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.inter(
                                          fontSize: Dimensions.fontSizeExtraLarge,
                                          fontWeight: FontWeight.w700,
                                          color: ThemeColors.blackColor,
                                        ),
                                      ),
                                      Text(
                                        'Add ScreenShot'.tr,
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.inter(
                                          fontSize: Dimensions.fontSizeDefault,
                                          fontWeight: FontWeight.w400,
                                          color: ThemeColors.blackColor,
                                        ),
                                      ),
                                    ],
                                  ),

                                  Row(
                                    children: [
                                       Text(
                                        '${_taskData!.status}'.tr,
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.inter(
                                          fontSize: Dimensions.fontSizeDefault,
                                          fontWeight: FontWeight.w500,
                                          color: _taskData!.status == "Completed" ? ThemeColors.greenColor : ThemeColors.redColor,
                                        ),
                                      ),
                                      const SizedBox(width: 10,),
                                      (_taskData!.status != "Completed" && _taskData!.status != "In-Review") ?
                                      const Icon(Icons.circle_outlined) : const Icon(Icons.check_circle,color: ThemeColors.primaryColor,),
                                    ],
                                  ),
                                ],
                              ),

                              const SizedBox(height: 10,),

                              const Divider(thickness: 1),

                              const SizedBox(height: 5,),

                              if((DateFormat("d\nMMMM").format(DateTime.parse(_taskData!.assignedAt.toString())) == DateFormat("d\nMMMM").format(DateTime.now())))
                                (_taskData!.completedAt == null) ?
                              Text(
                                'after_completion_of_task_kindly_upload_screenshot'.tr,
                                textAlign: TextAlign.start,
                                style: GoogleFonts.inter(
                                  fontSize: Dimensions.fontSizeDefault,
                                  fontWeight: FontWeight.w400,
                                  color: ThemeColors.blackColor,
                                ),
                              ):const SizedBox(),

                              const SizedBox(height: 5,),
                              Card(
                                // elevation: 4,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: BorderSide(
                                      color: Colors.grey.withOpacity(0.4),
                                    )),
                                child: ListTile(
                                  minLeadingWidth: 0,
                                  leading: const Icon(
                                    Icons.image_outlined,
                                    color: Colors.blue,
                                  ),
                                  title: imagePath != null
                                      ? Text(
                                    imagePath!.split("/")
                                        .last
                                        .toString() ?? "",
                                    maxLines: imagePath!.split("/")
                                        .last
                                        .toString()
                                        .length ?? 0 ,
                                    style: GoogleFonts.inter(
                                      fontSize: Dimensions.fontSizeDefault,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                      : Text(
                                    "Image",
                                    style: GoogleFonts.inter(
                                      fontSize: Dimensions.fontSizeDefault,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  trailing: Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    // spacing: 12,
                                    children: [
                                      _taskData!.verifyImageUrl != null ?
                                      InkWell(
                                        onTap: (){
                                          Get.to(()=>ImageViewWidget(imageUrl: _taskData!.verifyImageUrl!,));
                                        },
                                        child: const Icon(
                                          Icons.remove_red_eye,
                                          color: ThemeColors.blackColor,
                                          size: 20,
                                        ),
                                      ) : const SizedBox(),
                                      if((DateFormat("d\nMMMM").format(DateTime.parse(_taskData!.assignedAt.toString())) == DateFormat("d\nMMMM").format(DateTime.now())))
                                        (_taskData!.completedAt == null || _taskData!.screenShotRejectDes != null)
                                            ? IconButton(
                                          onPressed: () async{
                                            await Get.find<TaskController>().pickGalleryImage(
                                                _taskData!.taskId.toString());
                                            setState(() {
                                              imagePath = taskController.pickedFile!.path;
                                            });
                                          },
                                          icon: SvgPicture.asset(
                                            Images.download_icon,
                                            color: ThemeColors.blackColor,
                                            // size: 20,
                                          ),
                                        )
                                            : const SizedBox(),
                                    ],
                                  ),
                                ),
                              ),

                              // Card(
                              //   // elevation: 4,
                              //   shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(30),
                              //       side: BorderSide(
                              //         color: Colors.grey.withOpacity(0.4),
                              //       )),
                              //   child: ListTile(
                              //     minLeadingWidth: 0,
                              //     leading: const Icon(
                              //       Icons.image_outlined,
                              //       color: Colors.blue,
                              //     ),
                              //     title: imagePath != null
                              //         ? Text(
                              //       imagePath!.split("/")
                              //                 .last
                              //                 .toString() ?? "",
                              //       maxLines: imagePath!.split("/")
                              //           .last
                              //           .toString()
                              //           .length ?? 0 ,
                              //       style: GoogleFonts.inter(
                              //         fontSize: Dimensions.fontSizeDefault,
                              //         fontWeight: FontWeight.w400,
                              //       ),
                              //     )
                              //         : Text(
                              //       "Image",
                              //       style: GoogleFonts.inter(
                              //         fontSize: Dimensions.fontSizeDefault,
                              //         fontWeight: FontWeight.w600,
                              //       ),
                              //     ),
                              //     trailing: Wrap(
                              //       crossAxisAlignment: WrapCrossAlignment.center,
                              //       // spacing: 12,
                              //       children: [
                              //         _taskData!.verifyImageUrl != null ?
                              //         InkWell(
                              //           onTap: (){
                              //             Get.to(()=>ImageViewWidget(imageUrl: _taskData!.verifyImageUrl!,));
                              //           },
                              //           child: const Icon(
                              //             Icons.remove_red_eye,
                              //             color: ThemeColors.blackColor,
                              //             size: 20,
                              //           ),
                              //         ) : const SizedBox(),
                              //         if((DateFormat("d\nMMMM").format(DateTime.parse(_taskData!.assignedAt.toString())) == DateFormat("d\nMMMM").format(DateTime.now())))
                              //           _taskData!.completedAt == null
                              //             ? IconButton(
                              //           onPressed: () {
                              //             Get.find<TaskController>().pickGalleryImage(
                              //                 _taskData!.taskId.toString());
                              //           },
                              //           icon: SvgPicture.asset(
                              //             Images.download_icon,
                              //             color: ThemeColors.blackColor,
                              //             // size: 20,
                              //           ),
                              //         )
                              //             : const SizedBox(),
                              //       ],
                              //     ),
                              //   ),
                              // ),

                              const SizedBox(height: 10,),

                              ///Submit
                              if((DateFormat("d\nMMMM").format(DateTime.parse(_taskData!.assignedAt.toString())) == DateFormat("d\nMMMM").format(DateTime.now())))
                                (_taskData!.status != "Completed" && _taskData!.status != "In-Review") ?
                              Center(
                                child: Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width/1.8,
                                  padding: const EdgeInsets.only(left: 0.0, right: 10),
                                  child: AppButton(
                                    onPressed: ()async {
                                      if(imagePath != null) {

                                        if (taskController
                                            .pickedFile !=
                                            null) {
                                          await Get.find<
                                              TaskController>()
                                              .uploadScreenShot(
                                              _taskData!.id
                                                  .toString());
                                          await Get.find<
                                              TaskController>()
                                              .getSpecificTask(
                                              widget
                                                  .taskList!.id
                                                  .toString());
                                          Googleads().initializeFullPageAd();

                                          showCustomSnackBar(
                                              'Task Submitted Successfully.'
                                                  .tr,isError: false);
                                          Get.find<RewardsController>().getTodaysPayoutData();
                                          Get.find<RewardsController>().getRewardsData("",);

                                        } else {
                                          showCustomSnackBar(
                                              'Please upload screenshot.'
                                                  .tr);
                                        }
                                      }

                                    },
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(50))),
                                    // icon: const Icon(
                                    //   Icons.copy,
                                    //   size: 15,
                                    // ),
                                    text: Text("${'submit'.tr}",
                                      style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: Dimensions.fontSizeDefault,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    // loading: login is LoginLoading,
                                    loading: true,
                                    color: ThemeColors.whiteColor,
                                    textColor: ThemeColors.whiteColor,
                                    style: ElevatedButton.styleFrom(
                                      side: const BorderSide(
                                          color: ThemeColors.primaryColor, width: 1),
                                      backgroundColor: ThemeColors.primaryColor,
                                      // color:Colors.red,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(30))),
                                    ),
                                  ),
                                ),
                              ) : const SizedBox(),


                            ],
                          ),
                        ),
                      ),
                    ],
                  ) : const SizedBox(),

                  ///Youtube Steps And Playstore AppStore Download Task And Waayu Order Task
                  (_taskData!.task!.taskType == "Youtube Video" || _taskData!.task!.taskType == "Download Playstore App" || _taskData!.task!.taskType == "Download & Review Playstore App" || _taskData!.task!.taskType == "Wayu Order") ?
                  Column(
                    children: [
                      ///Step 1 and check uncheck button
                      Container(
                        decoration: BoxDecoration(
                          // color: ThemeColors.card3Color,
                          border: Border.all(color: ThemeColors.greyTextColor.withOpacity(0.4)),
                          borderRadius: BorderRadius.circular(
                              Dimensions.RADIUS_EXTRA_LARGE),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ///Step 1 and check uncheck button
                              Column(
                                crossAxisAlignment : CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Step 1'.tr,
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.inter(
                                          fontSize: Dimensions.fontSizeExtraLarge,
                                          fontWeight: FontWeight.w700,
                                          color: ThemeColors.blackColor,
                                        ),
                                      ),
                                      (_taskData!.status != "Completed" && _taskData!.status != "In-Review") ?
                                      const Icon(Icons.circle_outlined) : const Icon(Icons.check_circle,color: ThemeColors.primaryColor,),

                                    ],
                                  ),
                                  SizedBox(
                                    child: Html(
                                      data: _taskData!.task!.description ?? "",
                                    )
                                  ),
                                  ///Review
                                  if(_taskData!.task!.taskType == "Download & Review Playstore App" )
                                  if((DateFormat("d\nMMMM").format(DateTime.parse(_taskData!.assignedAt.toString())) == DateFormat("d\nMMMM").format(DateTime.now())))
                                    (_taskData!.status != "Completed" && _taskData!.status != "In-Review") ?
                                    _taskData!.task!.comments!.length != 0 ? Padding(
                                      padding: const EdgeInsets.only(left: 0.0, right: 15.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 0.5, color: ThemeColors.greyTextColor),
                                            borderRadius:
                                            const BorderRadius.all(Radius.circular(10))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            _taskData!.task!.comments![0].comment ?? "",
                                            style: GoogleFonts.inter(
                                                fontSize: Dimensions.fontSizeDefault,
                                                fontWeight: FontWeight.w500,
                                                color: const Color(0xFF6C748F)),
                                          ),
                                        ),
                                      ),
                                    ) : const SizedBox()
                                        :const SizedBox(),
                                        // : const SizedBox(),
                                ],
                              ),

                              const SizedBox(height: 10,),

                              /// Continue button
                              if((DateFormat("d\nMMMM").format(DateTime.parse(_taskData!.assignedAt.toString())) == DateFormat("d\nMMMM").format(DateTime.now())))
                                (_taskData!.status != "Completed" && _taskData!.status != "In-Review") ?
                                (_taskData!.task!.taskType != "Download & Review Playstore App" ) ?
                                Center(
                                  child: Container(
                                    height: 40,
                                    width: MediaQuery.of(context).size.width/1.8,
                                    padding: const EdgeInsets.only(left: 0.0, right: 10),
                                    child: AppButton(
                                      onPressed: () async{
                                        _taskData!.task!.taskType == "Youtube Video" ?
                                        imagePath = await Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                            WebviewScreen(url: _taskData!.task!.url.toString(),howToDoText: _taskData!.task!.description!,
                                                isYoutube : _taskData!.task!.taskType == "Youtube Video" ? true : false)))
                                        : taskController.launchUrl(_taskData!.task!.url.toString());
                                        if(imagePath != null) {
                                          if (taskController
                                              .pickedFile !=
                                              null) {
                                            await Get.find<
                                                TaskController>()
                                                .uploadScreenShot(
                                                _taskData!.id
                                                    .toString());
                                            await Get.find<
                                                TaskController>()
                                                .getSpecificTask(
                                                widget
                                                    .taskList!.id
                                                    .toString());
                                            Googleads().initializeFullPageAd();
                                            showCustomSnackBar(
                                                'Task Submitted Successfully.'
                                                    .tr,isError: false);
                                            Get.find<RewardsController>().getTodaysPayoutData();
                                            Get.find<RewardsController>().getRewardsData("",);

                                          } else {
                                            showCustomSnackBar(
                                                'Please upload screenshot.'
                                                    .tr);
                                          }
                                        }
                                        setState(() {
                                          imagePath;
                                        });

                                      },
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(50))),
                                      text: Text("${'continue'.tr}",
                                        style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontSize: Dimensions.fontSizeDefault,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      // loading: login is LoginLoading,
                                      loading: true,
                                      color: ThemeColors.whiteColor,
                                      textColor: ThemeColors.whiteColor,
                                      style: ElevatedButton.styleFrom(
                                        side: const BorderSide(
                                            color: ThemeColors.primaryColor, width: 1),
                                        backgroundColor: ThemeColors.primaryColor,
                                        // color:Colors.red,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(30))),
                                      ),
                                    ),
                                  ),
                                ) : Center(
                                  child: Container(
                                    height: 40,
                                    width: MediaQuery.of(context).size.width/1.8,
                                    padding: const EdgeInsets.only(left: 0.0, right: 10),
                                    child: AppButton(
                                      onPressed: () async{
                                        Clipboard.setData(ClipboardData(
                                            text: _taskData!.task!.comments![0].comment ?? ""))
                                            .then((_) {
                                          showCustomSnackBar('Review Text Copied.',
                                              isError: false);
                                        });


                                        taskController.launchUrl(_taskData!.task!.url.toString());
                                      },
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(50))),
                                      icon: const Icon(
                                        Icons.copy,
                                        size: 15,
                                      ),
                                      text: Text("${'copy_text'.tr} / ${'continue'.tr}",
                                        style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontSize: Dimensions.fontSizeDefault,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      // loading: login is LoginLoading,
                                      loading: true,
                                      color: ThemeColors.whiteColor,
                                      textColor: ThemeColors.whiteColor,
                                      style: ElevatedButton.styleFrom(
                                        side: const BorderSide(
                                            color: ThemeColors.primaryColor, width: 1),
                                        backgroundColor: ThemeColors.primaryColor,
                                        // color:Colors.red,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(30))),
                                      ),
                                    ),
                                  ),
                                ) : const SizedBox(),


                            ],
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 15.0,
                      ),
                      
                      ///Step 2 
                      Container(
                        decoration: BoxDecoration(
                          // color: ThemeColors.card3Color,
                          border: Border.all(color: ThemeColors.greyTextColor.withOpacity(0.4)),
                          borderRadius: BorderRadius.circular(
                              Dimensions.RADIUS_EXTRA_LARGE),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ///Step 2 and check uncheck button
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment : CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Step 2'.tr,
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.inter(
                                          fontSize: Dimensions.fontSizeExtraLarge,
                                          fontWeight: FontWeight.w700,
                                          color: ThemeColors.blackColor,
                                        ),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width/2,
                                        child: Text(
                                          'Add ScreenShot'.tr,
                                          textAlign: TextAlign.start,
                                          maxLines: 2,
                                          style: GoogleFonts.inter(
                                            fontSize: Dimensions.fontSizeDefault,
                                            fontWeight: FontWeight.w400,
                                            color: ThemeColors.blackColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  Row(
                                    children: [
                                      Text(
                                        '${_taskData!.status}'.tr,
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.inter(
                                          fontSize: Dimensions.fontSizeDefault,
                                          fontWeight: FontWeight.w500,
                                          color: _taskData!.status == "Completed" ? ThemeColors.greenColor : ThemeColors.redColor,
                                        ),
                                      ),
                                      const SizedBox(width: 10,),
                                      (_taskData!.status != "Completed" && _taskData!.status != "In-Review") ?
                                      const Icon(Icons.circle_outlined) : const Icon(Icons.check_circle,color: ThemeColors.primaryColor,),
                                    ],
                                  ),
                                ],
                              ),

                              const SizedBox(height: 10,),

                              const Divider(thickness: 1),

                              const SizedBox(height: 5,),

                              if((DateFormat("d\nMMMM").format(DateTime.parse(_taskData!.assignedAt.toString())) == DateFormat("d\nMMMM").format(DateTime.now())))
                                (_taskData!.completedAt == null) ?
                                Text(
                                  'After completion of task kindly upload screenshot and press submit button.'.tr,
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.inter(
                                    fontSize: Dimensions.fontSizeDefault,
                                    fontWeight: FontWeight.w400,
                                    color: ThemeColors.blackColor,
                                  ),
                                ):const SizedBox(),

                              const SizedBox(height: 5,),

                              Card(
                                // elevation: 4,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: BorderSide(
                                      color: Colors.grey.withOpacity(0.4),
                                    )),
                                child: ListTile(
                                  minLeadingWidth: 0,
                                  leading: const Icon(
                                    Icons.image_outlined,
                                    color: Colors.blue,
                                  ),
                                  title: imagePath != null
                                      ? Text(
                                    imagePath!.split("/")
                                        .last
                                        .toString() ?? "",
                                    maxLines: imagePath!.split("/")
                                        .last
                                        .toString()
                                        .length ?? 0 ,
                                    style: GoogleFonts.inter(
                                      fontSize: Dimensions.fontSizeDefault,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                      : Text(
                                    "Image",
                                    style: GoogleFonts.inter(
                                      fontSize: Dimensions.fontSizeDefault,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  trailing: Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    // spacing: 12,
                                    children: [
                                      _taskData!.verifyImageUrl != null ?
                                      InkWell(
                                        onTap: (){
                                          Get.to(()=>ImageViewWidget(imageUrl: _taskData!.verifyImageUrl!,));
                                        },
                                        child: const Icon(
                                          Icons.remove_red_eye,
                                          color: ThemeColors.blackColor,
                                          size: 20,
                                        ),
                                      ) : const SizedBox(),
                                      if((DateFormat("d\nMMMM").format(DateTime.parse(_taskData!.assignedAt.toString())) == DateFormat("d\nMMMM").format(DateTime.now())))
                                        (_taskData!.completedAt == null || _taskData!.screenShotRejectDes != null)
                                            ? IconButton(
                                          onPressed: () async{
                                            await Get.find<TaskController>().pickGalleryImage(
                                                _taskData!.taskId.toString());
                                            setState(() {
                                              imagePath = taskController.pickedFile!.path;
                                            });
                                          },
                                          icon: SvgPicture.asset(
                                            Images.download_icon,
                                            color: ThemeColors.blackColor,
                                            // size: 20,
                                          ),
                                        )
                                            : const SizedBox(),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: 10,),

                              ///Submit
                              if((DateFormat("d\nMMMM").format(DateTime.parse(_taskData!.assignedAt.toString())) == DateFormat("d\nMMMM").format(DateTime.now())))
                                (_taskData!.status != "Completed" && _taskData!.status != "In-Review") ?
                                Center(
                                  child: Container(
                                    height: 40,
                                    width: MediaQuery.of(context).size.width/1.8,
                                    padding: const EdgeInsets.only(left: 0.0, right: 10),
                                    child: AppButton(
                                      onPressed: ()async {
                                        if(imagePath != null) {
                                          if (taskController
                                              .pickedFile !=
                                              null) {
                                            await Get.find<
                                                TaskController>()
                                                .uploadScreenShot(
                                                _taskData!.id
                                                    .toString());
                                            await Get.find<
                                                TaskController>()
                                                .getSpecificTask(
                                                widget
                                                    .taskList!.id
                                                    .toString());
                                            showCustomSnackBar(
                                                'Task Submitted Successfully.'
                                                    .tr,isError: false);
                                            Get.find<RewardsController>().getTodaysPayoutData();
                                            Get.find<RewardsController>().getRewardsData("",);

                                          } else {
                                            showCustomSnackBar(
                                                'Please upload screenshot.'
                                                    .tr);
                                          }
                                        }else {
                                          showCustomSnackBar(
                                              'Please upload screenshot.'
                                                  .tr);
                                        }
                                        setState(() {
                                          imagePath;
                                        });

                                      },
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(50))),
                                      text: Text("${'submit'.tr}",
                                        style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontSize: Dimensions.fontSizeDefault,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      // loading: login is LoginLoading,
                                      loading: true,
                                      color: ThemeColors.whiteColor,
                                      textColor: ThemeColors.whiteColor,
                                      style: ElevatedButton.styleFrom(
                                        side: const BorderSide(
                                            color: ThemeColors.primaryColor, width: 1),
                                        backgroundColor: ThemeColors.primaryColor,
                                        // color:Colors.red,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(30))),
                                      ),
                                    ),
                                  ),
                                ) : const SizedBox(),


                            ],
                          ),
                        ),
                      ),
                    ],
                  ) : const SizedBox(),

                  const SizedBox(
                    height: 30.0,
                  ),
                ],
              ),

            ),
          ),
        ) : const SizedBox() : const Center(child: CircularProgressIndicator(color: ThemeColors.primaryColor,),);
      }),
    );
  }
}
