import 'dart:ui' as ui;

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hassel/app_routes.dart';
import 'package:hassel/features/home/presentation/widgets/product_item.dart';
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

  static Widget buildFavoriteIcon(Product item, {double size = 14}) {
    return StatefulBuilder(builder: (context, setState) {
      return InkWell(
          onTap: () {
            setState(() {
              item.isFavorite = !item.isFavorite;
            });
          },
          child: Icon(
            item.isFavorite ? Icons.favorite : Icons.favorite_border,
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
                  AppNavigator.navigateTo(context: context, screen: Routes.cartRoute);
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
                ))
            : AppSizedBox.s1,
      ],
    );
  }

//Bytes From Asset//
  static Future<Uint8List> getBytesFromAsset({required String image}) async {
    ByteData data = await rootBundle.load(image);

    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: 70);

    ui.FrameInfo fi = await codec.getNextFrame();

    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
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
