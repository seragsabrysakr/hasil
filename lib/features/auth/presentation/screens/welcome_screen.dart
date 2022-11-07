import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hassel/app.dart';
import 'package:hassel/app_routes.dart';
import 'package:hassel/shared/app_utils/app_assets.dart';
import 'package:hassel/shared/app_utils/app_colors.dart';
import 'package:hassel/shared/app_utils/app_navigator.dart';
import 'package:hassel/shared/app_utils/app_sized_box.dart';
import 'package:hassel/shared/app_utils/app_text_style.dart';
import 'package:hassel/shared/app_widgets/custom_button.dart';
import 'package:sizer/sizer.dart';

class WelComeScreen extends StatefulWidget {
  const WelComeScreen({Key? key}) : super(key: key);

  @override
  State<WelComeScreen> createState() => _WelComeScreenState();
}

class _WelComeScreenState extends State<WelComeScreen> {
  @override
  Widget build(BuildContext context) {
    systemOverLay();
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [buildImageHeader(), AppSizedBox.s3, buildScreenBody()],
      ),
    );
  }

  Widget buildScreenBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          buildWelcomeText(),
          // buildLogWithGoogle(),
          buildCreateAccount(),
          buildFooter(),
        ],
      ),
    );
  }

  Widget buildWelcomeText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          App.tr.welcome,
          style: AppTextStyle.getMediumStyle(
              color: AppColors.headerColor, fontSize: 18.sp),
        ),
        AppSizedBox.s3,
        Text(
          App.tr.welcomeHeader1,
          style: AppTextStyle.getMediumStyle(
              color: AppColors.subTitle, fontSize: 11.sp),
        ),
        AppSizedBox.s1,
        Text(
          App.tr.welcomeHeader2,
          style: AppTextStyle.getMediumStyle(
              color: AppColors.subTitle, fontSize: 11.sp),
        ),
        AppSizedBox.s2,
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
                AppNavigator.navigateTo(
                    context: context, screen: Routes.logInRoute);
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.zero),
              ),
              child: Text(
                App.tr.logIn,
                style: AppTextStyle.getSemiBoldStyle(
                    color: AppColors.headerColor, fontSize: 11.sp),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Text(
              App.tr.iHaveAccount,
              style: AppTextStyle.getMediumStyle(
                  color: AppColors.subTitle, fontSize: 11.sp),
            ),
          ],
        ),
        AppSizedBox.s2,
      ],
    );
  }

  Widget buildCreateAccount() {
    return CustomButton(
      onTap: () {
        AppNavigator.navigateTo(context: context, screen: Routes.registerRoute);
      },
      fontSize: 13.sp,
      radius: .5,
      buttonColor: AppColors.primaryColor,
      titleColor: Colors.white,
      fontWeight: FontWeight.w500,
      title: App.tr.createNewAccount,
      height: 6.h,
      width: 80.w,
    );
  }

  Widget buildImageHeader() {
    return Stack(
      children: [
        Container(
          height: 60.h,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
              image: const DecorationImage(
                  image: AssetImage(AppAssets.welcome), fit: BoxFit.cover)),
        ),
        Positioned(
            // top: 0,
            child: Container(
          decoration: BoxDecoration(
            gradient: SweepGradient(
              startAngle: 10.w,
              endAngle: 20.w,
              colors: [
                Colors.black.withOpacity(.1),
                Colors.black.withOpacity(.1)
              ],
            ),
          ),
          height: 12.h,
        )),
        Positioned(
          top: 7.h,
          left: 34.w,
          right: 34.w,
          child: Text(
            App.tr.welcomeAll,
            style: AppTextStyle.getMediumStyle(
                color: Colors.white, fontSize: 14.sp),
          ),
        ),
      ],
    );
  }

  Widget buildLogWithGoogle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: 6.h,
          width: 80.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(.5.h),
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.primaryColor.withOpacity(.01),
                    elevation: 0,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(.1.h)))
                .copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
            onPressed: () {
              print('object');
            },
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 5.w,
                ),
                SizedBox(
                    height: 5.w,
                    width: 5.w,
                    child: SvgPicture.asset(
                      AppAssets.google,
                      color: Colors.red,
                      fit: BoxFit.contain,
                    )),
                SizedBox(
                  width: 11.5.w,
                ),
                Text(
                  App.tr.logWithGoogle,
                  style: AppTextStyle.getSemiBoldStyle(
                      color: AppColors.subTitle, fontSize: 11.sp),
                ),
              ],
            ),
          ),
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
