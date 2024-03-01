import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_pro/controller/auth_controller.dart';
import 'package:task_pro/controller/profile_controller.dart';
import 'package:task_pro/controller/task_controller.dart';
import 'package:task_pro/data/api/api_client.dart';
import 'package:task_pro/data/model/profile_model.dart';
import 'package:task_pro/data/model/task_model.dart';
import 'package:task_pro/helper/route_helper.dart';
import 'package:task_pro/util/dimensions.dart';
import 'package:task_pro/util/theme_colors.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'app_button.dart';
import 'custom_snackbar.dart';

class CustomDialog extends StatelessWidget {
  final TaskListModel? taskData;
  CustomDialog({required this.taskData});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 0.0, right: 0.0),
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
                top: 10.0, bottom: 20, left: 10, right: 10),
            // margin: EdgeInsets.only(top: 13.0, right: 8.0),
            decoration: BoxDecoration(
                color: ThemeColors.whiteColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 0.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "review".tr,
                    style: GoogleFonts.inter(
                        fontSize: Dimensions.fontSizeOverLarge,
                        fontWeight: FontWeight.w700,
                        color: ThemeColors.blackColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 15.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 0.5, color: ThemeColors.greyTextColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        taskData!.task!.comments![0].comment ?? "",
                        style: GoogleFonts.inter(
                            fontSize: Dimensions.fontSizeDefault,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF6C748F)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Container(
                  height: 40,
                  width: 150,
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: AppButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(
                              text: taskData!.task!.comments![0].comment ?? ""))
                          .then((_) {
                        showCustomSnackBar('Coupon Code Copied.',
                            isError: false);
                      });
                    },
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    icon: const Icon(
                      Icons.copy,
                      size: 20,
                    ),
                    text: Text(
                      'copy_text'.tr,
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: Dimensions.fontSizeLarge,
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
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 40,
                  width: 150,
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: AppButton(
                    onPressed: () async {
                      String url = taskData!.task!.url ?? "";
                      if (await canLaunchUrlString(url)) {
                        launchUrlString(url);
                      } else {
                        showCustomSnackBar('${'can_not_launch'.tr} $url');
                      }
                    },
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    icon: const Icon(
                      Icons.arrow_forward,
                      size: 20,
                      color: ThemeColors.primaryColor,
                    ),
                    text: Text(
                      'add_review'.tr,
                      style: GoogleFonts.inter(
                          color: ThemeColors.primaryColor,
                          fontSize: Dimensions.fontSizeLarge,
                          fontWeight: FontWeight.w600),
                    ),
                    loading: true,
                    color: ThemeColors.whiteColor,
                    borderColor: ThemeColors.primaryColor,
                    textColor: ThemeColors.blackColor,
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(
                          color: ThemeColors.primaryColor, width: 1),
                      backgroundColor: ThemeColors.whiteColor,
                      // color:Colors.red,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 15.0,
            top: 18.0,
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.cancel, color: Colors.black)),
          ),
        ],
      ),
    );
  }
}


