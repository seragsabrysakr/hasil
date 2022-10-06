
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hassel/app.dart';
import 'package:hassel/shared/app_utils/app_colors.dart';
import 'package:hassel/shared/app_utils/app_text_style.dart';
import 'package:hassel/shared/app_widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class SliderImageItem extends StatefulWidget {
  final String photo;
  const SliderImageItem( this.photo, {Key? key}) : super(key: key);

  @override
  State<SliderImageItem> createState() => _SliderImageItemState();
}

class _SliderImageItemState extends State<SliderImageItem> {
  bool animate = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            width: 80.w,
            height: 65.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.green),
              image: DecorationImage(image:AssetImage(widget.photo),fit: BoxFit.cover )
            ),
          ),
        ),
        PositionedDirectional(
          start: 5.w,
          top: 3.5.h,
          child: CircleAvatar(
            radius:5.h,
            backgroundColor: AppColors.primaryColor,
            child: Text(
              App.tr.appName,
              style: AppTextStyle.getRegularStyle(color: Colors.white,fontSize: 14.sp),
            )
          ),
        ),
        PositionedDirectional(
          end: 5.w,
          top: 1.h,
          child: CircleAvatar(
            radius: 4.h,
            backgroundColor: AppColors.primaryColor,
            child: CircleAvatar(
              radius: 3.2.h,
              backgroundColor: Colors.white,
            ),
          ),
        ),
        PositionedDirectional(
          start: 9.w,
          bottom: 5.h,
          child: CircleAvatar(
            radius: 2.1.h,
            backgroundColor: AppColors.primaryColor,
            child: CircleAvatar(
              radius: 1.4.h,
              backgroundColor: Colors.white,
            ),
          ),
        ),
        PositionedDirectional(
          end: 8.w,
          bottom: 9.h,
          child: CircleAvatar(
            radius: 1.3.h,
            backgroundColor: AppColors.primaryColor,

          ),
        ),
      ],
    );
  }
}