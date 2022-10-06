import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final String title;
  final VoidCallback? onTap;
  final double radius;
  final double height;
  final double fontSize;
  final FontWeight fontWeight;
  final Color buttonColor;
  final Color borderColor;
  final Widget? icon;
  final Color titleColor;
  const CustomButton(
      {required this.title,
      this.height = 50,
      this.width = 100,
      this.buttonColor = Colors.white,
      this.fontSize = 18,
      required this.onTap,
      this.radius = 15,
      Key? key,
      this.titleColor = Colors.white,
      this.fontWeight = FontWeight.w600,
      this.icon,
      this.borderColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(width: .01.w, color: borderColor),
        borderRadius: BorderRadius.circular(radius.h),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              side: BorderSide(
                  // style: BorderStyle.solid,
                  color: borderColor,
                  width: 1), // <-- this doesn't work?
              borderRadius: BorderRadius.all(Radius.circular(radius.h)),
            ),
          ),
          padding:
              MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
          elevation: MaterialStateProperty.resolveWith<double>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return 0;
            }
            if (states.contains(MaterialState.focused)) {
              return 0;
            }
            if (states.contains(MaterialState.hovered)) {
              return 0;
            }
            return 0;
          }),
        ),
        // style: ElevatedButton.styleFrom(
        //         elevation: 0,
        //         primary: butcolor,
        //         onPrimary: Colors.white.withOpacity(.1),
        //         onSurface: Colors.orange,
        //         //specify the button's disabled text, icon, and fill color
        //         side: BorderSide(color: borderColor, width: 2),
        //         shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(radius.h)))
        //     .copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
        onPressed: onTap,
        child: Center(
          child: Padding(
            padding:  EdgeInsets.only(top: .6.h),
            child: CustomText(
              text: title,
              size: fontSize,
              weight: fontWeight,
              color: titleColor,
            ),
          ),
        ),
      ),
    );
  }
}
