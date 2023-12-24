import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
import 'package:task_pro/view/screens/task/webview_screen.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
        // WidgetsBinding.instance.addPostFrameCallback((_){
        //
        //   if(taskController.pickedFile != null)
        //   {
        //     setState(() {
        //       imagePath = taskController.pickedFile!.path
        //           .split("/")
        //           .last
        //           .toString();
        //     });
        //   }
        // });

        return _isLoading ? _taskData != null ? RefreshIndicator(
          onRefresh: () async {
            await Get.find<TaskController>().getSpecificTask(widget.taskList!.id.toString());
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),

            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
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

                  // Text(
                  //   _taskData!.task!.description ?? "",
                  //   // textAlign: TextAlign.center,
                  //   style: GoogleFonts.inter(
                  //     fontSize: Dimensions.fontSizeLarge,
                  //     fontWeight: FontWeight.w400,
                  //     color: ThemeColors.greyTextColor,
                  //   ),
                  // ),

                  const SizedBox(
                    height: 15.0,
                  ),


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

                  const SizedBox(
                    height: 15.0,
                  ),

                  // Card(
                  //   // elevation: 4,
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //       side: BorderSide(
                  //         color: Colors.grey.withOpacity(0.4),
                  //       )),
                  //   child: ListTile(
                  //     title: Text(
                  //       "Status",
                  //       style: GoogleFonts.inter(
                  //         fontSize: Dimensions.fontSizeDefault,
                  //         fontWeight: FontWeight.w600,
                  //       ),
                  //     ),
                  //     subtitle: Row(
                  //       children: [
                  //         (_taskData!.verifiedAt == null &&
                  //             _taskData!.completedAt == null)
                  //             ? const SizedBox.shrink()
                  //             : _taskData!.verifiedAt == null
                  //             ? Text(
                  //           "In-Process",
                  //           style: GoogleFonts.inter(
                  //               fontSize:
                  //               Dimensions.fontSizeSmall,
                  //               fontWeight: FontWeight.w600,
                  //               color: ThemeColors.redColor),
                  //         )
                  //             : Text(
                  //           "Approved",
                  //           style: GoogleFonts.inter(
                  //               fontSize:
                  //               Dimensions.fontSizeSmall,
                  //               fontWeight: FontWeight.w600,
                  //               color: ThemeColors.greenColor),
                  //         ),
                  //
                  //       ],
                  //     ),
                  //
                  //     trailing: Stack(
                  //       children: [
                  //         IconButton(
                  //           onPressed: () {},
                  //           icon: const Icon(
                  //             Icons.circle_outlined,
                  //             color: ThemeColors.card2Color,
                  //             size: 20,
                  //           ),
                  //         ),
                  //         // _taskData!.status == "Completed"
                  //         _taskData!.verifiedAt != null
                  //             ? const Positioned(
                  //                 top: 10,
                  //                 right: 10,
                  //                 child: Icon(
                  //                   Icons.check,
                  //                   color: ThemeColors.blackColor,
                  //                 ))
                  //             : const SizedBox(),
                  //       ],
                  //     ),
                  //   ),
                  // ),

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
                                    'add_review'.tr,
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.inter(
                                      fontSize: Dimensions.fontSizeDefault,
                                      fontWeight: FontWeight.w400,
                                      color: ThemeColors.blackColor,
                                    ),
                                  ),
                                ],
                              ),

                              (_taskData!.completedAt == null) ?
                              const Icon(Icons.circle_outlined) : const Icon(Icons.check_circle,color: ThemeColors.primaryColor,),
                            ],
                          ),

                          const SizedBox(height: 10,),

                          ///Review
                          (_taskData!.completedAt == null) ?
                          Padding(
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
                          ):const SizedBox(),

                          const SizedBox(height: 10,),

                          ///Copy text and Continue
                          (_taskData!.completedAt == null) ?
                          Center(
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

                                  // openUrl(_taskData!.task!.url.toString());
                                  // openUrl("https://g.page/r/CcM2nPzaehd_EAI/review");
                                  // openUrl("https://play.google.com/store/apps/details?id=com.destek.proapp&pcampaignid=web_share");


                                  // Get.to(()=> const WebviewScreen());
                                  imagePath = await Navigator.push(context, MaterialPageRoute(builder: (context)=>WebviewScreen(url: _taskData!.task!.url.toString(),)));
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



                  ///Step 2 and submit image
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
                                  _taskData!.completedAt != null ?
                                  _taskData!.verifiedAt == null ?
                                  Text(
                                    'In-Review'.tr,
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.inter(
                                      fontSize: Dimensions.fontSizeDefault,
                                      fontWeight: FontWeight.w500,
                                      color: ThemeColors.redColor,
                                    ),
                                  ) : Text(
                                    'Completed'.tr,
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.inter(
                                      fontSize: Dimensions.fontSizeDefault,
                                      fontWeight: FontWeight.w500,
                                      color: ThemeColors.greenColor,
                                    ),
                                  ) : const SizedBox(),
                                  const SizedBox(width: 10,),
                                  (_taskData!.completedAt == null) ?
                                  const Icon(Icons.circle_outlined) : const Icon(Icons.check_circle,color: ThemeColors.primaryColor,),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 10,),

                          const Divider(thickness: 1),

                          const SizedBox(height: 5,),

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
                                  _taskData!.completedAt == null
                                      ? IconButton(
                                    onPressed: () {
                                      Get.find<TaskController>().pickGalleryImage(
                                          _taskData!.taskId.toString());
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
                          (_taskData!.completedAt == null) ?
                          Center(
                            child: Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width/1.8,
                              padding: const EdgeInsets.only(left: 0.0, right: 10),
                              child: AppButton(
                                onPressed: ()async {
                                        if (taskController.pickedFile != null) {
                                          await Get.find<TaskController>().uploadScreenShot(
                                              _taskData!.id.toString());
                                          await Get.find<TaskController>().getSpecificTask(widget.taskList!.id.toString());
                                        }else{
                                          showCustomSnackBar('Please upload screenshot.'.tr);
                                        }
                                },
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(50))),
                                icon: const Icon(
                                  Icons.copy,
                                  size: 15,
                                ),
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


                  const SizedBox(
                    height: 30.0,
                  ),

                  ///Upload Screen Shot
                  // _taskData!.verifiedAt == null ? Padding(
                  //   padding: const EdgeInsets.only(
                  //       left: 30.0, right: 30.0, bottom: 10),
                  //   child: AppButton(
                  //     onPressed: () async {
                  //       if (taskController.pickedFile != null) {
                  //         await Get.find<TaskController>().uploadScreenShot(
                  //             _taskData!.taskId.toString());
                  //         await Get.find<TaskController>().getSpecificTask(widget.taskList!.taskId.toString());
                  //       }else{
                  //         showCustomSnackBar('Please upload screenshot.'.tr);
                  //       }
                  //     },
                  //     height: 60,
                  //     width: MediaQuery.of(context).size.width,
                  //     text: Text(
                  //       'upload_screenshot'.tr,
                  //       style: GoogleFonts.inter(
                  //           color: ThemeColors.primaryColor,
                  //           fontSize: 18,
                  //           fontWeight: FontWeight.w600),
                  //     ),
                  //     loading: true,
                  //     style: ElevatedButton.styleFrom(
                  //       side: const BorderSide(
                  //           color: ThemeColors.primaryColor, width: 1),
                  //       backgroundColor: ThemeColors.whiteColor,
                  //       // color:Colors.red,
                  //       shape: const RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.all(Radius.circular(50))),
                  //     ),
                  //   ),
                  // ) : const SizedBox(),
                  //
                  // ///Add Review
                  // _taskData!.verifiedAt == null ? Padding(
                  //   padding: const EdgeInsets.only(
                  //       left: 30.0, right: 30.0, bottom: 10),
                  //   child: AppButton(
                  //     onPressed: () async {
                  //       showDialog(
                  //           context: context,
                  //           builder: (BuildContext context) => CustomDialog(
                  //                 taskData: widget.taskList,
                  //               ));
                  //     },
                  //     height: 60,
                  //     width: MediaQuery.of(context).size.width,
                  //     text: Text(
                  //       'add_review'.tr,
                  //       style: GoogleFonts.inter(
                  //           color: ThemeColors.whiteColor,
                  //           fontSize: 18,
                  //           fontWeight: FontWeight.w600),
                  //     ),
                  //     loading: true,
                  //     style: ElevatedButton.styleFrom(
                  //       side: const BorderSide(
                  //           color: ThemeColors.primaryColor, width: 1),
                  //       backgroundColor: ThemeColors.primaryColor,
                  //       // color:Colors.red,
                  //       shape: const RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.all(Radius.circular(50))),
                  //     ),
                  //   ),
                  // ) : const SizedBox(),
                ],
              ),
            ),
          ),
        ) : const SizedBox() : const Center(child: CircularProgressIndicator(color: ThemeColors.primaryColor,),);
      }),
    );
  }
}
