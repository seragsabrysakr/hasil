import 'package:flutter/material.dart';
import 'package:hassel/app.dart';
import 'package:hassel/app_routes.dart';
import 'package:hassel/data/model/user_model.dart';
import 'package:hassel/shared/app_utils/app_assets.dart';
import 'package:hassel/shared/app_utils/app_colors.dart';
import 'package:hassel/shared/app_utils/app_prefs.dart';
import 'package:hassel/shared/app_utils/app_sized_box.dart';
import 'package:hassel/shared/app_utils/app_text_style.dart';
import 'package:hassel/shared/app_widgets/custom_network_image.dart';
import 'package:sizer/sizer.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';

import '../../core/dependency_injection/dependency_injection.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel user = getIt<AppPreferences>().userDataModel!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 17.h,
                color: Colors.white,
              ),
              Padding(
                padding: EdgeInsets.only(top: 9.h),
                child: Column(
                  children: [
                    Text(
                      user.firstName + ' ' + user.lastName,
                      style:
                          AppTextStyle.getBoldStyle(color: AppColors.titleColor, fontSize: 15.sp),
                    ),
                    Text(
                      user.email,
                      style: AppTextStyle.getBoldStyle(color: AppColors.subTitle, fontSize: 10.sp),
                    ),
                  ],
                ),
              ),
              AppSizedBox.s4,
              Expanded(child: buildProductLit())
            ],
          ),
          buildUserImage(),
          buildCameraPicker(),
        ],
      ),
    );
  }

  PositionedDirectional buildCameraPicker() {
    return PositionedDirectional(
      top: 20.h,
      end: 32.w,
      child: CircleAvatar(
        radius: 2.2.h,
        backgroundColor: AppColors.primaryColor,
        child: Icon(
          Icons.camera_alt,
          color: Colors.white,
          size: 15.sp,
        ),
      ),
    );
  }

  Positioned buildUserImage() {
    return Positioned(
      top: 9.h,
      left: 20.w,
      right: 20.w,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 8.h,
        child: ClipOval(
          child: CircleAvatar(
              radius: 7.h,
              backgroundColor: AppColors.backGround,
              child: buildImage(imageUrl: user.avatarUrl, height: 15.h, width: 30.w)),
        ),
      ),
    );
  }

  buildProductLit() {
    return Padding(
      padding: EdgeInsets.only(left: 5.w, right: 5.w),
      child: GridView(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: .85,
            crossAxisSpacing: 4.w,
            mainAxisSpacing: 3.2.w,
          ),
          children: List.generate(images.length, (index) => buildProfileWidget(index))),
    );
  }

  StatefulBuilder buildProfileWidget(int index) {
    return StatefulBuilder(builder: (context, snapshot) {
      return Container(
        color: Colors.white,
        height: 16.h,
        child: TouchRippleEffect(
          onTap: () {
            if (index != screens.length - 1) {
              Navigator.pushNamed(context, screens[index]);
            }
          },
          rippleColor: AppColors.primaryColor.withOpacity(.2),
          child: Center(
            child: Column(
              children: [
                AppSizedBox.s3,
                CircleAvatar(
                  radius: 3.h,
                  backgroundColor: AppColors.backGround,
                  child: Image.asset(
                    images[index],
                    scale: 1.5,
                  ),
                ),
                AppSizedBox.s2,
                Text(
                  titles[index],
                  style: AppTextStyle.getBoldStyle(color: AppColors.subTitle, fontSize: 10.sp),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  List<String> images = [
    AppAssets.profileIcon,
    AppAssets.myordersIcon,
    AppAssets.locationIcon,
    AppAssets.creatitIcon,
    AppAssets.trancfersIcon,
    AppAssets.notificationsIcon,
    AppAssets.logoutIcon,
  ];
  List<String> titles = [
    App.tr.myInformation,
    App.tr.myOrders,
    App.tr.myAddresses,
    App.tr.paymentCards,
    App.tr.myPayments,
    App.tr.notifications,
    '?????????? ????????',
  ];
}

List<String> screens = [
  Routes.myInformationRoute,
  Routes.myOrdersScreen,
  Routes.myAdressesRoute,
  Routes.myCreditCardScreen,
  Routes.transictiosScreen,
  Routes.notiFicationScreen,
  Routes.profileRoute,
];
