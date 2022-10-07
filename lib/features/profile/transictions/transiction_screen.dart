import 'package:flutter/material.dart';
import 'package:hassel/app.dart';
import 'package:hassel/shared/app_utils/app_colors.dart';
import 'package:hassel/shared/app_utils/app_sized_box.dart';
import 'package:hassel/shared/app_utils/app_text_style.dart';
import 'package:hassel/shared/app_widgets/widgets_helper.dart';
import 'package:sizer/sizer.dart';

class TransictiosScreen extends StatelessWidget {
  const TransictiosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetsHelper.customAppBar(context, title: App.tr.myPayments),
      body: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 3.h),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: double.infinity,
              ),
              AppSizedBox.s2,
              paymentItem(
                type: 'Master Card',
                date: 'Dec, 10 2020 at 10.00 PM',
                total: "١٦ ريال",
              ),
              paymentItem(
                type: 'Visa Card /Visa Debit',
                date: 'Dec, 10 2020 at 10.00 PM',
                total: "١٦ ريال",
              ),
              paymentItem(
                type: 'PayPal Payment',
                date: 'Dec, 10 2020 at 10.00 PM',
                total: "١٦ ريال",
              ),
              paymentItem(
                type: 'Master Card',
                date: 'Dec, 10 2020 at 10.00 PM',
                total: "١٦ ريال",
              ),
              paymentItem(
                type: 'Paypal Payment',
                date: 'Dec, 10 2020 at 10.00 PM',
                total: "١٦ ريال",
              ),
              paymentItem(
                type: 'Visa Card /Visa Debit',
                date: 'Dec, 10 2020 at 10.00 PM',
                total: "١٦ ريال",
              ),
              paymentItem(
                type: 'PayPal Payment',
                date: 'Dec, 10 2020 at 10.00 PM',
                total: "١٦ ريال",
              ),
              paymentItem(
                type: 'Master Card',
                date: 'Dec, 10 2020 at 10.00 PM',
                total: "١٦ ريال",
              ),
              paymentItem(
                type: 'Paypal Payment',
                date: 'Dec, 10 2020 at 10.00 PM',
                total: "١٦ ريال",
              ),
            ],
          )),
    );
  }

  Widget paymentItem({
    required String type,
    required String date,
    required String total,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: Container(
        color: Colors.white,
        height: 10.h,
        width: 90.w,
        child: Row(
          children: [
            SizedBox(
              width: 5.w,
            ),
            CircleAvatar(
              backgroundColor: Colors.grey.shade200,
              radius: 3.5.h,
            ),
            SizedBox(
              width: 5.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSizedBox.s2,
                Text(
                  type,
                  style:
                      AppTextStyle.getSemiBoldStyle(color: AppColors.titleColor, fontSize: 11.sp),
                ),
                Text(
                  date,
                  style: AppTextStyle.getRegularStyle(color: AppColors.subTitle, fontSize: 7.sp),
                ),
              ],
            ),
            const Spacer(
              flex: 1,
            ),
            Text(
              total,
              style: AppTextStyle.getBoldStyle(color: AppColors.primaryColor, fontSize: 11.sp),
            ),
            SizedBox(
              width: 5.w,
            ),
          ],
        ),
      ),
    );
  }
}
