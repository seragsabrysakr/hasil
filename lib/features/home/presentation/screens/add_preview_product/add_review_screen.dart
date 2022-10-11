import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hassel/app.dart';
import 'package:hassel/shared/app_utils/app_colors.dart';
import 'package:hassel/shared/app_utils/app_sized_box.dart';
import 'package:hassel/shared/app_utils/app_text_style.dart';
import 'package:hassel/shared/app_widgets/custom_button.dart';
import 'package:hassel/shared/app_widgets/custom_text_form_field.dart';
import 'package:hassel/shared/app_widgets/widgets_helper.dart';
import 'package:sizer/sizer.dart';

class AddProductReviewScreen extends StatefulWidget {
  const AddProductReviewScreen({Key? key}) : super(key: key);

  @override
  State<AddProductReviewScreen> createState() => _AddProductReviewScreenState();
}

class _AddProductReviewScreenState extends State<AddProductReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetsHelper.customAppBar(context, title: App.tr.revision),
      body: Center(
        child: Column(
          children: [
            AppSizedBox.s6,
            Text(
              App.tr.whatYouThink,
              style: AppTextStyle.getRegularStyle(
                color: AppColors.titleColor,
                fontSize: 20.sp,
              ),
            ),
            AppSizedBox.s2,
            Text(
              App.tr.giveRateH1,
              style: AppTextStyle.getRegularStyle(
                color: AppColors.subTitle,
                fontSize: 12.sp,
              ),
            ),
            Text(
              'النجوم أدناه',
              style: AppTextStyle.getRegularStyle(
                color: AppColors.subTitle,
                fontSize: 12.sp,
              ),
            ),
            AppSizedBox.s2,
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              unratedColor: Colors.white,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.orange,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
            AppSizedBox.s1,
            CustomTextField(
                textAlign: TextAlign.end,
                max: 8,
                min: 8,
                hint: App.tr.giveRateH2,
                validator: (String? value) {
                  return;
                }),
            AppSizedBox.s1,
            CustomButton(
              onTap: () {},
              fontSize: 13.sp,
              radius: .5,
              buttonColor: AppColors.primaryColor,
              titleColor: Colors.white,
              fontWeight: FontWeight.w500,
              title: App.tr.send,
              height: 6.h,
              width: 80.w,
            ),
          ],
        ),
      ),
    );
  }
}
