// import 'package:flutter/material.dart';
// import 'package:hassel/app.dart';
// import 'package:hassel/features/profile/my_orders/my_orders_screen.dart';
// import 'package:hassel/features/profile/my_orders/order_track_line.dart';
// import 'package:hassel/shared/app_utils/app_assets.dart';
// import 'package:hassel/shared/app_utils/app_colors.dart';
// import 'package:hassel/shared/app_utils/app_sized_box.dart';
// import 'package:hassel/shared/app_utils/app_text_style.dart';
// import 'package:hassel/shared/app_widgets/widgets_helper.dart';
// import 'package:sizer/sizer.dart';
// import 'package:touch_ripple_effect/touch_ripple_effect.dart';
//
// class TrackingOrderScreen extends StatefulWidget {
//   const TrackingOrderScreen({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<TrackingOrderScreen> createState() => _TrackingOrderScreenState();
// }
//
// class _TrackingOrderScreenState extends State<TrackingOrderScreen> {
//   String? imageLeading;
//   Widget? content;
//   OrderDetails order = OrderDetails(
//     placed: '١٧ نوفمبر ٢٠٢٢',
//     confirm: '١٧ نوفمبر ٢٠٢٢',
//     shipped: '١٧ نوفمبر ٢٠٢٢',
//     outDelivery: 'جاري',
//     delivered: 'جاري',
//   );
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: WidgetsHelper.customAppBar(context, title: App.tr.trackOrder),
//       body: Column(
//         children: [
//           AppSizedBox.s3,
//           buildTrackingWidget(
//             image: AppAssets.myordersIcon,
//             content: buildOrder(),
//           ),
//           Stack(
//             clipBehavior: Clip.none,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   AppSizedBox.s2,
//                   buildOrderStep(  'تم الطلب ', order.placed),
//                   buildOrderStep(  'تم تأكيد الطلب ', order.confirm),
//                   buildOrderStep(  'تم شحن الطلب ', order.shipped),
//                   buildOrderStep(  'خرج للتوصيل', order.outDelivery),
//                   buildOrderStep(  'تم التوصيل', order.delivered),
//                 ],
//               ),
//               PositionedDirectional(
//                 start: -20.w,
//                 child: Padding(
//                   padding: EdgeInsets.only(top: 4.h),
//                   child: const TrackProgress(ticks: 4),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Padding buildTrackingWidget({required String image, required Widget content}) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//         horizontal: 4.w,
//       ),
//       child: TouchRippleEffect(
//         onTap: () {},
//         rippleColor: Colors.grey.shade400,
//         child: Container(
//           color: Colors.white,
//           padding: EdgeInsets.all(2.h),
//           child: Column(
//             children: [
//               AppSizedBox.s2,
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   TouchRippleEffect(
//                     onTap: () {},
//                     rippleDuration: const Duration(milliseconds: 700),
//                     rippleColor: AppColors.primaryColor.withOpacity(.5),
//                     child: CircleAvatar(
//                       radius: 3.h,
//                       backgroundColor: AppColors.backGround,
//                       child: Image.asset(
//                         image,
//                         scale: 1.5,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 10.w,
//                   ),
//                   content,
//                   SizedBox(
//                     width: 5.w,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   buildOrder() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Text(
//           'رقم الطلب #١٦٢٢٣٥',
//           style: AppTextStyle.getSemiBoldStyle(color: AppColors.titleColor, fontSize: 11.sp),
//         ),
//         Text(
//           'طلب في ١٧ نوفمبر ٢٠٢١',
//           style: AppTextStyle.getSemiBoldStyle(color: AppColors.subTitle, fontSize: 11.sp),
//         ),
//         Row(
//           children: [
//             Text(
//               '\$18.99',
//               style: AppTextStyle.getSemiBoldStyle(color: AppColors.titleColor, fontSize: 11.sp),
//             ),
//             Text(
//               '  الاجمالي',
//               style: AppTextStyle.getSemiBoldStyle(color: AppColors.subTitle, fontSize: 11.sp),
//             ),
//             SizedBox(
//               width: 5.w,
//             ),
//             Text(
//               '10',
//               style: AppTextStyle.getSemiBoldStyle(color: AppColors.subTitle, fontSize: 11.sp),
//             ),
//             Text(
//               '  العناصر',
//               style: AppTextStyle.getSemiBoldStyle(color: AppColors.subTitle, fontSize: 11.sp),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget buildOrderStep(
//     String step,
//     String date,
//   ) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//         horizontal: 4.w,
//       ),
//       child: TouchRippleEffect(
//         onTap: () {},
//         rippleColor: Colors.grey.shade400,
//         child: SizedBox(
//           height: 11.h,
//           width: 90.w,
//           child: Row(
//             children: [
//               Container(
//                 color: Colors.white,
//                 width: 20.w,
//               ),
//               Container(
//                 height: 11.h,
//                 width: 70.w,
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       step,
//                       style:
//                           AppTextStyle.getSemiBoldStyle(color: AppColors.subTitle, fontSize: 11.sp),
//                     ),
//                     Text(
//                       date,
//                       style:
//                           AppTextStyle.getSemiBoldStyle(color: AppColors.subTitle, fontSize: 11.sp),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
