import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_pro/util/images.dart';

class CustomImage extends StatelessWidget {
  final String? image;
  final double? height;
  final double? width;
  final BoxFit? fit;
  bool fromProfile;
  CustomImage({@required this.image, this.height, this.width, this.fit,this.fromProfile=false});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image!,
      height: height,
      width: width,
      fit: fit != null ? fit : BoxFit.fitHeight,
      placeholder: (context, url) => fromProfile ? SvgPicture.asset(
        Images.profile_logo, height: 25,
        // color: ThemeColors.greyTextColor,
      ) : Image.asset(Images.placeholder,
          height: height, width: width, fit: fit),
      errorWidget: (context, url, error) =>fromProfile ? SvgPicture.asset(
        Images.profile_logo, height: 25,
        // color: ThemeColors.greyTextColor,
      ) :  Image.asset(Images.placeholder,
          height: height, width: width, fit: fit),
    );
  }
}
