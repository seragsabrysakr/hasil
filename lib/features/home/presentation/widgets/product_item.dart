import 'package:flutter/material.dart';
import 'package:hassel/app.dart';
import 'package:hassel/app_routes.dart';
import 'package:hassel/core/app_business_logic/state_renderer/request_builder.dart';
import 'package:hassel/data/model/productModel.dart';
import 'package:hassel/features/home/presentation/cubits/add_item_cubit.dart';
import 'package:hassel/shared/app_utils/app_colors.dart';
import 'package:hassel/shared/app_utils/app_sized_box.dart';
import 'package:hassel/shared/app_utils/app_text_style.dart';
import 'package:hassel/shared/app_widgets/custom_network_image.dart';
import 'package:hassel/shared/app_widgets/widgets_helper.dart';
import 'package:sizer/sizer.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';

class ProductItem extends StatefulWidget {
  final ProductModel product;

  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return TouchRippleEffect(
      rippleColor: AppColors.primaryColor.withOpacity(.2),
      onTap: () {
        Navigator.pushNamed(context, Routes.productDetailsRoute,
            arguments: widget.product);
      },
      child: Container(
        color: Colors.white,
        height: 32.h,
        child: Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // if (inCart)
              // buildDiscount(),
              const Spacer(
                flex: 1,
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(end: 2.w, top: 2.w),
                child: WidgetsHelper.buildFavoriteIcon(widget.product),
              ),
            ],
          ),
          buildProduxtImage(),
          AppSizedBox.s2,
          Text(
            widget.product.price,
            style: AppTextStyle.getMediumStyle(
                color: AppColors.greenColor, fontSize: 10.sp),
          ),
          SizedBox(
            height: .3.h,
          ),
          Text(
            widget.product.name,
            style: AppTextStyle.getBoldStyle(
                color: AppColors.headerColor, fontSize: 10.sp),
          ),
          SizedBox(
            height: .3.h,
          ),
          Text(
            widget.product.categories.first.name,
            style: AppTextStyle.getMediumStyle(
                color: AppColors.subTitle, fontSize: 10.sp),
          ),
          AppSizedBox.s2,
          buildAddToCart(context),
        ]),
      ),
    );
  }

  buildItemActions() {
    return Container(
      decoration: BoxDecoration(
        border: BorderDirectional(
          top: BorderSide(
            color: AppColors.subTitle.withOpacity(.4),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Material(
              child: InkWell(
                onTap: () {
                  setState(() {
                    widget.product.menuOrder--;
                  });
                },
                child: Container(
                  height: 4.h,
                  decoration: BoxDecoration(
                    border: BorderDirectional(
                      end: BorderSide(
                        color: AppColors.subTitle.withOpacity(.4),
                      ),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.remove,
                      color: AppColors.headerColor.withOpacity(.4),
                      size: 17.sp,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            getCount(widget.product.menuOrder).toString(),
            style: AppTextStyle.getBoldStyle(
                color: AppColors.headerColor.withOpacity(.4), fontSize: 13.sp),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            flex: 1,
            child: Material(
              child: InkWell(
                onTap: () {
                  setState(() {
                    widget.product.menuOrder++;
                  });
                },
                child: Container(
                  height: 4.h,
                  decoration: BoxDecoration(
                    border: BorderDirectional(
                      start: BorderSide(
                        color: AppColors.headerColor.withOpacity(.4),
                      ),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.add,
                      color: AppColors.headerColor.withOpacity(.4),
                      size: 17.sp,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildAddToCart(BuildContext context) {
    return RequestBuilder<AddItemToCartCubit>(
        contentBuilder: (context, cubit) {
          return Expanded(
            child: Material(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Routes.productDetailsRoute,
                      arguments: widget.product);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: BorderDirectional(
                      top: BorderSide(
                        color: AppColors.subTitle.withOpacity(.4),
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      App.tr.addToCart,
                      style: AppTextStyle.getBoldStyle(
                          color: AppColors.subTitle, fontSize: 10.sp),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        loadingView: CircularProgressIndicator(color: AppColors.primaryColor),
        retry: (context, cubit) {});
  }

  buildProduxtImage() {
    return buildImage(
      height: 10.h,
      width: 28.w,
      imageUrl: widget.product.images.first.src,
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

class Product {
  final String name;
  final String image;
  int count;
  final Color color;
  final String price;
  final String type;
  final String description;
  bool isFavorite;

  Product({
    required this.name,
    required this.count,
    required this.image,
    required this.color,
    required this.price,
    required this.type,
    required this.description,
    required this.isFavorite,
  });
}

List<Product> products = [
  Product(
      name: 'خوخ سكري',
      count: 0,
      image: 'assets/images/static/k.png',
      color: AppColors.orangColorTrans,
      price: '٣٠ ريال',
      type: '150 kg',
      isFavorite: false,
      description:
          'يتميز الخوخ أو البرقوق أنه غني بالعديد من العناصر الغذائية المهمة لدعم وظائف الجسم، وتنظيم مستويات السكر في الجسم. إنّ موسم الذروة للخوخ هو من يولي إلى أغسطس، لكن يتواجد في المحلات التجارية ما بين مايو إلى أكتوبر.ي بالعديد من العناصر الغذائية المهمة لدعم وظائف الجسم، وتنظيم مستويات السكر في الجسم. إنّ موسم الذروة للخوخ هو من يولي إلى أغسطس، لكن يتواجد في المحلات التجارية ما بين مايو إلى أكتوبر.'),
  Product(
      name: "رومان مصري",
      image: 'assets/images/static/r.png',
      color: AppColors.redColorTrans,
      price: '٥٠ ريال',
      count: 2,
      type: 'صندوق',
      description:
          'الرمان المصرى يغزو أوروبا وروسيا ويتفوق على «الإسبانى» و«الإسرائيلى» بدأ موسم تصدير محصول الرمان عالمياً مبكراً، وانتهى مبكراً أيضاً، وتعد مصر وإسبانيا وإسرائيل من أبرز الدول المصدرة، لكن يحظى المحصول المصرى بأهمية بالغة على مستوى التعاقدات الدولية؛ بسبب ارتفاع جودته، وتنظيم العملية التصديرية.',
      isFavorite: true),
  Product(
      description:
          'الرمان المصرى يغزو أوروبا وروسيا ويتفوق على «الإسبانى» و«الإسرائيلى» بدأ موسم تصدير محصول الرمان عالمياً مبكراً، وانتهى مبكراً أيضاً، وتعد مصر وإسبانيا وإسرائيل من أبرز الدول المصدرة، لكن يحظى المحصول المصرى بأهمية بالغة على مستوى التعاقدات الدولية؛ بسبب ارتفاع جودته، وتنظيم العملية التصديرية.',
      name: "فراولة",
      image: 'assets/images/static/s.png',
      color: AppColors.redColorTrans,
      price: '٢٠٠ ريال',
      type: '150 kg',
      count: 3,
      isFavorite: false),
  Product(
      description:
          'الرمان المصرى يغزو أوروبا وروسيا ويتفوق على «الإسبانى» و«الإسرائيلى» بدأ موسم تصدير محصول الرمان عالمياً مبكراً، وانتهى مبكراً أيضاً، وتعد مصر وإسبانيا وإسرائيل من أبرز الدول المصدرة، لكن يحظى المحصول المصرى بأهمية بالغة على مستوى التعاقدات الدولية؛ بسبب ارتفاع جودته، وتنظيم العملية التصديرية.',
      name: "ليمون أخضر",
      image: 'assets/images/static/l.png',
      color: AppColors.greenColorTrans,
      price: '١٠٠ ريال',
      type: '150 kg',
      count: 0,
      isFavorite: true),
  Product(
      description:
          'الرمان المصرى يغزو أوروبا وروسيا ويتفوق على «الإسبانى» و«الإسرائيلى» بدأ موسم تصدير محصول الرمان عالمياً مبكراً، وانتهى مبكراً أيضاً، وتعد مصر وإسبانيا وإسرائيل من أبرز الدول المصدرة، لكن يحظى المحصول المصرى بأهمية بالغة على مستوى التعاقدات الدولية؛ بسبب ارتفاع جودته، وتنظيم العملية التصديرية.',
      name: "رومان مصري",
      image: 'assets/images/static/r.png',
      color: AppColors.redColorTrans,
      price: '٥٠ ريال',
      type: 'صندوق',
      count: 0,
      isFavorite: true),
  Product(
      description:
          'الرمان المصرى يغزو أوروبا وروسيا ويتفوق على «الإسبانى» و«الإسرائيلى» بدأ موسم تصدير محصول الرمان عالمياً مبكراً، وانتهى مبكراً أيضاً، وتعد مصر وإسبانيا وإسرائيل من أبرز الدول المصدرة، لكن يحظى المحصول المصرى بأهمية بالغة على مستوى التعاقدات الدولية؛ بسبب ارتفاع جودته، وتنظيم العملية التصديرية.',
      name: "فراولة",
      image: 'assets/images/static/s.png',
      color: AppColors.redColorTrans,
      price: '٢٠٠ ريال',
      type: '150 kg',
      count: 0,
      isFavorite: false)
];
