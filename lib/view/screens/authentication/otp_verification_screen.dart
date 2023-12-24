import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:task_pro/controller/auth_controller.dart';
import 'package:task_pro/util/constants.dart';
import 'package:task_pro/util/dimensions.dart';
import 'package:task_pro/util/theme_colors.dart';
import 'package:task_pro/view/base/app_button.dart';
import 'package:task_pro/view/base/custom_snackbar.dart';
import 'package:task_pro/view/screens/bottom%20navigation/bottom_nav_bar.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({required this.mobileNumber,super.key});
  final String mobileNumber;

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  TextEditingController phoneController = TextEditingController();
  String? otpCode;
  bool loading = true;

  @override
  void initState(){
    super.initState();

  }

  @override
  void dispose() {
    // SmsAutoFill().unregisterListener();
    super.dispose();
    phoneController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.secondaryColor,
      body: GetBuilder<AuthController>(builder: (authController) {

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10,),
                  IconButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back,color: ThemeColors.whiteColor,),),

                  Padding(
                    padding: const EdgeInsets.only(left: 12.0,right: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const SizedBox(height: 10,),

                        Text("Verify OTP".tr,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: Dimensions.fontSizeOverLarge,
                            fontWeight: FontWeight.w600,
                            color: ThemeColors.whiteColor,
                          ),
                        ),
                        const SizedBox(height: 10,),

                        Text("6_digit_confirmation_code".tr,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: Dimensions.fontSizeDefault,
                            fontWeight: FontWeight.w500,
                            color: ThemeColors.greyTextColor,
                          ),
                        ),
                        const SizedBox(height: 25,),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(widget.mobileNumber.tr,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: Dimensions.fontSizeDefault,
                                fontWeight: FontWeight.w500,
                                color: ThemeColors.whiteColor,
                              ),
                            ),
                            InkWell(
                                onTap: (){
                                  Navigator.of(context).pop();
                                },
                                child: const Icon(Icons.mode_edit_outlined,color: ThemeColors.primaryColor,size: 20,))
                          ],
                        ),
                        const SizedBox(height: 10,),

                        ///Pinput field

                        Center(
                          child: Pinput(
                            length: 4,
                            defaultPinTheme: defaultPinTheme,
                            focusedPinTheme: focusedPinTheme,
                            submittedPinTheme: submittedPinTheme,
                            validator: (s) {
                              otpCode = s;
                              return s!.length <= 4 ? null : 'Enter 4 Digit Pin';
                            },
                            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                            showCursor: true,
                            onCompleted: (pin) => print(pin),
                          ),
                        ),

                        const SizedBox(height: 25,),

                        Padding(
                          padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10),
                          child: AppButton(
                            onPressed: () async {
                                if (otpCode == "") {
                                  showCustomSnackBar('please_enter_otp'.tr);
                                }else if (otpCode!.length < 4) {
                                  showCustomSnackBar('please_enter_4_digit_otp'.tr);
                                }else if (otpCode!.length > 4) {
                                  showCustomSnackBar('please_enter_4_digit_otp'.tr);
                                }else{
                                  setState(() {
                                    loading = false;
                                  });
                                  _verifyOtp(authController,widget.mobileNumber, otpCode!);
                                }
                                // setState(() {
                                //   _verifyNumber = false;
                                // });
                            },
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            text: Text(
                              'verify'.tr,
                              style: GoogleFonts.inter(
                                  color: ThemeColors.whiteColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                            loading: loading,
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                  color: ThemeColors.primaryColor, width: 1),
                              backgroundColor: ThemeColors.primaryColor,
                              // color:Colors.red,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(50))),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  void _verifyOtp(AuthController authController,String number,String otp) async {
    // String _numberWithCountryCode = number.length > 10 ? number.substring(3) : "${number}"  ;
    String _numberWithCountryCode = number.length > 10 ? number : "${ '+91' + number}"  ;

    var logData = await authController
        .verifySMSOTP(_numberWithCountryCode,otp)
        .then((status) {
      if (status.status == true) {
        // userId = status.id.toString();

        authController.saveUserToken(status.userToken.toString());
        authController.saveUserNumber(number.trim());
        authController
            .saveUserId(status.id!.toInt());
        // authController.saveUserId(85);
        showCustomSnackBar(status.message!, isError: false);
        Get.find<AuthController>().setNotificationActive(true);
        // Timer(await Duration(seconds: 5), () {
        Get.offAll(BottomNavigation(index: 0));

      } else {
        showCustomSnackBar(status.message!, isError: true);
        setState(() {
          loading = true;
        });
      }
      setState(() {
        loading = authController.isVerifyOtpLoading;
      });
    });
    print(logData);
  }

}


