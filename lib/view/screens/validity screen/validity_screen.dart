import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_pro/controller/auth_controller.dart';
import 'package:task_pro/controller/profile_controller.dart';
import 'package:task_pro/controller/validity_controller.dart';
import 'package:task_pro/data/model/validity_model.dart';
import 'package:task_pro/util/dimensions.dart';
import 'package:task_pro/util/theme_colors.dart';
import 'package:task_pro/view/base/google_ads.dart';
import 'package:task_pro/view/screens/validity%20screen/widget/validity_card_widget.dart';

class ValidityScreen extends StatefulWidget {
  const ValidityScreen({super.key});

  @override
  State<ValidityScreen> createState() => _ValidityScreenState();
}

class _ValidityScreenState extends State<ValidityScreen> {
  bool _isLoading = false;
  TaskProValidityHistory? _taskProDashValidityHistory;
  // List<>


  @override
  void initState(){
    super.initState();
    Googleads().initializeFullPageAd();
    Get.find<ValidityController>().getTaskProValidityHistory(Get.find<ProfileController>().profileData!.gainzProUserId.toString());
    // Get.find<ValidityController>().getTaskProValidityHistory("2160");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 100,
        backgroundColor: ThemeColors.secondaryColor,
        title: Text(
          'task_pro_validity'.tr,
          style: GoogleFonts.inter(
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          splashRadius: 20,
          onPressed: () async {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 24,
          ),
        ),
        centerTitle: false,
        elevation: 0.0,
        bottomOpacity: 0.0,
      ),
      body: GetBuilder<ValidityController>(builder: (validityController) {
        _isLoading = validityController.isLoading;
        _taskProDashValidityHistory = validityController.taskProDashValidityHistory;
        return _isLoading ? _taskProDashValidityHistory != null ? SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _taskProDashValidityHistory!.activeValidity!.isNotEmpty ?
                  Text("current".tr,style: GoogleFonts.montserrat(
                      fontSize: Dimensions.fontSizeLarge,
                      fontWeight: FontWeight.w700,
                      color: ThemeColors.blackColor

                  ),) : const SizedBox(),

                  const SizedBox(height: 10.0,),

                  ListView.builder(
                      keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior
                          .onDrag,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: _taskProDashValidityHistory!.activeValidity!.length,
                      itemBuilder: (context, index){
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ValidityCard(isActive: false,activeValidity: _taskProDashValidityHistory!.activeValidity![index]),
                        );
                      }),


                  // const ValidityCard(isActive: true),

                  const SizedBox(height: 10.0,),

                  _taskProDashValidityHistory!.expiredValidity!.isNotEmpty ?
                  Text("last_validity".tr,style: GoogleFonts.montserrat(
                      fontSize: Dimensions.fontSizeLarge,
                      fontWeight: FontWeight.w700,
                      color: ThemeColors.blackColor

                  ),): const SizedBox(),

                  ListView.builder(
                      keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior
                          .onDrag,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      // padding: const EdgeInsets.only(
                      //     top: 0,
                      //     bottom: 15,
                      //     // left: 10,
                      //     // right: 10,
                      // ),
                      itemCount: _taskProDashValidityHistory!.expiredValidity!.length,
                      itemBuilder: (context, index){
                        return Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: ValidityCard(isActive: false,activeValidity: _taskProDashValidityHistory!.expiredValidity![index]),
                        );
                      }) ,

                ],
              ),
            ),
          )
            : const SizedBox()
            : const Center(child: CircularProgressIndicator(color: ThemeColors.primaryColor,),);
        }
      ),

    );
  }
}
