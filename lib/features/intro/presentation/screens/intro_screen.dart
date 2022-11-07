import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassel/app.dart';
import 'package:hassel/app_routes.dart';
import 'package:hassel/core/dependency_injection/dependency_injection.dart';
import 'package:hassel/features/intro/presentation/cubits/intro_cubit.dart';
import 'package:hassel/features/intro/presentation/widgets/slider_dots.dart';
import 'package:hassel/features/intro/presentation/widgets/slider_image.dart';
import 'package:hassel/shared/app_utils/app_colors.dart';
import 'package:hassel/shared/app_utils/app_navigator.dart';
import 'package:hassel/shared/app_utils/app_prefs.dart';
import 'package:hassel/shared/app_utils/app_sized_box.dart';
import 'package:hassel/shared/app_widgets/custom_button.dart';
import 'package:sizer/sizer.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _systemOverLay() {
    return SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white, // navigation bar color
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark // status bar color
        ));
  }

  @override
  Widget build(BuildContext context) {
    _systemOverLay();
    return BlocProvider(
      create: (context) => getIt<IntroCubit>(),
      child: BlocConsumer<IntroCubit, IntroState>(
        listener: (context, state) {},
        builder: (context, state) {
          var introCubit = IntroCubit.get(context);

          return Scaffold(
              extendBodyBehindAppBar: true,
              extendBody: true,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AppSizedBox.s5,
                  sliderImages(context, introCubit),
                  AppSizedBox.s2,

                  sliderTexts(introCubit),
                  AppSizedBox.s1,
                  SliderDots(
                      numberOfDots: introCubit.photos.length,
                      photoIndex:
                          introCubit.activePage % introCubit.photos.length),
                  buildButton(context, introCubit)
                  // : _sliderFooter(introCubit),
                ],
              ));
        },
      ),
    );
  }

  Column buildButton(BuildContext context, IntroCubit introCubit) {
    bool firstIndex = introCubit.getFirstIndex();
    return Column(
      children: [
        SizedBox(
          height: 4.h,
        ),
        CustomButton(
          onTap: () {
            getIt<AppPreferences>().isIntroShow = false;
            AppNavigator.navigateTo(
                context: context, screen: Routes.welcomeRoute);
          },
          fontSize: 15.sp,
          radius: .5,
          buttonColor: AppColors.primaryColor,
          titleColor: Colors.white,
          fontWeight: FontWeight.w800,
          title: firstIndex ? App.tr.start : App.tr.skip,
          height: 6.h,
          width: 80.w,
        ),
      ],
    );
  }

  Center sliderImages(BuildContext context, IntroCubit introCubit) {
    return Center(
      child: Center(
        child: SizedBox(
          height: 45.h,
          child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: introCubit.photos.length,
              pageSnapping: true,
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  introCubit.activePage = page % introCubit.photos.length;
                });
              },
              itemBuilder: (context, pagePosition) {
                return SliderImageItem(introCubit.photos[pagePosition]);
              }),
        ),
      ),
    );
  }

  sliderTexts(IntroCubit introCubit) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: SizedBox(
        height: 30.h,
        child: introCubit
            .sliderItems[introCubit.activePage % introCubit.photos.length],
      ),
    );
  }

  void _checkNextDestination(BuildContext context) {}

  void _nextImage() {
    _pageController.nextPage(
        duration: const Duration(milliseconds: 750),
        curve: Curves.fastLinearToSlowEaseIn);
  }
}
