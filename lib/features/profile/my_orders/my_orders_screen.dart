import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassel/app.dart';
import 'package:hassel/app_routes.dart';
import 'package:hassel/core/app_business_logic/state_renderer/request_builder.dart';
import 'package:hassel/core/dependency_injection/dependency_injection.dart';
import 'package:hassel/data/model/order_model.dart';
import 'package:hassel/features/profile/my_orders/cubits/orders_cubit.dart';
import 'package:hassel/features/profile/widgets/details_widget.dart';
import 'package:hassel/shared/app_utils/app_assets.dart';
import 'package:hassel/shared/app_utils/app_colors.dart';
import 'package:hassel/shared/app_utils/app_sized_box.dart';
import 'package:hassel/shared/app_utils/app_text_style.dart';
import 'package:hassel/shared/app_widgets/widgets_helper.dart';
import 'package:sizer/sizer.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetsHelper.customAppBar(context, title: App.tr.myOrders),
      body: BlocProvider(
        create: (context) => getIt<OrdersCubit>()..getAllProducts(),
        child: RequestBuilder<OrdersCubit>(
            listener: (context, cubit) {},
            contentBuilder: (context, cubit) {
              List<OrderDetails> myOrders = [];
              for (int i = 0; i < cubit.orders.length; i++) {
                myOrders.add(OrderDetails(cubit.orders[i]));
              }
              return buildScreenContent(myOrders, context);
            },
            retry: (context, cubit) {
              cubit.getAllProducts();
            }),
      ),
    );
  }
}

SingleChildScrollView buildScreenContent(
    List<OrderDetails> myOrders, BuildContext context) {
  return SingleChildScrollView(
    padding: EdgeInsets.symmetric(vertical: 1.h),
    child: Column(
      children: List.generate(
          myOrders.length,
          (index) => buildOrderDetailsWidget(context,
              state: getStep(myOrders[index].order.status) == 3,
              steps: getStep(myOrders[index].order.status),
              order: myOrders[index],
              details: !myOrders[index].details)),
    ),
  );
}

buildOrderDetailsWidget(BuildContext context,
    {required bool state,
    required int steps,
    required OrderDetails order,
    required bool details}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.h),
    child: DetailsWidget(
        onTap: () {
          Navigator.pushNamed(context, Routes.trackingOrderScreen,
              arguments: order.order);
        },
        logo: false,
        delivered: state,
        imageLeading: !state ? AppAssets.orderOn : AppAssets.orderOff,
        content: buildOrder(order),
        detailsWidget:
            state ? buildOrderDelived(order) : buildOrderDetails(steps, order)),
  );
}

Padding buildOrderDelived(OrderDetails order) {
  return Padding(
    padding: EdgeInsets.only(top: 1.h),
    child: Container(
      padding: EdgeInsets.only(top: 1.h),
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade400))),
      child: Row(
        children: [
          Container(
            padding: EdgeInsetsDirectional.only(end: 4.w, start: 4.w),
            height: 3.h,
            width: 80.w,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.circle_outlined,
                  color: Colors.grey.shade300,
                ),
                SizedBox(
                  width: 2.w,
                ),
                Text(
                  order.order.dateCompleted ?? 'جاري',
                  style: AppTextStyle.getSemiBoldStyle(
                      color: AppColors.subTitle, fontSize: 11.sp),
                ),
                const Spacer(
                  flex: 1,
                ),
                Text(
                  'تم التوصيل',
                  style: AppTextStyle.getSemiBoldStyle(
                      color: AppColors.subTitle, fontSize: 11.sp),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

buildOrder(OrderDetails order) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Text(
        'الطلب #${order.order.number}',
        style: AppTextStyle.getSemiBoldStyle(
            color: AppColors.titleColor, fontSize: 11.sp),
      ),
      Row(
        children: [
          Text(
            '${order.order.dateCreated}',
            style: AppTextStyle.getSemiBoldStyle(
                color: AppColors.subTitle, fontSize: 11.sp),
          ),
          Text(
            '  طلب في',
            style: AppTextStyle.getSemiBoldStyle(
                color: AppColors.subTitle, fontSize: 11.sp),
          ),
        ],
      ),
      Row(
        children: [
          Text(
            '${order.order.total} ${order.order.currency}',
            style: AppTextStyle.getSemiBoldStyle(
                color: AppColors.titleColor, fontSize: 11.sp),
          ),
          Text(
            '  الاجمالي',
            style: AppTextStyle.getSemiBoldStyle(
                color: AppColors.subTitle, fontSize: 11.sp),
          ),
          SizedBox(
            width: 5.w,
          ),
          Text(
            order.order.lineItems.length.toString(),
            style: AppTextStyle.getSemiBoldStyle(
                color: AppColors.subTitle, fontSize: 11.sp),
          ),
          Text(
            '  العناصر',
            style: AppTextStyle.getSemiBoldStyle(
                color: AppColors.subTitle, fontSize: 11.sp),
          ),
        ],
      ),
    ],
  );
}

buildOrderDetails(int steps, OrderDetails order) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.h),
    child: Container(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade400))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AppSizedBox.s1,
              buildOrderStep('تم الطلب ', order.order.dateCreated),
              buildOrderStep('تم تأكيد الطلب ', 'جاري'),
              buildOrderStep('تم شحن الطلب ', 'جاري'),
              buildOrderStep('خرج للتوصيل', 'جاري'),
              buildOrderStep('تم التوصيل', order.order.dateCompleted ?? 'جاري'),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Container(
              decoration: BoxDecoration(
                  border: BorderDirectional(
                      end: BorderSide(
                color: AppColors.primaryColor,
              ))),
              height: steps * 3.3.h,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildOrderStep(
  String step,
  String date,
) {
  return Container(
    padding: EdgeInsetsDirectional.only(end: 4.w),
    height: 4.h,
    width: 80.w,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          date,
          style: AppTextStyle.getSemiBoldStyle(
              color: AppColors.subTitle, fontSize: 11.sp),
        ),
        const Spacer(
          flex: 1,
        ),
        Text(
          step,
          style: AppTextStyle.getSemiBoldStyle(
              color: AppColors.subTitle, fontSize: 11.sp),
        ),
      ],
    ),
  );
}

class OrderDetails {
  final OrderModel order;
  bool details;

  OrderDetails(
    this.order, {
    this.details = false,
  });
}

int getStep(String status) {
  switch (status) {
    case 'pending':
      return 0;
    case 'processing':
      return 1;
    case 'on-hold':
      return 2;
    case 'completed':
      return 3;
    case 'refunded':
      return 0;
    case 'failed':
      return 0;
    case 'trash':
      return 0;
  }
  return 0;
}
