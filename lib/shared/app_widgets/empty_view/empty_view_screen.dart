import 'package:flutter/material.dart';
import 'package:hassel/shared/app_utils/app_colors.dart';
import 'package:hassel/shared/app_utils/app_sized_box.dart';
import 'package:hassel/shared/app_widgets/custom_button.dart';
import 'package:sizer/sizer.dart';

import '../custom_text.dart';
import 'empty_item_model.dart';

class EmptyViewScreen extends StatelessWidget {
  final EmptyItemModel item;
  bool image;
  bool noH2;
  VoidCallback? onTap;
  String? txt;
  EmptyViewScreen(
      {Key? key,
      required this.item,
      this.onTap,
      this.txt,
      this.noH2 = false,
      this.image = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
// mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 4.h,
          width: double.infinity,
        ),
        if (image)
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Icon(
              Icons.shopping_bag_rounded,
              color: AppColors.primaryColor,
              size: 16.h,
            ),
          ),

        CustomText(
          text: '',
          weight: FontWeight.w500,
          // color: MyColors.goldColor,
          size: 15.sp,
        ),
        SizedBox(
          height: 1.h,
          width: double.infinity,
        ),
        if (!image)
          SizedBox(
            height: 20.h,
            width: double.infinity,
          ),
        SizedBox(
          height: 3.h,
          width: double.infinity,
        ),
        CustomText(
          text: item.mainTextHeader,
          weight: FontWeight.w500,
          color: AppColors.titleColor,
          size: 20.sp,
        ),
        if (image) ...[
          AppSizedBox.s1,
          CustomText(
            text: item.mainHeader ?? '',
            weight: FontWeight.w500,
            color: AppColors.titleColor,
            size: 20.sp,
          ),
        ],
        SizedBox(
          height: noH2 ? 1.5.h : 3.h,
        ),
        CustomText(
          text: item.h1,
          weight: FontWeight.w500,
          color: AppColors.subTitle,
          size: 12.sp,
        ),
        SizedBox(
          height: 1.h,
        ),
        CustomText(
          text: item.h2 ?? '',
          weight: FontWeight.w500,
          color: AppColors.subTitle,
          size: 12.sp,
        ),
        SizedBox(
          height: 1.h,
        ),
        CustomText(
          text: item.h3 ?? '',
          weight: FontWeight.w500,
          color: AppColors.subTitle,
          size: 12.sp,
        ),
        SizedBox(
          height: 30.h,
        ),

        CustomButton(
          onTap: onTap,
          fontSize: 13.sp,
          radius: .5,
          buttonColor: AppColors.primaryColor,
          titleColor: Colors.white,
          fontWeight: FontWeight.bold,
          title: txt ?? '',
          height: 6.h,
          width: 80.w,
        )
        // CustomButton(
        //   onTap: onTap,
        //   fontSize: 14.sp,
        //   // buttonColor: MyColors.goldColor,
        //   titleColor: Colors.white,
        //   fontWeight: FontWeight.w400,
        //   title: txt ?? '',
        //   height: 6.h,
        //   width: 60.w,
        // )
      ],
    );
  }
}
