import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hassel/app.dart';
import 'package:hassel/app_routes.dart';
import 'package:hassel/core/app_business_logic/state_renderer/state_renderer_impl.dart';
import 'package:hassel/data/model/cart_order_model.dart';
import 'package:hassel/data/model/productModel.dart';
import 'package:hassel/features/home/presentation/cubits/add_item_cubit.dart';
import 'package:hassel/features/home/presentation/screens/product_details_screen.dart';
import 'package:hassel/shared/app_utils/app_colors.dart';
import 'package:hassel/shared/app_utils/app_navigator.dart';
import 'package:hassel/shared/app_utils/app_sized_box.dart';
import 'package:hassel/shared/app_utils/app_text_style.dart';
import 'package:hassel/shared/app_widgets/custom_button.dart';
import 'package:hassel/shared/app_widgets/custom_network_image.dart';
import 'package:hassel/shared/app_widgets/custom_stepper.dart';
import 'package:hassel/shared/app_widgets/empty_view/empty_item_model.dart';
import 'package:hassel/shared/app_widgets/empty_view/empty_view_screen.dart';
import 'package:hassel/shared/app_widgets/widgets_helper.dart';
import 'package:sizer/sizer.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<ProductModel> productItems = [];
  List<CartOrderModel> cartItems = [];
  bool orderComplete = false;
  bool orderList = false;
  bool orderEmpty = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetsHelper.customAppBar(context,
          title: orderComplete ? App.tr.completeRequest : App.tr.cart,
          cart: false),
      body: BlocConsumer<AddItemToCartCubit, FlowState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cart = AddItemToCartCubit.get(context).cartItems;
          cartItems = List.from(cart);

          orderList = cartItems.isNotEmpty;
          orderEmpty = cartItems.isEmpty;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: CustomScrollView(
              slivers: [
                if (orderList) ...[
                  buildCartItemList(cartItems),
                  buildCartFooter(),
                ],
                if (orderEmpty) ...[
                  buildEmptyView(),
                ],
                if (orderComplete) ...[
                  buildOrderComplete(),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  SliverList buildCartItemList(List<CartOrderModel> cartItems) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      return buildCartItem(context, cartItems[index], index);
    }, childCount: cartItems.length));
  }

  SliverToBoxAdapter buildCartFooter() {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.all(1.h),
        color: Colors.white,
        height: 20.h,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Row(
                children: [
                  Text(
                    App.tr.subTotal,
                    style: AppTextStyle.getMediumStyle(
                        color: AppColors.subTitle, fontSize: 10.sp),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Text(
                    '123.5 ????????',
                    style: AppTextStyle.getMediumStyle(
                        color: AppColors.subTitle, fontSize: 10.sp),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Row(
                children: [
                  Text(
                    App.tr.deliveryCharge,
                    style: AppTextStyle.getMediumStyle(
                        color: AppColors.subTitle, fontSize: 10.sp),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Text(
                    '123.5 ????????',
                    style: AppTextStyle.getMediumStyle(
                        color: AppColors.subTitle, fontSize: 10.sp),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Divider(
                color: AppColors.subTitle,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 2.w,
              ),
              child: Row(
                children: [
                  Text(
                    App.tr.total,
                    style: AppTextStyle.getBoldStyle(
                        color: AppColors.titleColor, fontSize: 13.sp),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Text(
                    '123.5 ????????',
                    style: AppTextStyle.getBoldStyle(
                        color: AppColors.titleColor, fontSize: 13.sp),
                  ),
                ],
              ),
            ),
            AppSizedBox.s1,
            CustomButton(
              onTap: () async {
                var result = await Navigator.pushNamed(
                    context, Routes.deliveryAddresscreen);
                if (result == 'done') {
                  setState(() {
                    orderComplete = true;
                    orderList = false;
                    orderEmpty = false;
                  });
                }
              },
              fontSize: 13.sp,
              radius: .5,
              buttonColor: AppColors.primaryColor,
              titleColor: Colors.white,
              fontWeight: FontWeight.bold,
              title: App.tr.goCheckOut,
              height: 6.h,
              width: 80.w,
            )
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter buildOrderComplete() {
    return SliverToBoxAdapter(
      child: EmptyViewScreen(
        image: true,
        onTap: () {
          AppNavigator.navigateTo(
              context: context, screen: Routes.trackingOrderScreen);
        },
        item: EmptyItemModel(
          mainTextHeader: '???? ???????????? ???????? ',
          mainHeader: '??????????',
          h1: '?????? ???????? ?????? ???? ???? ??????????',
          h2: '????????????',
          h3: '???????? ??????????',
        ),
        txt: ' ???????? ??????????',
      ),
    );
  }

  SliverToBoxAdapter buildEmptyView() {
    return SliverToBoxAdapter(
      child: EmptyViewScreen(
        item: EmptyItemModel(
          mainTextHeader: '?????? ???????????? ??????????',
          h1: '???????? ???????? ???????????????? ????????????????',
          h2: '??????????????',
        ),
        txt: '???????? ??????????????',
      ),
    );
  }

  Widget buildCartItem(BuildContext cxt, CartOrderModel item, int index) {
    return Slidable(
      key: Key(UniqueKey().toString()),
      endActionPane: ActionPane(
        extentRatio: .2,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            autoClose: false,
            onPressed: (context) {
              // cart.removeAt(index);
              print(productItems[index].name);
              setState(() {});
            },
            backgroundColor: AppColors.redColor,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: '',
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: 2.h),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(.5.h),
            color: Colors.white,
          ),
          height: 13.5.h,
          child: Row(
            children: [
              SizedBox(
                width: 8.w,
              ),
              buildImage(
                height: 10.h,
                width: 28.w,
                imageUrl: cartItemsImages[index].images.first.src,
              ),
              const Spacer(
                flex: 1,
              ),
              buildItemsDetails(item),
              SizedBox(
                width: 10.w,
              ),
              buildItemsAction(item),
            ],
          ),
        ),
      ),
    );
  }

  Column buildItemsDetails(CartOrderModel item) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 20.w,
          child: Text(
            (item.quantity * double.parse(item.productPrice.substring(0, 4)))
                .toString(),
            maxLines: 1,
            style: AppTextStyle.getBoldStyle(
                color: AppColors.primaryColor, fontSize: 11.sp),
          ),
        ),
        Text(
          item.productName,
          style: AppTextStyle.getBoldStyle(
              color: AppColors.titleColor, fontSize: 12.sp),
        ),
        Text(
          '???????? ' + item.productPrice.toString(),
          style: AppTextStyle.getMediumStyle(
              color: AppColors.subTitle, fontSize: 12.sp),
        ),
      ],
    );
  }

  Container buildItemsAction(CartOrderModel item) {
    int qty = 0;

    return Container(
      decoration: BoxDecoration(
        border: BorderDirectional(
          start: BorderSide(
            color: AppColors.subTitle.withOpacity(.2),
          ),
        ),
      ),
      child: CustomViStepper(
        lowerLimit: 0,
        upperLimit: 20,
        stepValue: 1,
        iconSize: 22.0,
        value: item.quantity.toInt(),
        onChanged: (value) {
          setState(() {
            item.quantity = value;
          });
        },
      ),
    );
  }
}
