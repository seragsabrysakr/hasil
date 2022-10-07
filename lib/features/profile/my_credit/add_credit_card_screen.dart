import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hassel/app.dart';
import 'package:hassel/shared/app_utils/app_assets.dart';
import 'package:hassel/shared/app_utils/app_colors.dart';
import 'package:hassel/shared/app_utils/app_sized_box.dart';
import 'package:hassel/shared/app_utils/app_text_style.dart';
import 'package:hassel/shared/app_widgets/custom_text_form_field.dart';
import 'package:hassel/shared/app_widgets/widgets_helper.dart';
import 'package:sizer/sizer.dart';

class AddCreditCardScreen extends StatefulWidget {
  const AddCreditCardScreen({Key? key}) : super(key: key);

  @override
  State<AddCreditCardScreen> createState() => _AddCreditCardScreenState();
}

class _AddCreditCardScreenState extends State<AddCreditCardScreen> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetsHelper.customAppBar(context, title: App.tr.addCard),
      body: Column(
        children: [
          AppSizedBox.s3,
          SizedBox(
            width: 90.w,
            height: 20.h,
            child: SvgPicture.asset(
              AppAssets.card,
              clipBehavior: Clip.antiAlias,
              fit: BoxFit.contain,
            ),
          ),
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
                Icons.credit_card,
                size: 13.sp,
                color: Colors.grey.shade400,
              ),
              width: 85.w,
              hint: App.tr.name,
              validator: (String? value) {
                return;
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                  color: Colors.white,
                  enable: false,
                  textAlign: TextAlign.center,
                  width: 40.w,
                  hint: 'Month/year',
                  validator: (String? value) {
                    return;
                  }),
              SizedBox(
                width: 2.w,
              ),
              CustomTextField(
                  color: Colors.white,
                  enable: false,
                  textAlign: TextAlign.center,
                  width: 40.w,
                  hint: 'CVV',
                  validator: (String? value) {
                    return;
                  }),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 5.w,
              ),
              Transform.scale(
                scale: .6,
                child: Switch.adaptive(
                    value: isSwitched,
                    activeColor: AppColors.primaryColor,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                      });
                    }),
              ),
              Text(
                'حفظ الكارت',
                style: AppTextStyle.getSemiBoldStyle(color: AppColors.titleColor, fontSize: 11.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
