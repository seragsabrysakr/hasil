import 'package:flutter/material.dart';
import 'package:hassel/shared/app_utils/app_fonts.dart';
import 'package:sizer/sizer.dart';

class CustomText extends StatelessWidget {
  final String text;
  double? size;
  int? maxLines;
  FontWeight? weight;
  Color? color;
  TextDecoration? decoration;
  CustomText(
      {required this.text,
      this.color = Colors.black,
      this.weight,
      this.maxLines = 1,
      this.decoration = TextDecoration.none,
      this.size,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      style: TextStyle(
          overflow: TextOverflow.ellipsis,
          decoration: decoration,
          fontSize: size,
          fontFamily: AppFonts.fontFamily,
          height: .7.sp,
          fontWeight: weight,
          color: color),
    );
  }
}
