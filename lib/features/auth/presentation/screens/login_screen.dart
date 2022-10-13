import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hassel/app.dart';
import 'package:hassel/app_routes.dart';
import 'package:hassel/shared/app_utils/app_assets.dart';
import 'package:hassel/shared/app_utils/app_colors.dart';
import 'package:hassel/shared/app_utils/app_navigator.dart';
import 'package:hassel/shared/app_utils/app_sized_box.dart';
import 'package:hassel/shared/app_utils/app_text_style.dart';
import 'package:hassel/shared/app_widgets/custom_button.dart';
import 'package:hassel/shared/app_widgets/custom_text_form_field.dart';
import 'package:sizer/sizer.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  bool showPassword = true;
  var emailController = TextEditingController();
  var passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    systemOverLay();
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              buildImageHeader(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    buildWelcomeText(),
                    buildLogInForm(),
                    buildForgetPassword(),
                    buildLogInButton(),
                    buildFooter()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column buildLogInButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomButton(
          onTap: () {
                          AppNavigator.navigateAndFinish(context: context, screen: Routes.onBoardRoute);

            if (_formKey.currentState!.validate()) {
            }
          },
          fontSize: 13.sp,
          radius: .5,
          buttonColor: AppColors.primaryColor,
          titleColor: Colors.white,
          fontWeight: FontWeight.w500,
          title: App.tr.register,
          height: 6.h,
          width: 80.w,
        ),
        AppSizedBox.s1,
      ],
    );
  }

  Column buildForgetPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            AppNavigator.navigateAndFinish(context: context, screen: Routes.forgetRoute);
          },
          child: Text(
            App.tr.lostPassword,
            style: AppTextStyle.getSemiBoldStyle(color: Colors.blue, fontSize: 10.sp),
          ),
        ),
        AppSizedBox.s2,
      ],
    );
  }

  Column buildLogInForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AppSizedBox.s1,
        CustomTextField(
            action: TextInputAction.next,
            controller: emailController,
            hint: App.tr.email,
            validator: (String? value) {
              return;
            }),
        CustomTextField(
            action: TextInputAction.done,
            controller: passController,
            // hi: 10,
            obscure: showPassword,
            visiblpass: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
            suffix: showPassword ? Icons.visibility : Icons.visibility_off,
            hint: App.tr.password,
            validator: (String? value) {
              return;
            }),
        AppSizedBox.s1,
      ],
    );
  }

  Widget buildFooter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                AppNavigator.navigateTo(context: context, screen: Routes.registerRoute);
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
              ),
              child: Text(
                App.tr.newRegister,
                style: AppTextStyle.getSemiBoldStyle(color: AppColors.headerColor, fontSize: 11.sp),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Text(
              App.tr.doNotHaveAccount,
              style: AppTextStyle.getMediumStyle(color: AppColors.subTitle, fontSize: 11.sp),
            ),
          ],
        ),
        AppSizedBox.s2,
      ],
    );
  }

  Widget buildImageHeader() {
    return Stack(
      children: [
        Container(
          height: 52.h,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
              image: const DecorationImage(
                  image: AssetImage(AppAssets.login),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter)),
        ),
        Positioned(
            top: 1.h,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.black.withOpacity(.25), Colors.black.withOpacity(.1)],
                ),
              ),
              height: 12.h,
            )),
        Positioned(
          top: 7.h,
          left: 34.w,
          right: 34.w,
          child: Text(
            App.tr.logIn,
            style: AppTextStyle.getBoldStyle(color: Colors.white, fontSize: 14.sp),
          ),
        ),
      ],
    );
  }

  Widget buildWelcomeText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AppSizedBox.s2,
        Text(
          App.tr.welcomeAgain,
          style: AppTextStyle.getMediumStyle(color: AppColors.headerColor, fontSize: 18.sp),
        ),
        AppSizedBox.s1,
        Text(
          App.tr.logInToYourAccount,
          style: AppTextStyle.getMediumStyle(color: AppColors.subTitle, fontSize: 11.sp),
        ),
        AppSizedBox.s1,
      ],
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
