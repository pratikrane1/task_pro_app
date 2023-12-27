import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_pro/controller/task_controller.dart';
import 'package:task_pro/data/model/all_task_model.dart';
import 'package:task_pro/util/dimensions.dart';
import 'package:intl/intl.dart';
import 'package:task_pro/util/theme_colors.dart';
import 'package:task_pro/view/screens/task/task_detail_screen.dart';
import 'package:task_pro/view/screens/task/task_screen.dart';

class AllTaskScreen extends StatefulWidget {
  const AllTaskScreen({super.key});

  @override
  State<AllTaskScreen> createState() => _AllTaskScreenState();
}

class _AllTaskScreenState extends State<AllTaskScreen> {
  List<AllTaskModel>? _allTaskList;
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    Get.find<TaskController>().getAllTaskList("all");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.secondaryColor,
        title:  Text('all_task'.tr,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: Dimensions.fontSizeOverLarge,
            fontWeight: FontWeight.w600,
            color: ThemeColors.whiteColor,
          ),
        ),
        centerTitle: true,
        // bottom: PreferredSize(
        //   preferredSize: const Size.fromHeight(kToolbarHeight),
        //   child: Padding(
        //     padding: const EdgeInsets.only(left: 20.0,bottom: 15.0),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Row(
        //           children: [
        //             Text('all_task'.tr,
        //               textAlign: TextAlign.center,
        //               style: GoogleFonts.inter(
        //                 fontSize: Dimensions.fontSizeOverLarge,
        //                 fontWeight: FontWeight.w600,
        //                 color: ThemeColors.whiteColor,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ),

      body: GetBuilder<TaskController>(builder: (taskController) {
        _allTaskList = taskController.allTaskListScreen;
        _isLoading = taskController.isGetAllTaskLoading;
          return _isLoading ? _allTaskList!.isNotEmpty ? RefreshIndicator(
            onRefresh: () async {
              await Get.find<TaskController>().getAllTaskList("all");
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  padding:
                  const EdgeInsets.only(top: 15, bottom: 15, left: 0, right: 10),
                  itemCount: _allTaskList!.length,
                  itemBuilder: (context, index) {
                    int indesId = index + 1;
                    return InkWell(
                      onTap: () =>
                      (DateFormat("d\nMMMM").format(DateTime.parse(_allTaskList![index].assignedAt.toString())) == DateFormat("d\nMMMM").format(DateTime.now())) ?
                                    Get.to(()=>TaskScreen(assignTaskDate: _allTaskList![index].assignedAt.toString(),))
                          : null,
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: Theme.of(context).cardColor,
                            )),
                        child: ListTile(
                          title: Text(DateFormat("d MMMM yyyy").format(DateTime.parse(_allTaskList![index].assignedAt.toString())),
                            style: GoogleFonts.inter(
                              fontSize: Dimensions.fontSizeExtraLarge,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          subtitle: Row(
                            children: [
                              (DateFormat("d\nMMMM").format(DateTime.parse(_allTaskList![index].assignedAt.toString())) == DateFormat("d\nMMMM").format(DateTime.now())) ?
                              Text( "Open for Today",
                                style: GoogleFonts.inter(
                                  fontSize: Dimensions.fontSizeDefault,
                                  fontWeight: FontWeight.w500,
                                ),
                              ) : Text( "Closed",
                                style: GoogleFonts.inter(
                                  color: ThemeColors.redColor,
                                  fontSize: Dimensions.fontSizeDefault,
                                  fontWeight: FontWeight.w500,
                                ),
                              ) ,
                              const SizedBox(width: 2.0,),
                              (DateFormat("d\nMMMM").format(DateTime.parse(_allTaskList![index].assignedAt.toString())) == DateFormat("d\nMMMM").format(DateTime.now())) ?
                              const Icon(Icons.electric_bolt,
                                color: ThemeColors.orangeColor,
                                size: 15,):  const Icon(Icons.lock_outline_sharp,
                                color: ThemeColors.redColor,
                                size: 15,)
                            ],
                          ),
                          trailing: Stack(
                            children: [
                              Text('${_allTaskList![index].completedTask}/${_allTaskList![index].taskList!.length} Task'.tr,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: Dimensions.fontSizeExtraLarge,
                                  fontWeight: FontWeight.w400,
                                  color: ThemeColors.blackColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),

            ),
          )
          : Center(
            child: Text('No Task Available'.tr,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: Dimensions.fontSizeOverLarge,
                fontWeight: FontWeight.w600,
                color: ThemeColors.blackColor,
              ),
            ),
          )
            : const Center(child: CircularProgressIndicator(color: ThemeColors.primaryColor,),) ;
        }
      ),

    );
  }
}
