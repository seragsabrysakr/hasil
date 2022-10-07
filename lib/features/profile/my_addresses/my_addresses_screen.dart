import 'package:flutter/material.dart';
import 'package:hassel/app.dart';
import 'package:hassel/app_routes.dart';
import 'package:hassel/features/profile/widgets/details_widget.dart';
import 'package:hassel/shared/app_utils/app_assets.dart';
import 'package:hassel/shared/app_utils/app_colors.dart';
import 'package:hassel/shared/app_utils/app_sized_box.dart';
import 'package:hassel/shared/app_utils/app_text_style.dart';
import 'package:hassel/shared/app_widgets/custom_button.dart';
import 'package:hassel/shared/app_widgets/custom_text.dart';
import 'package:hassel/shared/app_widgets/custom_text_form_field.dart';
import 'package:sizer/sizer.dart';

class MyAdressesScreen extends StatefulWidget {
  const MyAdressesScreen({Key? key}) : super(key: key);

  @override
  State<MyAdressesScreen> createState() => _MyAdressesScreenState();
}

bool isSwitched = false;

class _MyAdressesScreenState extends State<MyAdressesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: CustomText(
            text: App.tr.myAddresses,
            size: 15.sp,
            weight: FontWeight.bold,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.addAddresscreen);
                },
                icon: Icon(
                  Icons.add_circle_outlined,
                  color: AppColors.titleColor,
                ))
          ]),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppSizedBox.s3,
            DetailsWidget(
              imageLeading: AppAssets.locationIcon,
              content: buildContent(),
              detailsWidget: buildAddressForm(),
            ),
            const Spacer(
              flex: 1,
            ),
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
            AppSizedBox.s2,
          ],
        ),
      ),
    );
  }

  Column buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'عبد الله الشهري',
          style: AppTextStyle.getSemiBoldStyle(
              color: AppColors.titleColor, fontSize: 11.sp),
        ),
        Text(
          '٦ ش الحمراء الرياض',
          style: AppTextStyle.getSemiBoldStyle(
              color: AppColors.subTitle, fontSize: 11.sp),
        ),
        Text(
          'المملكة العربية السعودية',
          style: AppTextStyle.getSemiBoldStyle(
              color: AppColors.subTitle, fontSize: 11.sp),
        ),
        Text(
          '012346567676767',
          style: AppTextStyle.getSemiBoldStyle(
              color: AppColors.subTitle, fontSize: 11.sp),
        ),
      ],
    );
  }

  buildAddressForm() {
    return Form(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSizedBox.s3,
        CustomTextField(
            color: Colors.grey.shade100,
            enable: false,
            textAlign: TextAlign.end,
            prefix: Icon(
              Icons.person_pin,
              size: 13.sp,
              color: Colors.grey.shade400,
            ),
            width: 85.w,
            hint: 'عبدالله الشهري',
            validator: (String? value) {
              return;
            }),
        CustomTextField(
            color: Colors.grey.shade100,
            enable: false,
            textAlign: TextAlign.end,
            prefix: Icon(
              Icons.location_on,
              size: 13.sp,
              color: Colors.grey.shade400,
            ),
            width: 85.w,
            hint: 'عبدالله الشهري',
            validator: (String? value) {
              return;
            }),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTextField(
                color: Colors.grey.shade100,
                enable: false,
                textAlign: TextAlign.end,
                prefix: Icon(
                  Icons.location_on,
                  size: 13.sp,
                  color: Colors.grey.shade400,
                ),
                width: 35.w,
                hint: 'المدينة',
                validator: (String? value) {
                  return;
                }),
            CustomTextField(
                color: Colors.grey.shade100,
                enable: false,
                textAlign: TextAlign.end,
                prefix: Icon(
                  Icons.location_on,
                  size: 13.sp,
                  color: Colors.grey.shade400,
                ),
                width: 35.w,
                hint: 'الرمز البريدي',
                validator: (String? value) {
                  return;
                }),
          ],
        ),
        CustomTextField(
            color: Colors.grey.shade100,
            enable: false,
            textAlign: TextAlign.end,
            suffix: Icons.arrow_drop_down,
            prefix: Icon(
              Icons.location_on,
              size: 13.sp,
              color: Colors.grey.shade400,
            ),
            width: 85.w,
            hint: "المملكة العربية السعودية",
            validator: (String? value) {
              return;
            }),
        CustomTextField(
            color: Colors.grey.shade100,
            enable: false,
            textAlign: TextAlign.end,
            // suffix: Icons.arrow_drop_down,1
            prefix: Icon(
              Icons.call,
              size: 13.sp,
              color: Colors.grey.shade400,
            ),
            width: 85.w,
            hint: '0111102220111',
            validator: (String? value) {
              return;
            }),
        Row(
          children: [
            Transform.scale(
              scale: .6,
              child: Switch.adaptive(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  }),
            ),
            Text(
              'ضبط كأفتراضي',
              style: AppTextStyle.getSemiBoldStyle(
                  color: AppColors.titleColor, fontSize: 11.sp),
            ),
          ],
        )
      ],
    ));
  }
}