class ValidityReasonDialog extends StatelessWidget {
  ValidityReasonDialog({super.key,required this.isActive});
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 0.0, right: 0.0),
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
                top: 10.0, bottom: 20, left: 10, right: 10),
            // margin: EdgeInsets.only(top: 13.0, right: 8.0),
            decoration: BoxDecoration(
                color: ThemeColors.whiteColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 0.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("task_pro_validity".tr,style: GoogleFonts.montserrat(
                                        fontSize: Dimensions.fontSizeLarge,
                                        color: ThemeColors.blackColor,
                                        fontWeight: FontWeight.w700
                                    ),),
                                    const SizedBox(width: 2.0,),
                                    // Text("(valid for 2 months)",style: GoogleFonts.montserrat(
                                    //   fontSize: Dimensions.fontSizeExtraSmall,
                                    //   color: ThemeColors.greyTextColor,
                                    // ),),
                                  ],
                                ),
                                const SizedBox(height: 5.0,),

                                Row(
                                  children: [
                                    Text("Start from: ",style: GoogleFonts.montserrat(
                                        fontSize: Dimensions.fontSizeDefault,
                                        fontWeight: FontWeight.w600,
                                        color: ThemeColors.greyTextColor
                                    ),),
                                    Text("36/1/2024",style: GoogleFonts.montserrat(
                                        fontSize: Dimensions.fontSizeDefault,
                                        fontWeight: FontWeight.w600,
                                        color: ThemeColors.primaryColor
                                    ),),

                                  ],
                                ),

                                Row(
                                  children: [
                                    Text("Expire on: ",style: GoogleFonts.montserrat(
                                        fontSize: Dimensions.fontSizeDefault,
                                        fontWeight: FontWeight.w600,
                                        color: ThemeColors.greyTextColor
                                    ),),
                                    Text("36/1/2024",style: GoogleFonts.montserrat(
                                        fontSize: Dimensions.fontSizeDefault,
                                        fontWeight: FontWeight.w600,
                                        color: ThemeColors.primaryColor
                                    ),),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 15,
                        child: Row(
                          children: [
                            Icon(Icons.circle,size: 10,color: isActive ? ThemeColors.primaryColor : ThemeColors.redColor,),
                            const SizedBox(width: 2.0,),
                            Text(isActive ? "Active" : "Expired",style: GoogleFonts.montserrat(
                                fontSize: Dimensions.fontSizeDefault,
                                color: ThemeColors.blackColor,
                                fontWeight: FontWeight.w700
                            ),),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Reason".tr,
                    style: GoogleFonts.inter(
                        fontSize: Dimensions.fontSizeOverLarge,
                        fontWeight: FontWeight.w700,
                        color: ThemeColors.primaryColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 15.0,
            top: 5.0,
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.cancel, color: Colors.black)),
          ),
        ],
      ),
    );
  }
}


class LogOutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 0.0, right: 0.0),
      child: Stack(
        children: <Widget>[
          Container(
            padding:
            const EdgeInsets.only(top: 10.0, bottom: 20, left: 10, right: 10),
            // margin: EdgeInsets.only(top: 13.0, right: 8.0),
            decoration: BoxDecoration(
                color: ThemeColors.whiteColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 0.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 20.0,
                ),
                Center(
                    child: Padding(
                      padding:const EdgeInsets.all(10.0),
                      child: Text(
                        "logout_from_task_pro".tr,
                        style:const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Montserrat",
                            color: ThemeColors.blackColor),
                      ),
                    ) //
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Container(
                        height: 35,
                        width: 150,
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: AppButton(
                          onPressed: () {
                            Get.find<AuthController>().clearUserNumber();
                            Get.find<AuthController>().clearUserToken();
                            Get.find<ApiClient>().updateHeader("", "");

                            Get.offAllNamed(RouteHelper.getLoginRoute());
                          },
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(50))),
                          text:  Text(
                            'yes'.tr,
                            style:const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'OpenSans-ExtraBold',
                                fontWeight: FontWeight.w700),
                          ),
                          loading: true,
                          color: ThemeColors.whiteColor,
                          borderColor: ThemeColors.primaryColor,
                          textColor: ThemeColors.blackColor,
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(
                                color: ThemeColors.primaryColor, width: 1),
                            backgroundColor: ThemeColors.whiteColor,
                            // color:Colors.red,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8))),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        height: 35,
                        width: 150,
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: AppButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(50))),
                          text:  Text(
                            'no'.tr,
                            style:const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'OpenSans-ExtraBold',
                                fontWeight: FontWeight.w700),
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
                                borderRadius:
                                BorderRadius.all(Radius.circular(8))),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: 15.0,
            top: 18.0,
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.cancel, color: Colors.black)),
          ),
        ],
      ),
    );
  }
}


