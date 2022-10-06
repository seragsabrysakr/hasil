import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:hassel/app.dart';
import 'package:hassel/features/home/presentation/screens/home_screen.dart';
import 'package:hassel/shared/app_utils/app_text_style.dart';
import 'package:sizer/sizer.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  const CategoryItem({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildCategoryWidget(context, category);
  }

  buildCategoryWidget(BuildContext context, Category category) {
    return Stack(children: [
      Container(
        height: 16.h,
        width: 28.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(.5.h),
          color: category.backColors,
        ),
      ),
      Positioned(
        bottom: 0,
        child: SizedBox(
          height: 7.h,
          width: 28.w,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(.5.h),
            child: Image.asset(
              category.image,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      PositionedDirectional(
        top: 1.2.h,
        start: 9.w,
        child: Column(children: [
          Text(
            category.title,
            style: AppTextStyle.getBoldStyle(color: category.circleColor, fontSize: 10.sp),
          ),
          Text(
            App.tr.fresh,
            style: AppTextStyle.getRegularStyle(color: category.circleColor, fontSize: 8.sp),
          ),
        ]),
      ),
      PositionedDirectional(
        top: 6.h,
        start: 5.w,
        child: CircleAvatar(
          radius: 4.h,
          backgroundColor: category.circleColor,
          child: SizedBox(
              height: 4.h,
              child: SvgPicture.asset(
                category.logo,
              )),
        ),
      )
    ]);
  }
}
