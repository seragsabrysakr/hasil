import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:hassel/app.dart';
import 'package:hassel/app_routes.dart';
import 'package:hassel/shared/app_utils/app_colors.dart';
import 'package:hassel/shared/app_utils/app_navigator.dart';
import 'package:hassel/shared/app_utils/app_sized_box.dart';
import 'package:hassel/shared/app_utils/app_text_style.dart';
import 'package:hassel/shared/app_widgets/custom_button.dart';
import 'package:hassel/shared/app_widgets/custom_text_form_field.dart';
import 'package:sizer/sizer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppSizedBox.s4,
            buildSearchBox(),
            AppSizedBox.s1,
            searchDraftTitle(),
            AppSizedBox.s1,
            searchDraftItems(),
            AppSizedBox.s1,
            searchDiscoverTitle(),
            AppSizedBox.s1,
            searchDiscoverItems(),
            AppSizedBox.s9,
            AppSizedBox.s9,
            AppSizedBox.s9,
            AppSizedBox.s9,
            AppSizedBox.s5,
            CustomButton(
              onTap: () {},
              fontSize: 13.sp,
              radius: .5,
              buttonColor: Colors.white,
              titleColor: AppColors.titleColor,
              fontWeight: FontWeight.w500,
              title: ' بحث',
              height: 6.h,
              width: 80.w,
            ),
          ],
        ),
      ),
    );
  }

  Widget searchDiscoverItems() {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 5.w),
      child: Wrap(
        alignment: WrapAlignment.end,
        runSpacing: 1.h,
        spacing: 4.w,
        children: [
          serachDraftWidget('فواكة'),
          serachDraftWidget('تمر'),
          serachDraftWidget('رمان'),
          serachDraftWidget('بطيخ'),
          serachDraftWidget('عنب'),
          serachDraftWidget('ليمون'),
          serachDraftWidget('فواكة'),
          serachDraftWidget('تمر'),
          serachDraftWidget('رمان'),
        ],
      ),
    );
  }

  Padding searchDiscoverTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.h),
      child: Row(
        children: [
          Text(
            App.tr.update,
            style: AppTextStyle.getMediumStyle(color: Colors.blue, fontSize: 10.sp),
          ),
          const Spacer(
            flex: 1,
          ),
          Text(
            App.tr.discoverMore,
            style: AppTextStyle.getMediumStyle(color: AppColors.titleColor, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  Widget searchDraftItems() {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 5.w),
      child: Wrap(
        alignment: WrapAlignment.end,
        runSpacing: 1.h,
        spacing: 4.w,
        children: [
          serachDraftWidget('فواكة'),
          serachDraftWidget('تمر'),
          serachDraftWidget('رمان'),
          serachDraftWidget('بطيخ'),
          serachDraftWidget('عنب'),
          serachDraftWidget('ليمون'),
          serachDraftWidget('فواكة'),
          serachDraftWidget('تمر'),
          serachDraftWidget('رمان'),
        ],
      ),
    );
  }

  Padding searchDraftTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.h),
      child: Row(
        children: [
          Text(
            App.tr.delete,
            style: AppTextStyle.getMediumStyle(color: Colors.blue, fontSize: 10.sp),
          ),
          const Spacer(
            flex: 1,
          ),
          Text(
            App.tr.searchHistory,
            style: AppTextStyle.getMediumStyle(color: AppColors.titleColor, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  Container serachDraftWidget(String text) {
    return Container(
      height: 5.h,
      color: Colors.white,
      padding: EdgeInsets.all(.8.h),
      child: Text(
        text,
        style: AppTextStyle.getRegularStyle(color: AppColors.titleColor),
      ),
    );
  }

  Widget buildSearchBox() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(top: 2.h, left: 5.w, right: 5.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
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
                )),
            CustomTextField(
              enable: false,
              ontap: () {
                AppNavigator.navigateTo(context: context, screen: Routes.filterScreen);
              },
              color: Colors.grey.shade200,
              prefix: Icon(
                Icons.search,
                color: AppColors.primaryColor,
              ),
              suffix: Icons.tune,
              hint: '.... ابحث عن المنتج ',
              width: 75.w,
              textAlign: TextAlign.end,
              validator: (String? value) {
                return;
              },
            ),
          ],
        ),
      ),
    );
  }
}
