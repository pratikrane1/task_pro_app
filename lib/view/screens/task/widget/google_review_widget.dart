// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:task_pro/util/dimensions.dart';
// import 'package:task_pro/util/theme_colors.dart';
//
// class GoogleReviewWidget extends StatefulWidget {
//   const GoogleReviewWidget({super.key});
//
//   @override
//   State<GoogleReviewWidget> createState() => _GoogleReviewWidgetState();
// }
//
// class _GoogleReviewWidgetState extends State<GoogleReviewWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ///Step 1 and check uncheck button
//         Container(
//           decoration: BoxDecoration(
//             // color: ThemeColors.card3Color,
//             border: Border.all(color: ThemeColors.greyTextColor.withOpacity(0.4)),
//             borderRadius: BorderRadius.circular(
//                 Dimensions.RADIUS_EXTRA_LARGE),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ///Step 1 and check uncheck button
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment : CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Step 1'.tr,
//                           textAlign: TextAlign.start,
//                           style: GoogleFonts.inter(
//                             fontSize: Dimensions.fontSizeExtraLarge,
//                             fontWeight: FontWeight.w700,
//                             color: ThemeColors.blackColor,
//                           ),
//                         ),
//                         Text(
//                           'add_review'.tr,
//                           textAlign: TextAlign.start,
//                           style: GoogleFonts.inter(
//                             fontSize: Dimensions.fontSizeDefault,
//                             fontWeight: FontWeight.w400,
//                             color: ThemeColors.blackColor,
//                           ),
//                         ),
//                       ],
//                     ),
//
//                     (_taskData!.status != "Completed" && _taskData!.status != "In-Review") ?
//                     const Icon(Icons.circle_outlined) : const Icon(Icons.check_circle,color: ThemeColors.primaryColor,),
//                   ],
//                 ),
//
//                 const SizedBox(height: 10,),
//
//                 ///Review
//                 if((DateFormat("d\nMMMM").format(DateTime.parse(_taskData!.assignedAt.toString())) == DateFormat("d\nMMMM").format(DateTime.now())))
//                   (_taskData!.status != "Completed" && _taskData!.status != "In-Review") ?
//                   _taskData!.task!.comments!.length != 0 ? Padding(
//                     padding: const EdgeInsets.only(left: 0.0, right: 15.0),
//                     child: Container(
//                       decoration: BoxDecoration(
//                           border: Border.all(
//                               width: 0.5, color: ThemeColors.greyTextColor),
//                           borderRadius:
//                           const BorderRadius.all(Radius.circular(10))),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           _taskData!.task!.comments![0].comment ?? "",
//                           style: GoogleFonts.inter(
//                               fontSize: Dimensions.fontSizeDefault,
//                               fontWeight: FontWeight.w500,
//                               color: const Color(0xFF6C748F)),
//                         ),
//                       ),
//                     ),
//                   ) : const SizedBox()
//                       :const SizedBox(),
//
//                 const SizedBox(height: 10,),
//
//                 ///Copy text and Continue
//                 if((DateFormat("d\nMMMM").format(DateTime.parse(_taskData!.assignedAt.toString())) == DateFormat("d\nMMMM").format(DateTime.now())))
//                   (_taskData!.status != "Completed" && _taskData!.status != "In-Review") ?
//                   Center(
//                     child: Container(
//                       height: 40,
//                       width: MediaQuery.of(context).size.width/1.8,
//                       padding: const EdgeInsets.only(left: 0.0, right: 10),
//                       child: AppButton(
//                         onPressed: () async{
//                           Clipboard.setData(ClipboardData(
//                               text: _taskData!.task!.comments![0].comment ?? ""))
//                               .then((_) {
//                             showCustomSnackBar('Review Text Copied.',
//                                 isError: false);
//                           });
//
//
//                           imagePath = await Navigator.push(context, MaterialPageRoute(builder: (context)=>WebviewScreen(url: _taskData!.task!.url.toString(),howToDoText: _taskData!.howToVideo!.howToDo!,isYoutube : _taskData!.task!.taskType == "Youtube Video" ? true : false)));
//                           if(imagePath != null) {
//                             if (taskController
//                                 .pickedFile !=
//                                 null) {
//                               await Get.find<
//                                   TaskController>()
//                                   .uploadScreenShot(
//                                   _taskData!.id
//                                       .toString());
//                               await Get.find<
//                                   TaskController>()
//                                   .getSpecificTask(
//                                   widget
//                                       .taskList!.id
//                                       .toString());
//                               showCustomSnackBar(
//                                   'Task Submitted Successfully.'
//                                       .tr,isError: false);
//                               Get.find<RewardsController>().getTodaysPayoutData();
//                               Get.find<RewardsController>().getRewardsData("",);
//
//                             } else {
//                               showCustomSnackBar(
//                                   'Please upload screenshot.'
//                                       .tr);
//                             }
//                           }
//                           setState(() {
//                             imagePath;
//                           });
//                         },
//                         shape: const RoundedRectangleBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(50))),
//                         icon: const Icon(
//                           Icons.copy,
//                           size: 15,
//                         ),
//                         text: Text("${'copy_text'.tr} / ${'continue'.tr}",
//                           style: GoogleFonts.inter(
//                               color: Colors.white,
//                               fontSize: Dimensions.fontSizeDefault,
//                               fontWeight: FontWeight.w600),
//                         ),
//                         // loading: login is LoginLoading,
//                         loading: true,
//                         color: ThemeColors.whiteColor,
//                         textColor: ThemeColors.whiteColor,
//                         style: ElevatedButton.styleFrom(
//                           side: const BorderSide(
//                               color: ThemeColors.primaryColor, width: 1),
//                           backgroundColor: ThemeColors.primaryColor,
//                           // color:Colors.red,
//                           shape: const RoundedRectangleBorder(
//                               borderRadius: BorderRadius.all(Radius.circular(30))),
//                         ),
//                       ),
//                     ),
//                   ) : const SizedBox(),
//
//
//               ],
//             ),
//           ),
//         ),
//
//         const SizedBox(
//           height: 15.0,
//         ),
//
//         ///Step 2 and submit image
//         Container(
//           decoration: BoxDecoration(
//             // color: ThemeColors.card3Color,
//             border: Border.all(color: ThemeColors.greyTextColor.withOpacity(0.4)),
//             borderRadius: BorderRadius.circular(
//                 Dimensions.RADIUS_EXTRA_LARGE),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ///Step 2 and check uncheck button
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment : CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Step 2'.tr,
//                           textAlign: TextAlign.start,
//                           style: GoogleFonts.inter(
//                             fontSize: Dimensions.fontSizeExtraLarge,
//                             fontWeight: FontWeight.w700,
//                             color: ThemeColors.blackColor,
//                           ),
//                         ),
//                         Text(
//                           'Add ScreenShot'.tr,
//                           textAlign: TextAlign.start,
//                           style: GoogleFonts.inter(
//                             fontSize: Dimensions.fontSizeDefault,
//                             fontWeight: FontWeight.w400,
//                             color: ThemeColors.blackColor,
//                           ),
//                         ),
//                       ],
//                     ),
//
//                     Row(
//                       children: [
//                         Text(
//                           '${_taskData!.status}'.tr,
//                           textAlign: TextAlign.start,
//                           style: GoogleFonts.inter(
//                             fontSize: Dimensions.fontSizeDefault,
//                             fontWeight: FontWeight.w500,
//                             color: _taskData!.status == "Completed" ? ThemeColors.greenColor : ThemeColors.redColor,
//                           ),
//                         ),
//                         const SizedBox(width: 10,),
//                         (_taskData!.status != "Completed" && _taskData!.status != "In-Review") ?
//                         const Icon(Icons.circle_outlined) : const Icon(Icons.check_circle,color: ThemeColors.primaryColor,),
//                       ],
//                     ),
//                   ],
//                 ),
//
//                 const SizedBox(height: 10,),
//
//                 const Divider(thickness: 1),
//
//                 const SizedBox(height: 5,),
//
//                 if((DateFormat("d\nMMMM").format(DateTime.parse(_taskData!.assignedAt.toString())) == DateFormat("d\nMMMM").format(DateTime.now())))
//                   (_taskData!.completedAt == null) ?
//                   Text(
//                     'after_completion_of_task_kindly_upload_screenshot'.tr,
//                     textAlign: TextAlign.start,
//                     style: GoogleFonts.inter(
//                       fontSize: Dimensions.fontSizeDefault,
//                       fontWeight: FontWeight.w400,
//                       color: ThemeColors.blackColor,
//                     ),
//                   ):const SizedBox(),
//
//                 const SizedBox(height: 5,),
//
//                 Card(
//                   // elevation: 4,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       side: BorderSide(
//                         color: Colors.grey.withOpacity(0.4),
//                       )),
//                   child: ListTile(
//                     minLeadingWidth: 0,
//                     leading: const Icon(
//                       Icons.image_outlined,
//                       color: Colors.blue,
//                     ),
//                     title: imagePath != null
//                         ? Text(
//                       imagePath!.split("/")
//                           .last
//                           .toString() ?? "",
//                       maxLines: imagePath!.split("/")
//                           .last
//                           .toString()
//                           .length ?? 0 ,
//                       style: GoogleFonts.inter(
//                         fontSize: Dimensions.fontSizeDefault,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     )
//                         : Text(
//                       "Image",
//                       style: GoogleFonts.inter(
//                         fontSize: Dimensions.fontSizeDefault,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     trailing: Wrap(
//                       crossAxisAlignment: WrapCrossAlignment.center,
//                       // spacing: 12,
//                       children: [
//                         _taskData!.verifyImageUrl != null ?
//                         InkWell(
//                           onTap: (){
//                             Get.to(()=>ImageViewWidget(imageUrl: _taskData!.verifyImageUrl!,));
//                           },
//                           child: const Icon(
//                             Icons.remove_red_eye,
//                             color: ThemeColors.blackColor,
//                             size: 20,
//                           ),
//                         ) : const SizedBox(),
//                         if((DateFormat("d\nMMMM").format(DateTime.parse(_taskData!.assignedAt.toString())) == DateFormat("d\nMMMM").format(DateTime.now())))
//                           _taskData!.completedAt == null
//                               ? IconButton(
//                             onPressed: () {
//                               Get.find<TaskController>().pickGalleryImage(
//                                   _taskData!.taskId.toString());
//                             },
//                             icon: SvgPicture.asset(
//                               Images.download_icon,
//                               color: ThemeColors.blackColor,
//                               // size: 20,
//                             ),
//                           )
//                               : const SizedBox(),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 10,),
//
//                 ///Submit
//                 if((DateFormat("d\nMMMM").format(DateTime.parse(_taskData!.assignedAt.toString())) == DateFormat("d\nMMMM").format(DateTime.now())))
//                   (_taskData!.status != "Completed" && _taskData!.status != "In-Review") ?
//                   Center(
//                     child: Container(
//                       height: 40,
//                       width: MediaQuery.of(context).size.width/1.8,
//                       padding: const EdgeInsets.only(left: 0.0, right: 10),
//                       child: AppButton(
//                         onPressed: ()async {
//                           if(imagePath != null) {
//                             if (taskController
//                                 .pickedFile !=
//                                 null) {
//                               await Get.find<
//                                   TaskController>()
//                                   .uploadScreenShot(
//                                   _taskData!.id
//                                       .toString());
//                               await Get.find<
//                                   TaskController>()
//                                   .getSpecificTask(
//                                   widget
//                                       .taskList!.id
//                                       .toString());
//                               showCustomSnackBar(
//                                   'Task Submitted Successfully.'
//                                       .tr,isError: false);
//                               Get.find<RewardsController>().getTodaysPayoutData();
//                               Get.find<RewardsController>().getRewardsData("",);
//
//                             } else {
//                               showCustomSnackBar(
//                                   'Please upload screenshot.'
//                                       .tr);
//                             }
//                           }
//
//                         },
//                         shape: const RoundedRectangleBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(50))),
//                         icon: const Icon(
//                           Icons.copy,
//                           size: 15,
//                         ),
//                         text: Text("${'submit'.tr}",
//                           style: GoogleFonts.inter(
//                               color: Colors.white,
//                               fontSize: Dimensions.fontSizeDefault,
//                               fontWeight: FontWeight.w600),
//                         ),
//                         // loading: login is LoginLoading,
//                         loading: true,
//                         color: ThemeColors.whiteColor,
//                         textColor: ThemeColors.whiteColor,
//                         style: ElevatedButton.styleFrom(
//                           side: const BorderSide(
//                               color: ThemeColors.primaryColor, width: 1),
//                           backgroundColor: ThemeColors.primaryColor,
//                           // color:Colors.red,
//                           shape: const RoundedRectangleBorder(
//                               borderRadius: BorderRadius.all(Radius.circular(30))),
//                         ),
//                       ),
//                     ),
//                   ) : const SizedBox(),
//
//
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
