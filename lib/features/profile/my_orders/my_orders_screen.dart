import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hassel/app.dart';
import 'package:hassel/features/profile/widgets/details_widget.dart';
import 'package:hassel/shared/app_utils/app_assets.dart';
import 'package:hassel/shared/app_utils/app_colors.dart';
import 'package:hassel/shared/app_utils/app_sized_box.dart';
import 'package:hassel/shared/app_utils/app_text_style.dart';
import 'package:hassel/shared/app_widgets/custom_text.dart';
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
      appBar: AppBar(
          centerTitle: true,
          title: CustomText(
            text: App.tr.myOrders,
            size: 15.sp,
            weight: FontWeight.bold,
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  AppAssets.filter,
                  color: AppColors.titleColor,
                ))
          ]),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Column(
          children: [
            buildOrderDetailsWidget(
                state: false, steps: 3, order: order1, details: details1),
            buildOrderDetailsWidget(
                state: false, steps: 3, order: order1, details: details2),
            buildOrderDetailsWidget(
                state: false, steps: 3, order: order1, details: details3),
            buildOrderDetailsWidget(
                state: true, steps: 5, order: order2, details: details4),
            buildOrderDetailsWidget(
                state: true, steps: 5, order: order2, details: details5),
          ],
        ),
      ),
    );
  }

  buildOrderDetailsWidget(
      {required bool state,
      required int steps,
      required OrderDetails order,
      required bool details}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: DetailsWidget(
          logo: false,
          delivered: state,
          imageLeading: !state ? AppAssets.orderOn : AppAssets.orderOff,
          content: buildOrder(),
          detailsWidget: state
              ? buildOrderDelived(order)
              : buildOrderDetails(steps, order)),
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
                    order.delivered,
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

  buildOrder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'الطلب #171190',
          style: AppTextStyle.getSemiBoldStyle(
              color: AppColors.titleColor, fontSize: 11.sp),
        ),
        Text(
          'طلب في ١٧ نوفمبر ٢٠٢١',
          style: AppTextStyle.getSemiBoldStyle(
              color: AppColors.subTitle, fontSize: 11.sp),
        ),
        Row(
          children: [
            Text(
              '\$18.99',
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
              '10',
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
                buildOrderStep('تم الطلب ', order.placed),
                buildOrderStep('تم تأكيد الطلب ', order.confirm),
                buildOrderStep('تم شحن الطلب ', order.shipped),
                buildOrderStep('خرج للتوصيل', order.outDelivery),
                buildOrderStep('تم التوصيل', order.delivered),
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
}

class OrderDetails {
  final String placed;
  final String confirm;
  final String shipped;
  final String outDelivery;
  final String delivered;

  OrderDetails({
    required this.placed,
    required this.confirm,
    required this.shipped,
    required this.outDelivery,
    required this.delivered,
  });
}

OrderDetails order1 = OrderDetails(
  placed: '١٧ نوفمبر ٢٠٢٢',
  confirm: '١٧ نوفمبر ٢٠٢٢',
  shipped: '١٧ نوفمبر ٢٠٢٢',
  outDelivery: 'جاري',
  delivered: 'جاري',
);
OrderDetails order2 = OrderDetails(
  placed: '١٧ نوفمبر ٢٠٢٢',
  confirm: '١٧ نوفمبر ٢٠٢٢',
  shipped: '١٧ نوفمبر ٢٠٢٢',
  outDelivery: '١٧ نوفمبر ٢٠٢٢',
  delivered: '١٧ نوفمبر ٢٠٢٢',
);
bool details1 = true;
bool details2 = true;
bool details3 = true;
bool details4 = false;
bool details5 = false;
