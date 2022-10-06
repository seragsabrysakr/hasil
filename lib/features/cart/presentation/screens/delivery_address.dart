import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hassel/app.dart';
import 'package:hassel/features/cart/presentation/widgets/progress_line.dart';
import 'package:hassel/shared/app_utils/app_assets.dart';
import 'package:hassel/shared/app_utils/app_colors.dart';
import 'package:hassel/shared/app_utils/app_sized_box.dart';
import 'package:hassel/shared/app_utils/app_text_style.dart';
import 'package:hassel/shared/app_widgets/custom_button.dart';
import 'package:hassel/shared/app_widgets/custom_text_form_field.dart';
import 'package:hassel/shared/app_widgets/widgets_helper.dart';
import 'package:sizer/sizer.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';

class DeliveryAddresscreen extends StatefulWidget {
  const DeliveryAddresscreen({Key? key}) : super(key: key);

  @override
  State<DeliveryAddresscreen> createState() => _DeliveryAddresscreenState();
}

class _DeliveryAddresscreenState extends State<DeliveryAddresscreen> {
  bool isSwitched = false;
  int step = 1;
  int selected = 0;
  String getTitle(int step) {
    if (step == 2) {
      return App.tr.deliveryAddress;
    } else if (step == 1) {
      return App.tr.deliveryWays;
    } else {
      return 'الدفع';
    }
  }

