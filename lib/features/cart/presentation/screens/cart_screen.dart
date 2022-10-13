import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hassel/app.dart';
import 'package:hassel/app_routes.dart';
import 'package:hassel/features/home/presentation/widgets/product_item.dart';
import 'package:hassel/shared/app_utils/app_colors.dart';
import 'package:hassel/shared/app_utils/app_navigator.dart';
import 'package:hassel/shared/app_utils/app_sized_box.dart';
import 'package:hassel/shared/app_utils/app_text_style.dart';
import 'package:hassel/shared/app_widgets/custom_button.dart';
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
  List<Product> productItems = List.of(cart).toSet().toList();
  bool orderComplete = false;
  bool orderList = true;
  bool orderEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetsHelper.customAppBar(context,
          title: orderComplete ? App.tr.completeRequest : App.tr.cart, cart: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        child: CustomScrollView(
          slivers: [
            if (orderList) ...[
              buildCartItemList(),
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
      ),
    );
  }

  SliverList buildCartItemList() {
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      return buildCartItem(context, cart[index], index);
    }, childCount: cart.length));
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
                    style: AppTextStyle.getMediumStyle(color: AppColors.subTitle, fontSize: 10.sp),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Text(
                    '123.5 ريال',
                    style: AppTextStyle.getMediumStyle(color: AppColors.subTitle, fontSize: 10.sp),
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
                    style: AppTextStyle.getMediumStyle(color: AppColors.subTitle, fontSize: 10.sp),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Text(
                    '123.5 ريال',
                    style: AppTextStyle.getMediumStyle(color: AppColors.subTitle, fontSize: 10.sp),
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
                    style: AppTextStyle.getBoldStyle(color: AppColors.titleColor, fontSize: 13.sp),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Text(
                    '123.5 ريال',
                    style: AppTextStyle.getBoldStyle(color: AppColors.titleColor, fontSize: 13.sp),
                  ),
                ],
              ),
            ),
            AppSizedBox.s1,
            CustomButton(
              onTap: () async {
                var result = await Navigator.pushNamed(context, Routes.deliveryAddresscreen);
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
          AppNavigator.navigateTo(context: context, screen: Routes.trackingOrderScreen);
        },
        item: EmptyItemModel(
          mainTextHeader: 'تم إكتمال طلبك ',
          mainHeader: 'بنجاح',
          h1: 'سوف تحصل علي رد من إدارة',
          h2: 'المتجر',
          h3: 'خلال دقائق',
        ),
        txt: ' تتبع الطلب',
      ),
    );
  }

  SliverToBoxAdapter buildEmptyView() {
    return SliverToBoxAdapter(
      child: EmptyViewScreen(
        item: EmptyItemModel(
          mainTextHeader: 'سلة الشراء فارغة',
          h1: 'تسوق لبعض المنتجات بالترتيب',
          h2: 'لشرائها',
        ),
        txt: 'أبدأ بالتسوق',
      ),
    );
  }

  Widget buildCartItem(BuildContext cxt, Product item, int index) {
    return Slidable(
      key: Key(UniqueKey().toString()),
      endActionPane: ActionPane(
        extentRatio: .2,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            autoClose: false,
            onPressed: (context) {
              cart.removeAt(index);
              // productItems.removeAt(index);

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
          height: 12.h,
          child: Row(
            children: [
              SizedBox(
                width: 8.w,
              ),
              Image.asset(
                item.image,
                scale: 2.5,
              ),
              const Spacer(
                flex: 1,
              ),
              buildItemsDetails(item),
              SizedBox(
                width: 10.w,
              ),
              buildItemsAction(index),
            ],
          ),
        ),
      ),
    );
  }

  Column buildItemsDetails(Product item) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '\$1.22 x 5',
          style: AppTextStyle.getBoldStyle(color: AppColors.primaryColor, fontSize: 11.sp),
        ),
        Text(
          item.name,
          style: AppTextStyle.getBoldStyle(color: AppColors.titleColor, fontSize: 12.sp),
        ),
        Text(
          '1.50 ibs',
          style: AppTextStyle.getMediumStyle(color: AppColors.subTitle, fontSize: 12.sp),
        ),
      ],
    );
  }

  Container buildItemsAction(int index) {
    return Container(
      decoration: BoxDecoration(
        border: BorderDirectional(
          start: BorderSide(
            color: AppColors.subTitle.withOpacity(.2),
          ),
        ),
      ),
      child: Column(
        children: [
          Material(
            child: InkWell(
              onTap: () {
                setState(() {
                  productItems[index].count--;
                });
              },
              child: Container(
                height: 4.h,
                width: 10.w,
                decoration: BoxDecoration(
                  border: BorderDirectional(
                    bottom: BorderSide(
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
            height: 4.h,
            width: 10.w,
            child: Center(
              child: Text(
                productItems[index].count.toString(),
                style: AppTextStyle.getBoldStyle(color: AppColors.titleColor, fontSize: 14.sp),
              ),
            ),
          ),
          Material(
            child: InkWell(
              onTap: () {
                setState(() {
                  productItems[index].count++;
                });
              },
              child: Container(
                height: 4.h,
                width: 10.w,
                decoration: BoxDecoration(
                  border: BorderDirectional(
                    top: BorderSide(
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
    );
  }
}

List<Product> cart = [
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