class UploadDialog extends StatelessWidget {
  const UploadDialog({super.key, required this.capturePath});
  final dynamic capturePath;


  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 0.0, right: 0.0),
      child: Stack(
        children: <Widget>[
          Container(
            padding:
            const EdgeInsets.only(top: 10.0, bottom: 20, left: 10, right: 10),
            // margin: EdgeInsets.only(top: 13.0, right: 8.0),
            decoration: BoxDecoration(
                color: ThemeColors.whiteColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 0.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 20.0,
                ),
                Center(
                    child: Padding(
                      padding:const EdgeInsets.all(10.0),
                      child: Text(
                        "are_you_sure_you_want_to_upload".tr,
                        style:const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Montserrat",
                            color: ThemeColors.blackColor),
                      ),
                    ) //
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Container(
                        height: 35,
                        width: 150,
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: AppButton(
                          onPressed: () async {
                            // final capturedImage = await _screenshotController.capture();
                            // print(capturedImage);
                            String imagePath = await Get.find<TaskController>().saveImage(capturePath!,);
                            print(imagePath);
                            Navigator.pop(context, imagePath);
                          },
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(50))),
                          text:  Text(
                            'yes'.tr,
                            style:const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'OpenSans-ExtraBold',
                                fontWeight: FontWeight.w700),
                          ),
                          loading: true,
                          color: ThemeColors.whiteColor,
                          borderColor: ThemeColors.primaryColor,
                          textColor: ThemeColors.blackColor,
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(
                                color: ThemeColors.primaryColor, width: 1),
                            backgroundColor: ThemeColors.whiteColor,
                            // color:Colors.red,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8))),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        height: 35,
                        width: 150,
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: AppButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(50))),
                          text:  Text(
                            'no'.tr,
                            style:const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'OpenSans-ExtraBold',
                                fontWeight: FontWeight.w700),
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
                                borderRadius:
                                BorderRadius.all(Radius.circular(8))),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: 15.0,
            top: 18.0,
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.cancel, color: Colors.black)),
          ),
        ],
      ),
    );
  }
}


class DeleteDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 0.0, right: 0.0),
      child: Stack(
        children: <Widget>[
          Container(
            padding:
            const EdgeInsets.only(top: 10.0, bottom: 20, left: 10, right: 10),
            // margin: EdgeInsets.only(top: 13.0, right: 8.0),
            decoration: BoxDecoration(
                color: ThemeColors.whiteColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 0.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 20.0,
                ),
                Center(
                    child: Padding(
                      padding:const EdgeInsets.all(10.0),
                      child: Text(
                        "are_you_sure_delete_acc".tr,
                        style:const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Montserrat",
                            color: ThemeColors.blackColor),
                      ),
                    ) //
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Container(
                        height: 35,
                        width: 150,
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: AppButton(
                          onPressed: () async{
                            ProfileModel? _profileData;
                            Model? data;

                            _profileData = await Get.find<ProfileController>().profileData;
                            if (_profileData == null) {
                              _profileData = await Get.find<ProfileController>().getProfileData();
                              data = await Get.find<ProfileController>().deleteAccount(_profileData.mobileNo.toString());
                            }else{
                              data = await Get.find<ProfileController>().deleteAccount(_profileData.mobileNo.toString());
                            }
                            showCustomSnackBar(data.message!, isError: false);

                            if(data.success == true) {
                              Get.find<AuthController>().clearUserNumber();
                              Get.find<AuthController>().clearUserToken();
                              Get.find<ApiClient>().updateHeader("", "");

                              Get.offAllNamed(RouteHelper.getLoginRoute());
                            }
                          },
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(50))),
                          text:  Text(
                            'yes'.tr,
                            style:const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'OpenSans-ExtraBold',
                                fontWeight: FontWeight.w700),
                          ),
                          loading: true,
                          color: ThemeColors.whiteColor,
                          borderColor: ThemeColors.primaryColor,
                          textColor: ThemeColors.blackColor,
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(
                                color: ThemeColors.primaryColor, width: 1),
                            backgroundColor: ThemeColors.whiteColor,
                            // color:Colors.red,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8))),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        height: 35,
                        width: 150,
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: AppButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(50))),
                          text:  Text(
                            'no'.tr,
                            style:const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'OpenSans-ExtraBold',
                                fontWeight: FontWeight.w700),
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
                                borderRadius:
                                BorderRadius.all(Radius.circular(8))),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: 15.0,
            top: 18.0,
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.cancel, color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
