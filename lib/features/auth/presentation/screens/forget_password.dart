import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hassel/app.dart';
import 'package:hassel/shared/app_utils/app_colors.dart';
import 'package:hassel/shared/app_utils/app_sized_box.dart';
import 'package:hassel/shared/app_utils/app_text_style.dart';
import 'package:hassel/shared/app_utils/app_validation.dart';
import 'package:hassel/shared/app_widgets/custom_button.dart';
import 'package:hassel/shared/app_widgets/custom_text_form_field.dart';
import 'package:hassel/shared/app_widgets/widgets_helper.dart';
import 'package:sizer/sizer.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    systemOverLay();

    return Scaffold(
      appBar: WidgetsHelper.customAppBar(
        context,
        title: App.tr.getBackPassword,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AppSizedBox.s9,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    buildWelcomeText(),
                    buildForm(),
                    buildSendLinkButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column buildSendLinkButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomButton(
          onTap: () {
            if (_formKey.currentState!.validate()) {}
          },
          fontSize: 13.sp,
          radius: .5,
          buttonColor: AppColors.primaryColor,
          titleColor: Colors.white,
          fontWeight: FontWeight.w600,
          title: App.tr.sendLink,
          height: 6.h,
          width: 80.w,
        ),
        AppSizedBox.s1,
      ],
    );
  }

  Column buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AppSizedBox.s1,
        CustomTextField(
            action: TextInputAction.next,
            type: TextInputType.emailAddress,
            controller: emailController,
            hint: App.tr.email,
            validator: (String? value) {
              return Validations.emailValidation(value);
            }),
      ],
    );
  }

  Widget buildWelcomeText() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            App.tr.lostPassword,
            style: AppTextStyle.getMediumStyle(
                color: AppColors.headerColor, fontSize: 18.sp),
          ),
          AppSizedBox.s3,
          Text(
            App.tr.pleaseEnterYourMail,
            style: AppTextStyle.getMediumStyle(
                color: AppColors.subTitle, fontSize: 11.sp),
          ),
          AppSizedBox.s1,
          Text(
            App.tr.password,
            style: AppTextStyle.getMediumStyle(
                color: AppColors.subTitle, fontSize: 11.sp),
          ),
          AppSizedBox.s2,
        ],
      ),
    );
  }

  void systemOverLay() {
    return SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white, // navigation bar color
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark // status bar color
        ));
  }
}
