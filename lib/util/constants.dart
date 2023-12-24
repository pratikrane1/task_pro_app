import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:task_pro/util/theme_colors.dart';

const kOrangeColor = Color.fromARGB(255, 0, 137, 123);
const kOrangeColorTint = Color.fromARGB(255, 0, 137, 123);
const kOrangeColorTint2 = Color.fromARGB(255, 0, 137, 123);
const kOrangeColorTint3 = Color.fromARGB(255, 0, 137, 123);
const kBlackColor = Color(0xff0E0E0E);
const kBlackColor2 = Color.fromARGB(255, 27, 27, 27);
const kGreyColor = Color(0xff232220);
const kGreyColor2 = Color.fromARGB(255, 31, 30, 29);
const kGreyColor3 = Color.fromARGB(255, 92, 91, 90);
const kGreyColor4 = Color.fromARGB(255, 232, 233, 235);
const kGreyColor5 = Color.fromARGB(232, 200, 200, 200);
const kGreyColor6 = Color.fromARGB(232, 187, 188, 182);
const kGreyColor7 = Color.fromARGB(255, 247, 247, 247);

OutlineInputBorder kFocusedErrorBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.grey.shade800),
  borderRadius: BorderRadius.circular(10),
);
OutlineInputBorder kErrorBorder = OutlineInputBorder(
  borderSide: const BorderSide(color: kGreyColor),
  borderRadius: BorderRadius.circular(10),
);
OutlineInputBorder kEnabledBorder = const OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
  borderSide: BorderSide(color: ThemeColors.greyTextColor),
);
OutlineInputBorder kFocusedBorder = const OutlineInputBorder(
  borderSide: BorderSide(color: ThemeColors.greyTextColor),
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
);
OutlineInputBorder kBorder = const OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
);

const defaultPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
  decoration: BoxDecoration(
    // border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
    border: Border(
      bottom: BorderSide(
        width: 2,
        color: ThemeColors.whiteColor
      )
    ),
    // borderRadius: BorderRadius.circular(20),
  ),
);

final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  // border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),

  border: const Border(
    bottom: BorderSide(
      color: ThemeColors.primaryColor
    )
  ),
  // borderRadius: BorderRadius.circular(8),
);

final submittedPinTheme = defaultPinTheme.copyWith(

  decoration: defaultPinTheme.decoration?.copyWith(
    // color: const Color.fromRGBO(234, 239, 243, 1),
    border: const Border(
        bottom: BorderSide(
            color: ThemeColors.primaryColor
        )
    ),
  ),
);