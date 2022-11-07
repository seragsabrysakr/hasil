import 'dart:ui' as ui;

import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hassel/app_routes.dart';
import 'package:hassel/data/model/productModel.dart';
import 'package:hassel/features/favorite/presentation/favorite_screen.dart';
import 'package:hassel/features/home/presentation/screens/product_details_screen.dart';
import 'package:hassel/shared/app_utils/app_colors.dart';
import 'package:hassel/shared/app_utils/app_navigator.dart';
import 'package:hassel/shared/app_utils/app_sized_box.dart';
import 'package:hassel/shared/app_utils/app_text_style.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import 'custom_text.dart';

class WidgetsHelper {
  //loading widget//
  static Widget loadingWidget({
    required double height,
    double? width,
    required double radius,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade100,
      highlightColor: Colors.grey.shade300,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }

  static Widget buildFavoriteIcon(ProductModel item, {double size = 14}) {
    return StatefulBuilder(builder: (context, setState) {
      return item.isFavorite!
          ? InkWell(
              onTap: () {
                setState(() {
                  item.isFavorite = !item.isFavorite!;
                  FavoriteScreen.favorite.removeWhere((e) => e.id == item.id);
                });
              },
              child: Icon(
                Icons.favorite,
                color: AppColors.redColor,
                size: size.sp,
              ))
          : InkWell(
              onTap: () {
                setState(() {
                  item.isFavorite = !item.isFavorite!;
                  FavoriteScreen.favorite.add(item);
                });
              },
              child: Icon(
                Icons.favorite_border,
                color: AppColors.redColor,
                size: size.sp,
              ));
    });
  }

  //app bar//
  static AppBar customAppBar(BuildContext context,
      {required String title, VoidCallback? onTap, bool cart = true}) {
    return AppBar(
      // leading: Padding(
      //   padding: EdgeInsetsDirectional.fromSTEB(4.w, 0, 0, 0),
      //   child: IconButton(
      //     onPressed: onTap ??
      //         () {
      //           FocusNode().unfocus();
      //           Navigator.canPop(context);
      //         },
      //     icon: Icon(
      //       Icons.keyboard_backspace,
      //       color: AppColors.headerColor,
      //     ),
      //   ),
      // ),
      centerTitle: true,
      title: CustomText(
        text: title,
        size: 15.sp,
        weight: FontWeight.w500,
      ),
      actions: [
        cart
            ? IconButton(
                onPressed: () {
                  AppNavigator.navigateTo(
                      context: context, screen: Routes.cartRoute);
                },
                icon: Badge(
                  toAnimate: false,
                  badgeContent: Text(
                    cartItems.length.toString(),
                    style: AppTextStyle.getBoldStyle(
                        color: AppColors.primaryColor),
                  ),
                  badgeColor: Colors.white,
                  position: BadgePosition.topStart(top: -10),
                  child: Icon(
                    Icons.shopping_cart,
                    color: AppColors.primaryColor,
                  ),
                ))
            : AppSizedBox.s1,
      ],
    );
  }

//Bytes From Asset//
  static Future<Uint8List> getBytesFromAsset({required String image}) async {
    ByteData data = await rootBundle.load(image);

    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: 70);

    ui.FrameInfo fi = await codec.getNextFrame();

    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void systemOverLay() {
    return SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white, // navigation bar color
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark // status bar color
        ));
  }

  bottomSheet(
    context,
    Widget screen, {
    bool rootnavigator = true,
    double initial = 0.6,
  }) {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        useRootNavigator: rootnavigator,
        clipBehavior: Clip.none,
        isDismissible: true,
        builder: (BuildContext context) {
          return screen;
        });
  }

  ClipRRect buildImage({required String img, double? height, double? width}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(1.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1.h),
        ),
        height: height,
        width: width,
        child: CachedNetworkImage(
          color: Colors.grey.shade300,
          imageBuilder: (context, imageProvider) => Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1.h),
              border: Border.all(color: Colors.grey.shade200),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
          imageUrl: img,
          placeholder: (context, url) => Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.red.shade100,
                  blurRadius: 8,
                  offset: const Offset(2, 5), // Shadow position
                ),
              ],
              borderRadius: BorderRadius.circular(1.h),
              image: const DecorationImage(
                  image: AssetImage(''), fit: BoxFit.cover),
            ),
            height: height,
            width: width,
          ),
          errorWidget: (context, url, error) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1.h),
              image: const DecorationImage(
                  image: AssetImage(''), fit: BoxFit.fill),
            ),
            height: height,
            width: width,
          ),
        ),
      ),
    );
  }
}

int getCount(int count) {
  if (count < 0) {
    return 0;
  }
  return count;
}
