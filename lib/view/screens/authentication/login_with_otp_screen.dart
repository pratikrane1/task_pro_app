import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:task_pro/controller/auth_controller.dart';
import 'package:task_pro/util/constants.dart';
import 'package:task_pro/util/dimensions.dart';
import 'package:task_pro/util/theme_colors.dart';
import 'package:task_pro/view/base/app_button.dart';
import 'package:task_pro/view/base/custom_snackbar.dart';

import 'otp_verification_screen.dart';

class LoginWithOTPScreen extends StatefulWidget {
  const LoginWithOTPScreen({super.key});

  @override
  State<LoginWithOTPScreen> createState() => _LoginWithOTPScreenState();
}

class _LoginWithOTPScreenState extends State<LoginWithOTPScreen> {
  TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? phone;
  String authStatus = "";
  bool loading = true;


  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(milliseconds: 300), _tryPasteCurrentPhone);
  }

  Future _tryPasteCurrentPhone() async {
    if (!mounted) return;
    try {
      final autoFill = SmsAutoFill();
      final phone = await autoFill.hint;
      if (phone == null) return;
      if (!mounted) return;
      phoneController.text = phone;
    } on PlatformException catch (e) {
      print('Failed to get mobile number because of: ${e.message}');
    }
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
              child: Form(
                key: formKey,
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

                          Text("logi_with_otp".tr,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: Dimensions.fontSizeOverLarge,
                              fontWeight: FontWeight.w600,
                              color: ThemeColors.whiteColor,
                            ),
                          ),
                          const SizedBox(height: 10,),

                          Text("enter_your_registered_mobile_number".tr,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: Dimensions.fontSizeDefault,
                              fontWeight: FontWeight.w500,
                              color: ThemeColors.greyTextColor,
                            ),
                          ),
                          const SizedBox(height: 25,),

                          Text("mobile_no".tr,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: Dimensions.fontSizeDefault,
                              fontWeight: FontWeight.w500,
                              color: ThemeColors.whiteColor,
                            ),
                          ),
                          const SizedBox(height: 10,),

                          ///Mobile number field
                          TextFormField(
                            scrollPadding: EdgeInsets.only(
                                bottom:
                                MediaQuery.of(context).viewInsets.bottom),
                            controller: phoneController,
                            textAlign: TextAlign.start,
                            textAlignVertical: TextAlignVertical.top,
                            style:
                            Theme.of(context).textTheme.headline3!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: ThemeColors.blackColor,
                              fontSize: 20,
                            ),
                            cursorColor: kOrangeColor,
                            autofocus: false,
                            autocorrect: false,
                            keyboardType: TextInputType.number,
                            obscureText: false,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              fillColor: ThemeColors.whiteColor,
                              filled: true,
                              hintText: 'enter_mobile_number'.tr,
                              hintStyle: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 17,
                                  color: ThemeColors.greyTextColor),
                              focusedErrorBorder: kFocusedErrorBorder,
                              errorBorder: kErrorBorder,
                              enabledBorder: kEnabledBorder,
                              focusedBorder: kFocusedBorder,
                              border: kBorder,
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'phone_number_required'.tr;
                              }
                              return null;
                            },
                          ),


                          const SizedBox(height: 25,),

                          Padding(
                            padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10),
                            child: AppButton(
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  if (phoneController.text != null) {
                                    // String? num = phoneController.text.trim();
                                    phone = phoneController.text.trim();
                                    // phone = num.substring(num.length - 10);
                                  }
                                  if (phone!.length < 10) {
                                    showCustomSnackBar('please_enter_10_digit_number'.tr);
                                  } else if (phone!.length > 13) {
                                    showCustomSnackBar('please_enter_valid_number'.tr);
                                  } else if (phone!.isEmpty) {
                                    showCustomSnackBar('please_enter_phone_number'.tr);
                                  }else{
                                    setState(() {
                                      loading = false;
                                    });

                                    _login(authController, phoneController.text.trim());

                                  }
                                }

                                // Get.to(OTPVerificationScreen());
                              },
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              text: Text(
                                'otp'.tr,
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
            ),
          );
        }
      ),
    );
  }

  void _login(AuthController authController,String number) async {
    String _numberWithCountryCode = number.length > 10 ? number : "${ '+91' + number}"  ;
    // String _numberWithCountryCode = number;

    var logData = await authController
        .login(
        _numberWithCountryCode, "123456", "1"
    )
        .then((status) {
      if (status.status == true) {
        setState(() {
          // _verifyNumber = true;
        });
        showCustomSnackBar(status.message!, isError: false);

        Get.to(()=> OTPVerificationScreen(mobileNumber: _numberWithCountryCode,));

      } else {
        showCustomSnackBar(status.message!, isError: true);

        authController.clearUserNumber();
        setState(() {
          loading = true;
        });
      }
      setState(() {
        loading = authController.isLoading;
      });
    });
    print(logData);
  }

}
