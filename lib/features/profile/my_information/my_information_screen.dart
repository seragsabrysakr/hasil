import 'package:flutter/material.dart';
import 'package:hassel/app.dart';
import 'package:hassel/core/dependency_injection/dependency_injection.dart';
import 'package:hassel/data/model/user_model.dart';
import 'package:hassel/shared/app_utils/app_colors.dart';
import 'package:hassel/shared/app_utils/app_prefs.dart';
import 'package:hassel/shared/app_utils/app_sized_box.dart';
import 'package:hassel/shared/app_utils/app_text_style.dart';
import 'package:hassel/shared/app_widgets/custom_button.dart';
import 'package:hassel/shared/app_widgets/custom_text_form_field.dart';
import 'package:hassel/shared/app_widgets/widgets_helper.dart';
import 'package:sizer/sizer.dart';

class MyInformationScreen extends StatelessWidget {
  MyInformationScreen({Key? key}) : super(key: key);
  UserModel user = getIt<AppPreferences>().userDataModel!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: WidgetsHelper.customAppBar(context, title: App.tr.myInformation),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AppSizedBox.s2,
              Text(
                App.tr.personalInformation,
                style: AppTextStyle.getBoldStyle(color: AppColors.titleColor, fontSize: 12.sp),
              ),
              AppSizedBox.s1,
              myInfoWidget(
                  icon: Icons.account_circle_rounded, title: user.firstName + ' '+ user.lastName),
              myInfoWidget(icon: Icons.email_outlined, title: user.email),
              myInfoWidget(icon: Icons.call, title: user.billing.phone),
              AppSizedBox.s1,
              Text(
                App.tr.changePassword,
                style: AppTextStyle.getBoldStyle(color: AppColors.titleColor, fontSize: 12.sp),
              ),
              AppSizedBox.s2,
              CustomTextField(
                  enable: false,
                  textAlign: TextAlign.end,
                  prefix: SizedBox(
                      height: 5.w,
                      width: 5.w,
                      child: Icon(
                        Icons.lock,
                        color: Colors.grey.shade400,
                      )),
                  width: 85.w,
                  hint: App.tr.currentPassword,
                  validator: (String? value) {
                    return;
                  }),
              // AppSizedBox.s1,
              CustomTextField(
                  enable: false,
                  textAlign: TextAlign.end,
                  prefix: SizedBox(
                      height: 5.w,
                      width: 5.w,
                      child: Icon(
                        Icons.lock,
                        color: Colors.grey.shade400,
                      )),
                  width: 85.w,
                  hint: ' كلمة المرورالجديدة',
                  validator: (String? value) {
                    return;
                  }),
              // AppSizedBox.s1,
              CustomTextField(
                  enable: false,
                  textAlign: TextAlign.end,
                  prefix: SizedBox(
                      height: 3.w,
                      width: 3.w,
                      child: Icon(
                        Icons.lock,
                        color: Colors.grey.shade400,
                      )),
                  width: 85.w,
                  hint: 'تأكيد كلمة المرور',
                  validator: (String? value) {
                    return;
                  }),
              AppSizedBox.s9,
              AppSizedBox.s9,
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

  Widget myInfoWidget({required IconData icon, required String title}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Container(
        height: 6.h,
        width: 85.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(.5.h),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 5.w,
            ),
            SizedBox(
                height: 5.w,
                width: 5.w,
                child: Icon(
                  icon,
                  color: Colors.grey.shade400,
                )),
            const Spacer(
              flex: 1,
            ),
            Text(
              title,
              style: AppTextStyle.getSemiBoldStyle(color: AppColors.titleColor, fontSize: 11.sp),
            ),
            SizedBox(
              width: 5.w,
            ),
          ],
        ),
      ),
    );
  }
}
