import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:hassel/app.dart';
import 'package:hassel/app_routes.dart';
import 'package:hassel/shared/app_utils/app_assets.dart';
import 'package:hassel/shared/app_utils/app_colors.dart';
import 'package:hassel/shared/app_utils/app_navigator.dart';
import 'package:hassel/shared/app_utils/app_sized_box.dart';
import 'package:hassel/shared/app_utils/app_text_style.dart';
import 'package:hassel/shared/app_widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class PoductPreviewScreen extends StatefulWidget {
  const PoductPreviewScreen({Key? key}) : super(key: key);

  @override
  State<PoductPreviewScreen> createState() => _PoductPreviewScreenState();
}

class _PoductPreviewScreenState extends State<PoductPreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(
          text: App.tr.customerRates,
          size: 15.sp,
          weight: FontWeight.w500,
        ),
        actions: [
          IconButton(
              onPressed: () {
                AppNavigator.navigateTo(context: context, screen: Routes.addReviewScreen);
              },
              icon: Icon(
                Icons.add_circle,
                color: AppColors.titleColor,
                size: 20.sp,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppSizedBox.s2,
            buildReview(),
            buildReview(),
            buildReview(),
            buildReview(),
          ],
        ),
      ),
    );
  }

  Padding buildReview() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: .5.h),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'عبلة كامل',
                      style: AppTextStyle.getMediumStyle(
                        color: AppColors.titleColor,
                        fontSize: 10.sp,
                      ),
                    ),
                    Text(
                      '27 minutes ago',
                      style: AppTextStyle.getRegularStyle(
                        color: AppColors.subTitle,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 2.w,
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 3.h,
                  child: ClipOval(
                    child: CircleAvatar(
                      radius: 2.5.h,
                      backgroundColor: AppColors.backGround,
                      child: Image.asset(
                        AppAssets.register,
                        fit: BoxFit.contain,
                        scale: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.grey.shade400,
            ),
            AppSizedBox.s1,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '3.5',
                  style: AppTextStyle.getMediumStyle(color: AppColors.titleColor, fontSize: 12.sp),
                ),
                SizedBox(
                  width: 2.w,
                ),
                RatingBarIndicator(
                  rating: 3.5,
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: Colors.orange,
                  ),
                  itemCount: 5,
                  itemSize: 15.sp,
                  direction: Axis.horizontal,
                ),
              ],
            ),
            AppSizedBox.s1,
            Text(
              'فريق حصيل فريق مميز في التعامل والتوصيل والخضروات والفاكهه دائما طازجة ',
              maxLines: 2,
              textAlign: TextAlign.end,
              style: AppTextStyle.getRegularStyle(color: AppColors.titleColor, fontSize: 9.sp),
            ),
            AppSizedBox.s1,
          ],
        ),
      ),
    );
  }
}
