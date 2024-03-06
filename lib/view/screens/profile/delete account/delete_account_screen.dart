import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_pro/controller/profile_controller.dart';
import 'package:task_pro/util/dimensions.dart';
import 'package:task_pro/util/theme_colors.dart';
import 'package:task_pro/view/base/custome_dialog.dart';

class DeleteAcooountScreen extends StatefulWidget {
  const DeleteAcooountScreen({super.key});

  @override
  State<DeleteAcooountScreen> createState() => _DeleteAcooountScreenState();
}

class _DeleteAcooountScreenState extends State<DeleteAcooountScreen> {
  String? deleteData;

  @override
  void initState() {
    super.initState();
    Get.find<ProfileController>().getDeleteAccData();
  }


  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.only(left: 20.0,bottom: 15.0,right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("delete_account".tr,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: Dimensions.fontSizeOverOverLarge,
                    fontWeight: FontWeight.w600,
                    color: ThemeColors.whiteColor,
                  ),
                ),
                InkWell(
                  onTap: (){
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => DeleteDialog());
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: ThemeColors.redColor,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text("delete".tr,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: Dimensions.fontSizeExtraLarge,
                            fontWeight: FontWeight.w600,
                            color: ThemeColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
        body: GetBuilder<ProfileController>(builder: (profileController) {
          deleteData = profileController.deleteAccData;
          return deleteData!.isNotEmpty
              ? SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  borderRadius:
                  BorderRadius.all(Radius.circular(15)),
                  // color: ThemeColors.greyTextColor.withOpacity(0.13),
                ),
                child: Html(
                  data: deleteData,
                ),
              ),
            ),
          )
              : const Center(
            child: CircularProgressIndicator(color: ThemeColors.primaryColor,),
          );
        })

    );
  }
}
