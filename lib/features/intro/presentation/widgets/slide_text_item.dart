import 'package:flutter/material.dart';
import 'package:hassel/shared/app_utils/app_colors.dart';
import 'package:hassel/shared/app_utils/app_fonts.dart';
import 'package:hassel/shared/app_utils/app_sized_box.dart';
import 'package:hassel/shared/app_utils/app_text_style.dart';
import 'package:hassel/shared/app_widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class SliderTextItem extends StatelessWidget {
  const SliderTextItem(
      {Key? key, required this.h1, required this.h2, this.h4, this.h3})
      : super(key: key);
  final String? h4;
  final String h1;
  final String h2;
  final String? h3;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(h1,

            style: AppTextStyle.getSemiBoldStyle(

                color: AppColors.headerColor, fontSize: FontSize.s24.sp)),
        Text(h2,
            style: AppTextStyle.getSemiBoldStyle(
                color: AppColors.headerColor, fontSize: FontSize.s24.sp)),
        Text(h3??'',
            style: AppTextStyle.getSemiBoldStyle(
                color: AppColors.headerColor, fontSize: FontSize.s24.sp)),
        AppSizedBox.s4,
        Text(h4??'',
            style: AppTextStyle.getMediumStyle(
                color: AppColors.subTitle, fontSize: 11.sp)),

      ],
    );
  }
}
