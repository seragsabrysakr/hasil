import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hassel/app.dart';
import 'package:hassel/app_routes.dart';
import 'package:hassel/core/app_business_logic/state_renderer/request_builder.dart';
import 'package:hassel/core/app_business_logic/state_renderer/state_renderer_impl.dart';
import 'package:hassel/core/dependency_injection/dependency_injection.dart';
import 'package:hassel/data/model/cart_order_model.dart';
import 'package:hassel/data/model/productModel.dart';
import 'package:hassel/features/home/presentation/cubits/add_item_cubit.dart';
import 'package:hassel/features/home/presentation/cubits/single_product_cubit.dart';
import 'package:hassel/shared/app_utils/app_colors.dart';
import 'package:hassel/shared/app_utils/app_sized_box.dart';
import 'package:hassel/shared/app_utils/app_text_style.dart';
import 'package:hassel/shared/app_widgets/custom_button.dart';
import 'package:hassel/shared/app_widgets/custom_network_image.dart';
import 'package:hassel/shared/app_widgets/widgets_helper.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel item;

  const ProductDetailsScreen({Key? key, required this.item}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    count = getCount(widget.item.menuOrder);
    return Scaffold(
      appBar: WidgetsHelper.customAppBar(context, title: widget.item.name,
          onTap: () {
        Navigator.canPop(context);
      }),
      body: BlocProvider(
        create: (context) => getIt<SingleProductsCubit>(),
        child: BlocConsumer<SingleProductsCubit, FlowState>(
          listener: (context, state) {
            state.flowStateListener(context);
          },
          builder: (context, state) {
            var cubit = SingleProductsCubit.get(context);
            ProductModel? products = widget.item;
            return state.flowStateBuilder(context,
                screenContent: buildScreenContent(context, products),
                retry: () {
              cubit.getProduct(widget.item.id.toString());
            });
          },
        ),
      ),
    );
  }

  ListView buildScreenContent(BuildContext context, ProductModel product) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Container(
          color: Colors.white,
          width: double.infinity,
          child: Column(children: [
            AppSizedBox.s4,
            buildProductImage(product),
            AppSizedBox.s7,
          ]),
        ),
        AppSizedBox.s4,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            children: [
              // WidgetsHelper.buildFavoriteIcon(widget.item, size: 18),
              const Spacer(
                flex: 1,
              ),
              Text(
                product.name,
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
                product.categories.first.name,
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
                '${product.price}  ريال',
                style: AppTextStyle.getMediumStyle(
                    color: AppColors.subTitle, fontSize: 12.sp),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: TouchRippleEffect(
            rippleColor: Colors.grey.shade400,
            onTap: () {
              Navigator.pushNamed(context, Routes.poductPreviewScreen);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  product.averageRating.toString(),
                  style: AppTextStyle.getMediumStyle(
                      color: AppColors.titleColor, fontSize: 12.sp),
                ),
                SizedBox(
                  width: 2.w,
                ),
                RatingBarIndicator(
                  rating: double.parse(product.averageRating),
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 15.sp,
                  direction: Axis.horizontal,
                ),
                SizedBox(
                  width: 2.w,
                ),
                Text(
                  '(${product.ratingCount} مراجعة)',
                  style: AppTextStyle.getMediumStyle(
                      color: AppColors.titleColor, fontSize: 12.sp),
                ),
              ],
            ),
          ),
        ),
        AppSizedBox.s1,
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: ReadMoreText(
              product.description,
              trimLines: 3,
              style: AppTextStyle.getRegularStyle(
                  color: AppColors.primaryColor, fontSize: 12.sp, height: 1.4),
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
                    widget.item.menuOrder--;
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
              getCount(widget.item.menuOrder).toString(),
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
                    widget.item.menuOrder++;
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
    return RequestBuilder<AddItemToCartCubit>(
        listener: (context, cubit) {
          if (cubit.state is SuccessState) {
            setState(() {
              // cubit.model!.quantity = count;
              cartItems.add(cubit.model!);
              cartItemsImages.add(widget.item);
            });
            print(cartItemsImages);
            print(cartItems.length);
          }
        },
        contentBuilder: (context, cubit) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
            child: CustomButton(
              onTap: () {
                if (widget.item.menuOrder >= 1) {
                  cubit.addItemToCart(widget.item.id.toString(),
                      widget.item.menuOrder.toString());
                } else {
                  popDialog(
                      context: context,
                      title: 'خطأ',
                      content: 'برجاء أضافة عدد العناصر',
                      boxColor: AppColors.redColor);
                }
              },
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
        },
        loadingView: Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor)),
        retry: (context, cubit) {
          cubit.addItemToCart(
              widget.item.id.toString(), widget.item.menuOrder.toString());
        });
  }

  buildProductImage(ProductModel product) {
    return buildImage(
      height: product.description.isEmpty ? 35.h : 30.h,
      width: 80.w,
      imageUrl: product.images.first.src,
    );
  }

  Padding buildFavoriteIcon() {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 2.w, top: 2.w),
      child: InkWell(
          onTap: () {
            setState(() {
              // widget.item.isFavorite = !widget.item.isFavorite;
            });
          },
          child: Icon(
            // widget.item.isFavorite ?
            // Icons.favorite :
            Icons.favorite_border,
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

List<CartOrderModel> cartItems = [];
List<ProductModel> cartItemsImages = [];
