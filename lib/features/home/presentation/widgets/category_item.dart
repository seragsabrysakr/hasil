import 'package:flutter/material.dart';
import 'package:hassel/data/model/category_model.dart' as model;
import 'package:hassel/shared/app_utils/app_colors.dart';
import 'package:hassel/shared/app_utils/app_sized_box.dart';
import 'package:hassel/shared/app_utils/app_text_style.dart';
import 'package:hassel/shared/app_widgets/custom_network_image.dart';
import 'package:sizer/sizer.dart';

class CategoryItem extends StatelessWidget {
  final model.CategoryModel category;

  const CategoryItem({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildCategoryWidget(context, category);
  }

  buildCategoryWidget(BuildContext context, model.CategoryModel category) {
    return Container(
      color: Colors.white,
      child: Column(children: [
        Column(children: [
          AppSizedBox.s2,
          Text(
            category.name,
            style: AppTextStyle.getBoldStyle(
                color: AppColors.primaryColor, fontSize: 10.sp),
          ),
          AppSizedBox.s1,
          Text(
            'عنصر   ' + category.count.toString(),
            style: AppTextStyle.getRegularStyle(
                color: AppColors.titleColor, fontSize: 8.sp),
          ),
        ]),
        const Spacer(
          flex: 1,
        ),
        buildImage(
          height: 10.h,
          width: 28.w,
          imageUrl: category.image.src,
        ),
      ]),
    );
  }
}
