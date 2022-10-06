import 'package:flutter/material.dart';
import 'package:hassel/app.dart';
import 'package:hassel/features/home/presentation/widgets/product_item.dart';
import 'package:hassel/shared/app_utils/app_colors.dart';
import 'package:hassel/shared/app_utils/app_sized_box.dart';
import 'package:hassel/shared/app_utils/app_text_style.dart';
import 'package:hassel/shared/app_widgets/custom_button.dart';
import 'package:hassel/shared/app_widgets/widgets_helper.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product item;
  const ProductDetailsScreen({Key? key, required this.item}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetsHelper.customAppBar(context, title: widget.item.name,
          onTap: () {
        Navigator.canPop(context);
      }),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            color: Colors.white,
            width: double.infinity,
            child: Column(children: [
              AppSizedBox.s4,
              buildProductImage(),
              AppSizedBox.s7,
            ]),
          ),
          AppSizedBox.s4,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              children: [
                WidgetsHelper.buildFavoriteIcon(widget.item, size: 18),
                const Spacer(
                  flex: 1,
                ),
                Text(
                  widget.item.type,
                  style: AppTextStyle.getBoldStyle(
                      color: AppColors.primaryColor, fontSize: 18.sp),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              children: [
                const Spacer(
                  flex: 1,
                ),
                Text(
                  widget.item.name,
                  style: AppTextStyle.getBoldStyle(
                      color: AppColors.headerColor, fontSize: 16.sp),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              children: [
                const Spacer(
                  flex: 1,
                ),
                Text(
                  '1.5 ibs',
                  style: AppTextStyle.getMediumStyle(
                      color: AppColors.subTitle, fontSize: 12.sp),
                ),
              ],
            ),
          ),
          AppSizedBox.s1,
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: ReadMoreText(
                widget.item.description,
                trimLines: 3,
                style: AppTextStyle.getRegularStyle(
                    color: AppColors.primaryColor,
                    fontSize: 12.sp,
                    height: 1.4),
                textAlign: TextAlign.end,
                colorClickableText: AppColors.primaryColor,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'المزيد',
                trimExpandedText: 'أقل',
                lessStyle: AppTextStyle.getBoldStyle(
                    color: AppColors.primaryColor, fontSize: 14.sp),
                moreStyle: AppTextStyle.getBoldStyle(
                    color: AppColors.primaryColor, fontSize: 14.sp),
              )),
          AppSizedBox.s3,
          buildItemActions(),
          buildAddToCart(),
        ],
      ),
    );
  }

  buildItemActions() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Container(
        padding: EdgeInsetsDirectional.only(start: 2.w),
        color: Colors.white,
        child: Row(
          children: [
            Text(
              App.tr.quantity,
              style: AppTextStyle.getBoldStyle(
                  color: AppColors.titleColor, fontSize: 10.sp),
            ),
            const Spacer(
              flex: 1,
            ),
            Material(
              child: InkWell(
                onTap: () {
                  setState(() {
                    widget.item.count--;
                  });
                },
                child: Container(
                  height: 5.h,
                  width: 10.w,
                  decoration: BoxDecoration(
                    border: BorderDirectional(
                      end: BorderSide(
                        color: AppColors.subTitle.withOpacity(.2),
                      ),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.remove,
                      color: AppColors.primaryColor,
                      size: 17.sp,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            Text(
              widget.item.count.toString(),
              style: AppTextStyle.getBoldStyle(
                  color: AppColors.titleColor, fontSize: 14.sp),
            ),
            SizedBox(
              width: 5.w,
            ),
            Material(
              child: InkWell(
                onTap: () {
                  setState(() {
                    widget.item.count++;
                  });
                },
                child: Container(
                  height: 5.h,
                  width: 10.w,
                  decoration: BoxDecoration(
                    border: BorderDirectional(
                      start: BorderSide(
                        color: AppColors.headerColor.withOpacity(.2),
                      ),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.add,
                      color: AppColors.primaryColor,
                      size: 17.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildAddToCart() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
      child: CustomButton(
        onTap: () {},
        fontSize: 13.sp,
        radius: .5,
        buttonColor: AppColors.primaryColor,
        titleColor: Colors.white,
        fontWeight: FontWeight.w900,
        title: App.tr.addToCart,
        height: 6.h,
        width: 80.w,
      ),
    );
  }

  Stack buildProductImage() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: 15.h,
          backgroundColor: widget.item.color,
        ),
        Positioned(
          bottom: -3.h,
          child: Image.asset(
            widget.item.image,
            scale: .7,
          ),
        ),
      ],
    );
  }

  Padding buildFavoriteIcon() {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 2.w, top: 2.w),
      child: InkWell(
          onTap: () {
            setState(() {
              widget.item.isFavorite = !widget.item.isFavorite;
            });
          },
          child: Icon(
            widget.item.isFavorite ? Icons.favorite : Icons.favorite_border,
            color: AppColors.redColor,
            size: 14.sp,
          )),
    );
  }

  Container buildDiscount() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(.3.h),
        color: AppColors.redColorTrans,
      ),
      height: 2.2.h,
      width: 4.2.h,
      child: Center(
        child: Text(
          '35%',
          style: AppTextStyle.getRegularStyle(
              color: AppColors.redColor, fontSize: 7.sp),
        ),
      ),
    );
  }
}
