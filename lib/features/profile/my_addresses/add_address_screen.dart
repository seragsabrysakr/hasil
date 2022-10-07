import 'package:flutter/material.dart';
import 'package:hassel/app.dart';
import 'package:hassel/shared/app_utils/app_colors.dart';
import 'package:hassel/shared/app_utils/app_sized_box.dart';
import 'package:hassel/shared/app_utils/app_text_style.dart';
import 'package:hassel/shared/app_widgets/custom_button.dart';
import 'package:hassel/shared/app_widgets/custom_text_form_field.dart';
import 'package:hassel/shared/app_widgets/widgets_helper.dart';
import 'package:sizer/sizer.dart';

class AddAddresscreen extends StatefulWidget {
  const AddAddresscreen({Key? key}) : super(key: key);

  @override
  State<AddAddresscreen> createState() => _AddAddresscreenState();
}

class _AddAddresscreenState extends State<AddAddresscreen> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: WidgetsHelper.customAppBar(context, title: App.tr.addAddress),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppSizedBox.s2,
              const SizedBox(
                width: double.infinity,
              ),
              buildAddressForm(),
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
              AppSizedBox.s5,
            ],
          ),
        ),
      ),
    );
  }

  buildAddressForm() {
    return Form(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppSizedBox.s3,
        CustomTextField(
            color: Colors.white,
            enable: false,
            textAlign: TextAlign.end,
            prefix: Icon(
              Icons.account_circle_rounded,
              size: 13.sp,
              color: Colors.grey.shade400,
            ),
            width: 85.w,
            hint: App.tr.name,
            validator: (String? value) {
              return;
            }),
        CustomTextField(
            color: Colors.white,
            enable: false,
            textAlign: TextAlign.end,
            prefix: Icon(
              Icons.email_outlined,
              size: 13.sp,
              color: Colors.grey.shade400,
            ),
            width: 85.w,
            hint: App.tr.email,
            validator: (String? value) {
              return;
            }),
        CustomTextField(
            color: Colors.white,
            enable: false,
            textAlign: TextAlign.end,
            // suffix: Icons.arrow_drop_down,
            prefix: Icon(
              Icons.call,
              size: 13.sp,
              color: Colors.grey.shade400,
            ),
            width: 85.w,
            hint: App.tr.mobil,
            validator: (String? value) {
              return;
            }),
        CustomTextField(
            color: Colors.white,
            enable: false,
            textAlign: TextAlign.end,
            // suffix: Icons.arrow_drop_down,
            prefix: Icon(
              Icons.location_pin,
              size: 13.sp,
              color: Colors.grey.shade400,
            ),
            width: 85.w,
            hint: App.tr.address,
            validator: (String? value) {
              return;
            }),
        CustomTextField(
            color: Colors.white,
            enable: false,
            textAlign: TextAlign.end,
            // suffix: Icons.arrow_drop_down,1
            prefix: Icon(
              Icons.wysiwyg,
              size: 13.sp,
              color: Colors.grey.shade400,
            ),
            width: 85.w,
            hint: 'الرمز البريدي',
            validator: (String? value) {
              return;
            }),
        CustomTextField(
            color: Colors.white,
            enable: false,
            textAlign: TextAlign.end,
            // suffix: Icons.arrow_drop_down,1
            prefix: Icon(
              Icons.flag,
              size: 13.sp,
              color: Colors.grey.shade400,
            ),
            width: 85.w,
            hint: 'المدينة',
            validator: (String? value) {
              return;
            }),
        CustomTextField(
            color: Colors.white,
            enable: false,
            textAlign: TextAlign.end,
            // suffix: Icons.arrow_drop_down,1
            prefix: Icon(
              Icons.blur_circular_outlined,
              size: 13.sp,
              color: Colors.grey.shade400,
            ),
            width: 85.w,
            hint: ' الدولة',
            validator: (String? value) {
              return;
            }),
        Row(
          children: [
            SizedBox(
              width: 5.w,
            ),
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
              style: AppTextStyle.getSemiBoldStyle(color: AppColors.titleColor, fontSize: 11.sp),
            ),
          ],
        ),
        AppSizedBox.s9,
        AppSizedBox.s2,
      ],
    ));
  }
}
