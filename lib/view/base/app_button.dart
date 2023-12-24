import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Text? text;
  final bool? loading;
  final bool? disableTouchWhenLoading;
  final OutlinedBorder? shape;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  final double? height;
  final double? width;
  final ButtonStyle? style;
  final Icon? icon;

  AppButton({
    Key? key,
    this.onPressed,
    this.text,
    this.loading = false,
    this.disableTouchWhenLoading = false,
    this.shape,
    this.color,
    this.borderColor,
    this.textColor,
    this.height,
    this.width,
    this.style,
    this.icon,
  }) : super(key: key);

  Widget _buildLoading() {
    if (loading!) {
      return Container();
    }
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      width: 14,
      height: 14,
      child: const CircularProgressIndicator(
        strokeWidth: 2,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        width: width,
        child: ElevatedButton(
          style: style,
          // shape: shape,
          onPressed: disableTouchWhenLoading! && loading! ? null : onPressed,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              icon != null ? icon! : const SizedBox(),
              icon != null ? const SizedBox(width: 2.0,) : const SizedBox(),
              Flexible(child: text!), _buildLoading()],
          ),
        ));
  }
}
