import 'package:khuthon_2024/app/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final double? width;
  final double? height;
  final String? content;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  final Color? bgColor;
  final BorderRadius? borderRadius;
  final Border? border;
  final bool disable;

  const CustomButton({
    this.onTap,
    this.width,
    this.height,
    this.content,
    this.textColor,
    this.bgColor,
    this.borderRadius,
    this.border,
    this.fontWeight,
    this.fontSize,
    this.disable = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disable? null : onTap,
      child: Container(
        width: width ?? MediaQuery.of(context).size.width,
        height: height,
        decoration: BoxDecoration(
          color: disable ? const Color(0xFFEBDEC8) : bgColor ?? C.primary,
          border: border,
          borderRadius: borderRadius ?? BorderRadius.circular(33),
        ),
        child: Center(
          child: Text(
            content ?? "",
            style: TextStyle(
              color: textColor ?? C.background,
              fontSize: fontSize ?? 14.sp,
              fontWeight: fontWeight ?? FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
