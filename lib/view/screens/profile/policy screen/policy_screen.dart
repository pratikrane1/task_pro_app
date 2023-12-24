import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_pro/controller/profile_controller.dart';
import 'package:task_pro/util/dimensions.dart';
import 'package:task_pro/util/theme_colors.dart';

class PolicyScreen extends StatefulWidget {
  const PolicyScreen({required this.isPrivacyPolicy,super.key});
  final int isPrivacyPolicy;

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  String? policyData;

  @override
  void initState() {
    super.initState();
    Get.find<ProfileController>().getPolicy(widget.isPrivacyPolicy == 0 ? "1" : "0", widget.isPrivacyPolicy == 0 ? "0" : "1");
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
            padding: const EdgeInsets.only(left: 20.0,bottom: 15.0),
            child: Row(
              children: [
                Text(widget.isPrivacyPolicy == 0 ? "Privacy Policy" : "Terms and Conditions",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: Dimensions.fontSizeOverOverLarge,
                    fontWeight: FontWeight.w600,
                    color: ThemeColors.whiteColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
        body: GetBuilder<ProfileController>(builder: (profileController) {
          policyData = profileController.policyData;
          return policyData!.isNotEmpty
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
                  data: policyData,
                ),
              ),
            ),
          )
              : const Center(
            child: CircularProgressIndicator(color: ThemeColors.primaryColor,),
          );
        }));

  }
}
