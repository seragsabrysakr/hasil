import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:hassel/app.dart';
import 'package:hassel/app_routes.dart';
import 'package:hassel/features/home/presentation/widgets/category_item.dart';
import 'package:hassel/features/home/presentation/widgets/product_item.dart';
import 'package:hassel/shared/app_utils/app_assets.dart';
import 'package:hassel/shared/app_utils/app_colors.dart';
import 'package:hassel/shared/app_utils/app_navigator.dart';
import 'package:hassel/shared/app_utils/app_sized_box.dart';
import 'package:hassel/shared/app_utils/app_text_style.dart';
import 'package:hassel/shared/app_widgets/custom_text_form_field.dart';
import 'package:sizer/sizer.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            buildSearchBox(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    buildHeaderImage(),
                    buildCategories(),
                    buildDailyTitle(),
                    buildDailyNeeds()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter buildDailyTitle() {
    return SliverToBoxAdapter(
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        AppSizedBox.s2,
        Text(
          App.tr.dailyNeeds,
          style: AppTextStyle.getMediumStyle(
              color: AppColors.headerColor, fontSize: 13.sp),
        ),
        AppSizedBox.s2
      ]),
    );
  }

  SliverGrid buildDailyNeeds() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: .63,
        crossAxisSpacing: 4.w,
        mainAxisSpacing: 3.w,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return StatefulBuilder(builder: (context, snapshot) {
            return ProductItem(product: products[index]);
          });
        },
        childCount: products.length,
      ),
    );
  }

  SliverToBoxAdapter buildCategories() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.h),
        child: SizedBox(
          height: 23.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AppSizedBox.s2,
              Text(
                App.tr.categories,
                style: AppTextStyle.getMediumStyle(
                    color: AppColors.headerColor, fontSize: 13.sp),
              ),
              AppSizedBox.s2,
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  // itemExtent: 31.w,
                  children: List.generate(
                      categories.length,
                      ((index) => Padding(
                            padding: EdgeInsetsDirectional.only(end: 4.w),
                            child: TouchRippleEffect(
                              rippleDuration: const Duration(milliseconds: 400),
                              rippleColor: Colors.grey.shade100,
                              onTap: () {
                                AppNavigator.navigateTo(
                                    context: context,
                                    screen: Routes.productRoute,
                                    arguments: categories[index].title);
                              },
                              child: CategoryItem(
                                category: categories[index],
                              ),
                            ),
                          ))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildSearchBox() {
    return Padding(
      padding: EdgeInsets.only(top: 2.h, left: 5.w, right: 5.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {
                AppNavigator.navigateTo(
                    context: context, screen: Routes.cartRoute);
              },
              icon: Badge(
                toAnimate: false,
                badgeContent: Text(
                  '5',
                  style: AppTextStyle.getMediumStyle(color: Colors.white),
                ),
                badgeColor: AppColors.redColor,
                position: BadgePosition.topStart(top: -10),
                child: Icon(
                  Icons.shopping_cart,
                  color: AppColors.primaryColor,
                ),
              )),
          CustomTextField(
            enable: false,
            hint: '.... ابحث عن المنتج ',
            width: 75.w,
            textAlign: TextAlign.end,
            validator: (String? value) {
              return;
            },
          ),
        ],
      ),
    );
  }

  SliverToBoxAdapter buildHeaderImage() {
    return SliverToBoxAdapter(
        child: SizedBox(
            height: 28.5.h,
            width: 80.w,
            child: Image.asset(
              AppAssets.prande,
              fit: BoxFit.cover,
            )));
  }
}

class Category {
  final String image;
  final String logo;
  final String title;
  final Color backColors;
  final Color circleColor;

  Category({
    required this.image,
    required this.logo,
    required this.title,
    required this.backColors,
    required this.circleColor,
  });
}

List<Category> categories = [
  Category(
      image: AppAssets.fruitsImage,
      logo: AppAssets.fruitsIcon,
      title: App.tr.fruits,
      backColors: AppColors.redColorTrans,
      circleColor: AppColors.redColor),
  Category(
      image: AppAssets.freshImage,
      logo: AppAssets.freshIcon,
      title: 'يوميا',
      backColors: AppColors.orangColorTrans,
      circleColor: AppColors.orangColor),
  Category(
      image: AppAssets.vegetablesImage,
      logo: AppAssets.vegetablesIcon,
      title: App.tr.vegetables,
      backColors: AppColors.greenColorTrans,
      circleColor: AppColors.greenColor),
];
