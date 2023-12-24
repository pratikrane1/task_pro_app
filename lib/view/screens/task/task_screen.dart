import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:task_pro/controller/task_controller.dart';
import 'package:task_pro/data/model/task_model.dart';
import 'package:task_pro/util/dimensions.dart';
import 'package:task_pro/util/theme_colors.dart';
import 'package:task_pro/view/screens/task/task_detail_screen.dart';
import 'package:intl/intl.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({required this.assignTaskDate,super.key});
  final String assignTaskDate;

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  TaskModel? _taskList;
  bool _isLoading = false;
  double? percentage = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    Get.find<TaskController>().getTask(widget.assignTaskDate);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskController>(builder: (taskController) {
      _taskList = taskController.taskList;
      _isLoading = taskController.isGetTaskLoading;
      if(_taskList != null) {
        percentage = (_taskList!.completed! /
            (_taskList!.completed! +
                _taskList!.incomplete!) *
            100);
      }
        return Scaffold(
           appBar: AppBar(
             backgroundColor: ThemeColors.secondaryColor,
             leading: IconButton(
               icon: const Icon(Icons.arrow_back,color: ThemeColors.whiteColor,),
               onPressed: (){
                 Navigator.of(context).pop();
               },
             ),
             bottom: PreferredSize(
               preferredSize: const Size.fromHeight(kToolbarHeight),
               child: Padding(
                 padding: const EdgeInsets.only(left: 20.0,bottom: 15.0),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text('todays_task'.tr,
                       textAlign: TextAlign.center,
                       style: GoogleFonts.inter(
                         fontSize: Dimensions.fontSizeOverLarge,
                         fontWeight: FontWeight.w600,
                         color: ThemeColors.whiteColor,
                       ),
                     ),
                     const SizedBox(height: 10.0,),
                     Row(
                       children: [
                         Row(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             const Icon(Icons.calendar_month_outlined,color: Color(0xFFF9C594), size: 18,),
                             const SizedBox(width: 4,),
                             Text("${'date'.tr} : ",
                               textAlign: TextAlign.center,
                               style: GoogleFonts.inter(
                                 fontSize: Dimensions.fontSizeDefault,
                                 fontWeight: FontWeight.w500,
                                 color: ThemeColors.whiteColor,
                               ),
                             ),
                             Text(DateFormat("d MMM").format(DateTime.parse(widget.assignTaskDate.toString())),
                               textAlign: TextAlign.center,
                               style: GoogleFonts.inter(
                                 fontSize: Dimensions.fontSizeDefault,
                                 fontWeight: FontWeight.w500,
                                 color: ThemeColors.whiteColor,
                               ),
                             ),
                           ],
                         ),
                         const SizedBox(width: 15.0,),
                         Row(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             const Icon(Icons.access_time_outlined,color: Color(0xFFF9C594),size: 18,),
                             const SizedBox(width: 4,),
                             Text("${'time_till'.tr} : ",
                               textAlign: TextAlign.center,
                               style: GoogleFonts.inter(
                                 fontSize: Dimensions.fontSizeDefault,
                                 fontWeight: FontWeight.w500,
                                 color: ThemeColors.whiteColor,
                               ),
                             ),
                             // Text(DateFormat("h:mm a").format(DateTime.parse(widget.assignTaskDate.toString())),
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
          body: _isLoading ? _taskList != null ? RefreshIndicator(
            onRefresh: () async {
              await Get.find<TaskController>().getTask(widget.assignTaskDate);
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('dont_wait_just_complete'.tr,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: Dimensions.fontSizeExtraLarge,
                        fontWeight: FontWeight.w600,
                        color: ThemeColors.blackColor,
                      ),
                    ),

                    const SizedBox(height: 15.0,),

                    Container(
                      width: MediaQuery.of(context).size.width/6,
                      height: 30,
                      decoration: BoxDecoration(
                        color: ThemeColors.card3Color,
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
                      child: Center(
                        child: Text('task'.tr,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: Dimensions.fontSizeLarge,
                            fontWeight: FontWeight.w600,
                            color: ThemeColors.blackColor,
                          ),
                        ),
                      ),
                    ),

                    ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        padding:
                        const EdgeInsets.only(top: 15, bottom: 15, left: 0, right: 10),
                        itemCount: _taskList!.taskList!.length,
                        itemBuilder: (context, index) {
                          int indesId = index + 1;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: InkWell(

                              onTap: () =>
                              (DateFormat("d\nMMMM").format(DateTime.parse(_taskList!.taskList![index].assignedAt.toString())) == DateFormat("d\nMMMM").format(DateTime.now())) ?
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>TaskDetailScreen(taskId: indesId,taskList: _taskList!.taskList![index],)))
                              : null,
                                  // : null,
                              child: Card(
                                // elevation: 4,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                      color: Colors.grey.withOpacity(0.4),
                                    )),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    title: Text("${"task".tr} #${indesId}",
                                      style: GoogleFonts.inter(
                                        fontSize: Dimensions.fontSizeOverLarge,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Text(_taskList!.taskList![index].task!.title ?? "",
                                        style: GoogleFonts.inter(
                                          fontSize: Dimensions.fontSizeSmall,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    trailing:
                                    (_taskList!.taskList![index].completedAt != null && _taskList!.taskList![index].verifiedAt != null) ?
                                    Stack(
                                      children: [
                                        IconButton(
                                          onPressed: (){
                                          },
                                          icon: const Icon(Icons.circle_outlined,
                                            color: ThemeColors.card2Color,
                                            size: 20,),
                                        ),
                                        const Positioned(
                                          top: 10,
                                          right: 10,
                                            child: Icon(Icons.check,color: ThemeColors.blackColor,)),
                                      ],
                                    )
                                        : const Icon(Icons.arrow_forward_ios)

                                  ),
                                ),
                              ),
                            ),
                          );
                        }),

                    const SizedBox(height: 10.0,),

                    Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3F3849),
                        borderRadius: BorderRadius.circular(
                            Dimensions.RADIUS_EXTRA_EXTRA_LARGE),
                        boxShadow: const [
                          BoxShadow(
                            color: ThemeColors.greyTextColor,
                            blurRadius: 2,
                            spreadRadius: 0.3,
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: LinearPercentIndicator(
                                // width: MediaQuery.of(context).size.width/2,
                                barRadius: const Radius.circular(20),
                                restartAnimation: true,
                                lineHeight: 14.0,
                                percent: double.parse(_taskList!.taskProgess.toString()),
                                backgroundColor: const Color(0xFF2F273B),
                                progressColor: const Color(0xFFE5FF7F),
                              ),
                            ),

                            Text('${percentage!.toStringAsFixed(0)}%'.tr,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: Dimensions.fontSizeExtraLarge,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFE5FF7F),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
              :Text('No Assigned Task'.tr,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: Dimensions.fontSizeOverLarge,
              fontWeight: FontWeight.w600,
              color: ThemeColors.whiteColor,
            ),
          )   : const Center(child: CircularProgressIndicator(color: ThemeColors.primaryColor,),),
        );
      }
    );
  }
}