  List<String> title = ['باي بال', 'فيزا-ماستركارد', 'ابل باي'];
  List<IconData> icons = [Icons.paypal, Icons.payment_outlined, Icons.apple];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: WidgetsHelper.customAppBar(context, title: getTitle(step)),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppSizedBox.s3,
              ScreenProgress(
                ticks: step,
              ),
              if (step == 2) ...[
                buildAddressesView(),
              ],
              if (step == 1) ...[
                buildShippingMethods(),
              ],
              if (step == 3) ...[
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(
                            icons.length,
                            (index) => buildPaymentMethods(
                                title[index], icons[index], index)),
                      ),
                    ),
                    AppSizedBox.s3,
                    SizedBox(
                      width: 80.w,
                      height: 20.h,
                      child: SvgPicture.asset(
                        AppAssets.card,
                        clipBehavior: Clip.antiAlias,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    AppSizedBox.s3,
                    CustomTextField(
                        color: Colors.white,
                        enable: false,
                        textAlign: TextAlign.end,
                        prefix: Icon(
                          Icons.account_circle_rounded,
                          size: 13.sp,
                          color: Colors.grey.shade400,
                        ),
                        width: 85.w,
                        hint: App.tr.name,
                        validator: (String? value) {
                          return;
                        }),
                    CustomTextField(
                        color: Colors.white,
                        enable: false,
                        textAlign: TextAlign.end,
                        prefix: Icon(
                          Icons.credit_card,
                          size: 13.sp,
                          color: Colors.grey.shade400,
                        ),
                        width: 85.w,
                        hint: App.tr.name,
                        validator: (String? value) {
                          return;
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTextField(
                            color: Colors.white,
                            enable: false,
                            textAlign: TextAlign.center,
                            width: 40.w,
                            hint: 'Month/year',
                            validator: (String? value) {
                              return;
                            }),
                        SizedBox(
                          width: 2.w,
                        ),
                        CustomTextField(
                            color: Colors.white,
                            enable: false,
                            textAlign: TextAlign.center,
                            width: 40.w,
                            hint: 'CVV',
                            validator: (String? value) {
                              return;
                            }),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 5.w,
                        ),
                        Transform.scale(
                          scale: .6,
                          child: Switch.adaptive(
                              value: isSwitched,
                              activeColor: AppColors.primaryColor,
                              onChanged: (value) {
                                setState(() {
                                  isSwitched = value;
                                });
                              }),
                        ),
                        Text(
                          'حفظ الكارت',
                          style: AppTextStyle.getSemiBoldStyle(
                              color: AppColors.titleColor, fontSize: 11.sp),
                        ),
                      ],
                    ),
                  ],
                )
              ],
              CustomButton(
                onTap: () {
                  if (step < 3) {
                    setState(() {
                      step++;
                    });
                  }
                },
                fontSize: 13.sp,
                radius: .5,
                buttonColor: AppColors.primaryColor,
                titleColor: Colors.white,
                fontWeight: FontWeight.w700,
                title: step != 3 ? App.tr.next : App.tr.completePayment,
                height: 6.h,
                width: 80.w,
              ),
              AppSizedBox.s5,
            ],
          ),
        ),
      ),
    );
  }

  Column buildAddressesView() {
    return Column(
      children: [
        AppSizedBox.s1,
        const SizedBox(
          width: double.infinity,
        ),
        buildAddressForm(),
      ],
    );
  }

  buildAddressForm() {
    return Form(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppSizedBox.s3,
        CustomTextField(
            color: Colors.white,
            enable: false,
            textAlign: TextAlign.end,
            prefix: Icon(
              Icons.account_circle_rounded,
              size: 13.sp,
              color: Colors.grey.shade400,
            ),
            width: 85.w,
            hint: App.tr.name,
            validator: (String? value) {
              return;
            }),
        CustomTextField(
            color: Colors.white,
            enable: false,
            textAlign: TextAlign.end,
            prefix: Icon(
              Icons.email_outlined,
              size: 13.sp,
              color: Colors.grey.shade400,
            ),
            width: 85.w,
            hint: App.tr.email,
            validator: (String? value) {
              return;
            }),
        CustomTextField(
            color: Colors.white,
            enable: false,
            textAlign: TextAlign.end,
            // suffix: Icons.arrow_drop_down,
            prefix: Icon(
              Icons.call,
              size: 13.sp,
              color: Colors.grey.shade400,
            ),
            width: 85.w,
            hint: App.tr.mobil,
            validator: (String? value) {
              return;
            }),
        CustomTextField(
            color: Colors.white,
            enable: false,
            textAlign: TextAlign.end,
            // suffix: Icons.arrow_drop_down,
            prefix: Icon(
              Icons.location_pin,
              size: 13.sp,
              color: Colors.grey.shade400,
            ),
            width: 85.w,
            hint: App.tr.address,
            validator: (String? value) {
              return;
            }),
        CustomTextField(
            color: Colors.white,
            enable: false,
            textAlign: TextAlign.end,
            // suffix: Icons.arrow_drop_down,1
            prefix: Icon(
              Icons.wysiwyg,
              size: 13.sp,
              color: Colors.grey.shade400,
            ),
            width: 85.w,
            hint: 'الرمز البريدي',
            validator: (String? value) {
              return;
            }),
        CustomTextField(
            color: Colors.white,
            enable: false,
            textAlign: TextAlign.end,
            // suffix: Icons.arrow_drop_down,1
            prefix: Icon(
              Icons.flag,
              size: 13.sp,
              color: Colors.grey.shade400,
            ),
            width: 85.w,
            hint: 'المدينة',
            validator: (String? value) {
              return;
            }),
        CustomTextField(
            color: Colors.white,
            enable: false,
            textAlign: TextAlign.end,
            // suffix: Icons.arrow_drop_down,1
            prefix: Icon(
              Icons.blur_circular_outlined,
              size: 13.sp,
              color: Colors.grey.shade400,
            ),
            width: 85.w,
            hint: ' الدولة',
            validator: (String? value) {
              return;
            }),
        Row(
          children: [
            // Transform.scale(
            //   scale: .6,
            //   child: Switch.adaptive(
            //       value: isSwitched,
            //       onChanged: (value) {
            //         setState(() {
            //           isSwitched = value;
            //         });
            //       }),
            // ),
            const Spacer(
              flex: 1,
            ),
            TouchRippleEffect(
              onTap: () {},
              rippleColor: Colors.grey.shade300,
              child: Text(
                'حفظ العنوان',
                style: AppTextStyle.getSemiBoldStyle(
                    color: AppColors.primaryColor, fontSize: 11.sp),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
          ],
        ),
        // AppSizedBox.s9,
        AppSizedBox.s2,
      ],
    ));
  }

  buildShippingMethods() {
    return Center(
      child: Column(
        children: [
          AppSizedBox.s9,
          AppSizedBox.s9,
          AppSizedBox.s4,
          Container(
            width: 90.w,
            height: 14.h,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(.5.h),
                border: Border.all(color: AppColors.primaryColor, width: .4.w)),
            child: Row(
              children: [
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 2.5.h,
                    ),
                    Text(
                      'الشحن خلال اليوم',
                      style: AppTextStyle.getRegularStyle(
                          color: Colors.black, fontSize: 10.sp),
                    ),
                    AppSizedBox.s2,
                    Text(
                      'ضع طلبك قبل الساعة ٦ مساءا مع اغراضك',
                      style: AppTextStyle.getRegularStyle(
                          color: AppColors.subTitle, fontSize: 10.sp),
                    ),
                    Text(
                      'سيتم تسليمها في اليوم التالي',
                      style: AppTextStyle.getRegularStyle(
                          color: AppColors.subTitle, fontSize: 10.sp),
                    ),
                  ],
                ),
                const Spacer(
                  flex: 1,
                ),
                Text(
                  '٥ ريال',
                  style: AppTextStyle.getRegularStyle(
                      color: AppColors.primaryColor, fontSize: 11.sp),
                ),
                SizedBox(
                  width: 5.w,
                ),
              ],
            ),
          ),
          AppSizedBox.s9,
          AppSizedBox.s9,
          AppSizedBox.s9,
          AppSizedBox.s3,
        ],
      ),
    );
  }

  buildPaymentMethods(String title, IconData icon, int index) {
    bool select = selected == index;
    return TouchRippleEffect(
      rippleColor: Colors.grey.shade300,
      onTap: () {
        setState(() {
          selected = index;
        });
      },
      child: Column(
        children: [
          AppSizedBox.s2,
          Container(
            height: 10.h,
            width: 25.w,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(.5.h),
                border: Border.all(
                    color: select ? AppColors.primaryColor : Colors.white,
                    width: .4.w)),
            child: Column(
              children: [
                AppSizedBox.s2,
                Icon(
                  icon,
                  color: select ? AppColors.primaryColor : Colors.grey.shade500,
                ),
                AppSizedBox.s1,
                Text(
                  title,
                  style: AppTextStyle.getRegularStyle(
                      color: select
                          ? AppColors.primaryColor
                          : Colors.grey.shade500,
                      fontSize: 8.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
