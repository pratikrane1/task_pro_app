import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_pro/util/theme_colors.dart';

import '../../util/dimensions.dart';
import 'custom_image.dart';

class ImageViewWidget extends StatelessWidget {
  const ImageViewWidget({required this.imageUrl,super.key});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.secondaryColor,
        title:  Text('image'.tr,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: Dimensions.fontSizeOverLarge,
            fontWeight: FontWeight.w600,
            color: ThemeColors.whiteColor,
          ),
        ),
        centerTitle: true,
      ),
      body:  Center(
        child: CustomImage(
          image: imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
