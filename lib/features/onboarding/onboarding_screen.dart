import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hassel/app_routes.dart';
import 'package:hassel/core/dependency_injection/dependency_injection.dart';
import 'package:hassel/features/auth/presentation/cubit/user_info_cubit.dart';
import 'package:hassel/features/favorite/presentation/favorite_screen.dart';
import 'package:hassel/features/home/presentation/screens/home_screen.dart';
import 'package:hassel/features/profile/profile_screen.dart';
import 'package:hassel/shared/app_utils/app_assets.dart';
import 'package:hassel/shared/app_utils/app_colors.dart';
import 'package:hassel/shared/app_utils/app_prefs.dart';
import 'package:sizer/sizer.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int selected = 2;
  var appPref = getIt<AppPreferences>();
  List<Widget> homeScreens = [
    const FavoriteScreen(),
    const ProfileScreen(),
    const HomeScreen(),
  ];

  void startApp() {
    if (appPref.token == '') {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(Routes.logInRoute, (Route<dynamic> route) => false);
    }
  }

  @override
  void initState() {
    getIt<UserInfoCubit>().getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: buildNavigationBar(),
      body: homeScreens[selected],
    );
  }

  Stack buildNavigationBar() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          color: Colors.white,
          height: 7.h,
          padding: EdgeInsets.only(bottom: 1.h),
          width: double.infinity,
          child: Row(
            children: [
              const Spacer(
                flex: 2,
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    selected = 0;
                  });
                },
                icon: SizedBox(
                  height: 25.sp,
                  width: 25.sp,
                  child: Icon(
                    Icons.favorite_border_rounded,
                    color: selected == 0 ? AppColors.headerColor : AppColors.navColorsUnActive,
                    size: 25.sp,
                  ),
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    selected = 1;
                  });
                },
                icon: SizedBox(
                  height: 25.sp,
                  width: 25.sp,
                  child: SvgPicture.asset(
                    AppAssets.profileNavIcon,
                    color: selected == 1 ? AppColors.headerColor : AppColors.navColorsUnActive,
                  ),
                ),
              ),
              const Spacer(
                flex: 4,
              ),
            ],
          ),
        ),
        PositionedDirectional(
          end: 4.w,
          top: -3.h,
          child: CircleAvatar(
            radius: 5.h,
            backgroundColor: Colors.white,
            child: FloatingActionButton(
              backgroundColor: AppColors.primaryColor,
              onPressed: () {
                setState(() {
                  selected = 2;
                });
              },
              child: Image.asset(
                AppAssets.homeIcon,
                width: 25.sp,
                height: 25.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
