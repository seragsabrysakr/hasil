import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassel/app.dart';
import 'package:hassel/app_routes.dart';
import 'package:hassel/core/app_business_logic/state_renderer/state_renderer_impl.dart';
import 'package:hassel/core/dependency_injection/dependency_injection.dart';
import 'package:hassel/data/model/category_model.dart' as model;
import 'package:hassel/data/model/productModel.dart';
import 'package:hassel/features/home/presentation/cubits/categories_cubit.dart';
import 'package:hassel/features/home/presentation/cubits/products_cubit.dart';
import 'package:hassel/features/home/presentation/screens/product_details_screen.dart';
import 'package:hassel/features/home/presentation/widgets/category_item.dart';
import 'package:hassel/features/home/presentation/widgets/product_item.dart';
import 'package:hassel/shared/app_utils/app_assets.dart';
import 'package:hassel/shared/app_utils/app_colors.dart';
import 'package:hassel/shared/app_utils/app_navigator.dart';
import 'package:hassel/shared/app_utils/app_sized_box.dart';
import 'package:hassel/shared/app_utils/app_text_style.dart';
import 'package:hassel/shared/app_widgets/widgets_helper.dart';
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<CategoriesCubit>()..getCategories(),
          ),
          BlocProvider(
            create: (context) => getIt<ProductsCubit>()..getProducts(),
          ),
        ],
        child: SafeArea(
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
                      buildCategoriesTitle(),
                      buildCategoriesRequestBuilder(),
                      buildDailyTitle(),
                      buildProductsRequestBuilder()
                    ],
                  ),
                ),
              ),
            ],
          ),
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

  SliverToBoxAdapter buildCategoriesTitle() {
    return SliverToBoxAdapter(
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        AppSizedBox.s2,
        Text(
          App.tr.categories,
          style: AppTextStyle.getMediumStyle(
              color: AppColors.headerColor, fontSize: 13.sp),
        ),
      ]),
    );
  }

  buildProductsRequestBuilder() {
    return BlocConsumer<ProductsCubit, FlowState>(
      listener: (context, state) {
        state.flowStateListener(context);
      },
      builder: (context, state) {
        var cubit = ProductsCubit.get(context);
        List<ProductModel> productList = cubit.products;
        return state.flowStateBuilder(context,
            isSliver: true,
            loadingView: buildProductsLoading(),
            screenContent: buildProducts(productList),
            retry: () {});
      },
    );
  }

  SliverGrid buildProducts(List<ProductModel> productList) {
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
            return ProductItem(product: productList[index]);
          });
        },
        childCount: products.length,
      ),
    );
  }

  buildProductsLoading() {
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
            return WidgetsHelper.loadingWidget(
              height: 32.h,
              width: 27.w,
              radius: 1.h,
            );
          });
        },
        childCount: 4,
      ),
    );
  }

  buildCategoriesRequestBuilder() {
    return BlocConsumer<CategoriesCubit, FlowState>(
      listener: (context, state) {
        state.flowStateListener(context);
      },
      builder: (context, state) {
        var cubit = CategoriesCubit.get(context);
        List<model.CategoryModel> categoriesList = cubit.categories;

        return state.flowStateBuilder(context,
            isSliver: true,
            loadingView: categoriesLoading(),
            screenContent: buildCategories(context, categoriesList),
            retry: () {});
      },
    );
  }

  SliverToBoxAdapter categoriesLoading() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          AppSizedBox.s2,
          Row(
            children: List.generate(
                3,
                (index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1.5.w),
                      child: WidgetsHelper.loadingWidget(
                        height: 15.h,
                        width: 27.w,
                        radius: 1.h,
                      ),
                    )),
          ),
        ],
      ),
    );
  }

  SliverToBoxAdapter buildCategories(
      BuildContext context, List<model.CategoryModel> categoriesList) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: SizedBox(
          height: 19.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  // itemExtent: 31.w,
                  children: List.generate(
                      categoriesList.length,
                      ((index) => Padding(
                            padding: EdgeInsetsDirectional.only(end: 4.w),
                            child: TouchRippleEffect(
                              rippleDuration: const Duration(milliseconds: 400),
                              rippleColor: Colors.grey.shade100,
                              onTap: () {
                                AppNavigator.navigateTo(
                                    context: context,
                                    screen: Routes.productRoute,
                                    arguments: categoriesList[index]);
                              },
                              child: CategoryItem(
                                category: categoriesList[index],
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
      padding: EdgeInsets.only(top: 2.h, bottom: 2.h, left: 5.w, right: 5.w),
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
                  cartItems.length.toString(),
                  style:
                      AppTextStyle.getBoldStyle(color: AppColors.primaryColor),
                ),
                badgeColor: Colors.white,
                position: BadgePosition.topStart(top: -10),
                child: Icon(
                  Icons.shopping_cart,
                  color: AppColors.primaryColor,
                ),
              )),
          TouchRippleEffect(
              rippleColor: Colors.grey.shade300,
              onTap: () {
                AppNavigator.navigateTo(
                    context: context, screen: Routes.searchScreen);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                color: Colors.white,
                height: 6.h,
                width: 75.w,
                child: const Text(
                  '.... ابحث عن المنتج ',
                  textAlign: TextAlign.end,
                ),
              )),
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
