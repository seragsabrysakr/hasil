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
import 'package:touch_ripple_effect/touch_ripple_effect.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  double rate = 3;
  bool top = true;
  bool freDelivery = false;
  bool onDay = false;
  bool fruts = false;
  bool daily = false;
  bool veg = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetsHelper.customAppBar(context, title: App.tr.filter),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSizedBox.s2,
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AppSizedBox.s1,
                    Text(
                      App.tr.priceAverage,
                      style:
                          AppTextStyle.getMediumStyle(color: AppColors.titleColor, fontSize: 12.sp),
                    ),
                    AppSizedBox.s1,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTextField(
                            color: AppColors.backGround,
                            enable: false,
                            textAlign: TextAlign.center,
                            width: 40.w,
                            hint: 'اعلي',
                            validator: (String? value) {
                              return;
                            }),
                        SizedBox(
                          width: 2.w,
                        ),
                        CustomTextField(
                            color: AppColors.backGround,
                            enable: false,
                            textAlign: TextAlign.center,
                            width: 40.w,
                            hint: 'اقل',
                            validator: (String? value) {
                              return;
                            }),
                      ],
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    AppSizedBox.s1,
                    Text(
                      App.tr.rateAverage,
                      style:
                          AppTextStyle.getMediumStyle(color: AppColors.titleColor, fontSize: 12.sp),
                    ),
                    AppSizedBox.s1,
                    Container(
                      color: AppColors.backGround,
                      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                      child: Row(
                        children: [
                          RatingBar.builder(
                            initialRating: rate,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            unratedColor: Colors.white,
                            itemCount: 5,
                            itemSize: 20.sp,
                            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.orange,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                              setState(() {
                                rate = rating;
                              });
                            },
                          ),
                          const Spacer(
                            flex: 1,
                          ),
                          Text(
                            rate.toString() + '  نجوم',
                            style: AppTextStyle.getMediumStyle(
                                color: AppColors.titleColor, fontSize: 10.sp),
                          ),
                        ],
                      ),
                    ),
                    AppSizedBox.s1,
                    const Divider(
                      color: Colors.grey,
                    ),
                    AppSizedBox.s1,
                    Text(
                      'اخري',
                      style:
                          AppTextStyle.getMediumStyle(color: AppColors.titleColor, fontSize: 12.sp),
                    ),
                    AppSizedBox.s1,
                    filterItem(title: 'الاعلي تقييما', value: top),
                    filterItem(title: 'شحن مجاني', value: freDelivery),
                    filterItem(title: 'توصيل في نفس اليوم', value: onDay),
                  ],
                ),
              ),
              AppSizedBox.s3,
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AppSizedBox.s1,
                    Text(
                      'الأقسام',
                      style:
                          AppTextStyle.getMediumStyle(color: AppColors.titleColor, fontSize: 12.sp),
                    ),
                    AppSizedBox.s1,
                    filterItem(title: 'فواكة طازجة', value: fruts),
                    filterItem(title: 'استخدام يومي', value: daily),
                    filterItem(title: 'خضروات', value: veg),
                    AppSizedBox.s9,
                    AppSizedBox.s7,
                    CustomButton(
                      onTap: () {},
                      fontSize: 13.sp,
                      radius: .5,
                      buttonColor: AppColors.primaryColor,
                      titleColor: Colors.white,
                      fontWeight: FontWeight.w500,
                      title: 'تطبيق الفلتر',
                      height: 6.h,
                      width: 80.w,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  filterItem({
    required String title,
    required bool value,
  }) {
    return StatefulBuilder(builder: ((context, setState) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: .5.h),
        child: TouchRippleEffect(
          rippleColor: AppColors.backGround,
          onTap: () {
            setState(() {
              value = !value;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                title,
                style: AppTextStyle.getMediumStyle(
                  color: AppColors.titleColor,
                  fontSize: 10.sp,
                ),
              ),
              SizedBox(
                width: 2.w,
              ),
              Icon(
                value ? Icons.check_circle : Icons.check_circle_outline,
                color: value ? AppColors.primaryColor : Colors.grey,
                size: 15.sp,
              )
            ],
          ),
        ),
      );
    }));
  }
}
