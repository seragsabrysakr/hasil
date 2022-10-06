import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'app_fonts.dart';

class AppTextStyle {
  static TextStyle getTextStyle(
      double fontSize, FontWeight fontWeight, Color color,
      {double height=1.2}) {
    return TextStyle(
        fontSize: fontSize,
        height: height.sp,
        fontFamily: AppFonts.fontFamily,
        color: color,
        fontWeight: fontWeight);
  }

// regular style

  static TextStyle getRegularStyle(
      {double fontSize = FontSize.s12, required Color color,double height=1.2}) {
    return getTextStyle(fontSize, FontWeightManager.regular, color,height: height);
  }

// medium style

  static TextStyle getMediumStyle(
      {double fontSize = FontSize.s12, required Color color}) {
    return getTextStyle(fontSize, FontWeightManager.medium, color);
  }

// medium style

  static TextStyle getLightStyle(
      {double fontSize = FontSize.s12, required Color color}) {
    return getTextStyle(fontSize, FontWeightManager.light, color);
  }

// bold style

  static TextStyle getBoldStyle(
      {double fontSize = FontSize.s12, required Color color}) {
    return getTextStyle(fontSize, FontWeightManager.bold, color);
  }

// semibold style

  static TextStyle getSemiBoldStyle(
      {double fontSize = FontSize.s12, required Color color}) {
    return getTextStyle(fontSize, FontWeightManager.semiBold, color);
  }
}
