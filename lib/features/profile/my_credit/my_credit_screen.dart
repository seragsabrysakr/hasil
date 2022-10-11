import 'package:flutter/material.dart';
import 'package:hassel/app.dart';
import 'package:hassel/app_routes.dart';
import 'package:hassel/features/profile/widgets/details_widget.dart';
import 'package:hassel/shared/app_utils/app_assets.dart';
import 'package:hassel/shared/app_utils/app_colors.dart';
import 'package:hassel/shared/app_utils/app_navigator.dart';
import 'package:hassel/shared/app_utils/app_sized_box.dart';
import 'package:hassel/shared/app_utils/app_text_style.dart';
import 'package:hassel/shared/app_widgets/custom_button.dart';
import 'package:hassel/shared/app_widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class MyCreditCardScreen extends StatefulWidget {
  const MyCreditCardScreen({Key? key}) : super(key: key);

  @override
  State<MyCreditCardScreen> createState() => _MyCreditCardScreenState();
}

class _MyCreditCardScreenState extends State<MyCreditCardScreen> {
  bool isSwitched1 = false;
  bool isSwitched2 = false;
  bool isSwitched3 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(
          text: App.tr.paymentCards,
          size: 15.sp,
          weight: FontWeight.w500,
        ),
        actions: [
          IconButton(
              onPressed: () {
                AppNavigator.navigateTo(
                    context: context, screen: Routes.addCreditCardScreen);
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
            buildCardDetailsWidget(
                state: false, steps: 1, details: true, isDefault: true),
            buildCardDetailsWidget(
                state: false, steps: 1, details: true, isDefault: false),
            buildCardDetailsWidget(
                state: false, steps: 1, details: true, isDefault: false),
            // buildCardDetailsWidget(state: false, steps: 1, details: true),
            AppSizedBox.s5,
            CustomButton(
              onTap: () {},
              fontSize: 13.sp,
              radius: .5,
              buttonColor: AppColors.primaryColor,
              titleColor: Colors.white,
              fontWeight: FontWeight.w700,
              title: App.tr.saveSettings,
              height: 6.h,
              width: 80.w,
            ),
          ],
        ),
      ),
    );
  }

  buildCardDetailsWidget(
      {required bool state,
      required int steps,
      required bool details,
      required isDefault}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: DetailsWidget(
          logo: isDefault,
          delivered: state,
          imageLeading: AppAssets.master,
          content: buildCardContent(),
          detailsWidget: buildDetails()),
    );
  }

  buildCardContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Master Card',
          style: AppTextStyle.getSemiBoldStyle(
              color: AppColors.titleColor, fontSize: 11.sp),
        ),
        Text(
          'XXXX XXXX XXXX 3494',
          style: AppTextStyle.getSemiBoldStyle(
              color: AppColors.subTitle, fontSize: 11.sp),
        ),
        Row(
          children: [
            Text(
              'Expiry ',
              style: AppTextStyle.getSemiBoldStyle(
                  color: AppColors.titleColor, fontSize: 11.sp),
            ),
            Text(
              '01/22',
              style: AppTextStyle.getSemiBoldStyle(
                  color: AppColors.subTitle, fontSize: 11.sp),
            ),
            SizedBox(
              width: 5.w,
            ),
            Text(
              'CVV',
              style: AppTextStyle.getSemiBoldStyle(
                  color: AppColors.subTitle, fontSize: 11.sp),
            ),
            Text(
              '345',
              style: AppTextStyle.getSemiBoldStyle(
                  color: AppColors.subTitle, fontSize: 11.sp),
            ),
            SizedBox(
              width: 10.w,
            ),
          ],
        ),
      ],
    );
  }

  buildDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          color: Colors.grey.shade200,
        ),
        AppSizedBox.s1,
        Container(
          height: 5.h,
          width: 90.w,
          color: AppColors.backGround,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
            child: Text(
              'William Crown',
              style: AppTextStyle.getRegularStyle(
                  color: AppColors.subTitle, fontSize: 11.sp),
            ),
          ),
        ),
        AppSizedBox.s1,
        Container(
          height: 5.h,
          width: 90.w,
          color: AppColors.backGround,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
            child: Text(
              'XXXX XXXX XXXX 3494',
              style: AppTextStyle.getRegularStyle(
                  color: AppColors.subTitle, fontSize: 11.sp),
            ),
          ),
        ),
        AppSizedBox.s1,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 5.h,
              width: 40.w,
              color: AppColors.backGround,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
                child: Text(
                  '01/22',
                  style: AppTextStyle.getRegularStyle(
                      color: AppColors.subTitle, fontSize: 11.sp),
                ),
              ),
            ),
            Container(
              height: 5.h,
              width: 40.w,
              color: AppColors.backGround,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
                child: Text(
                  '658',
                  style: AppTextStyle.getRegularStyle(
                      color: AppColors.subTitle, fontSize: 11.sp),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Transform.scale(
              scale: .6,
              child: Switch.adaptive(
                  value: isSwitched1,
                  onChanged: (value) {
                    setState(() {
                      isSwitched1 = value;
                    });
                  }),
            ),
            Text(
              'ضبط كأفتراضي',
              style: AppTextStyle.getRegularStyle(
                  color: AppColors.titleColor, fontSize: 10.sp),
            ),
          ],
        )
      ],
    );
  }
}
