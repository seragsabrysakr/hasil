import 'package:flutter/material.dart';
import 'package:hassel/app.dart';
import 'package:hassel/shared/app_utils/app_colors.dart';
import 'package:hassel/shared/app_utils/app_sized_box.dart';
import 'package:hassel/shared/app_utils/app_text_style.dart';
import 'package:hassel/shared/app_widgets/widgets_helper.dart';
import 'package:sizer/sizer.dart';

class NotiFicationScreen extends StatefulWidget {
  const NotiFicationScreen({Key? key}) : super(key: key);

  @override
  State<NotiFicationScreen> createState() => _NotiFicationScreenState();
}

class _NotiFicationScreenState extends State<NotiFicationScreen> {
  bool allNotify = false;
  bool emailNotify = false;
  bool ordersNotify = false;
  bool publicNotify = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetsHelper.customAppBar(context, title: App.tr.notifications),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: double.infinity,
          ),
          AppSizedBox.s3,
          buildNotificationItem(
              isSwitch: allNotify,
              title: App.tr.enableAllNotifications,
              subTitle1: App.tr.enableAllNotificationsH1,
              subTitle2: App.tr.enableAllNotificationsH2),
          buildNotificationItem(
              isSwitch: emailNotify,
              title: App.tr.enableMailNotifications,
              subTitle1: App.tr.enableMailNotificationsH1,
              subTitle2: App.tr.enableMailNotificationsH2),
          buildNotificationItem(
              isSwitch: ordersNotify,
              title: App.tr.enableOrdersNotifications,
              subTitle1: App.tr.enableOrdersNotificationsH1,
              subTitle2: App.tr.enableOrdersNotificationsH2),
          buildNotificationItem(
              isSwitch: publicNotify,
              title: App.tr.enableNotifications,
              subTitle1: App.tr.enableNotificationsH1,
              subTitle2: App.tr.enableNotificationsH2),
        ],
      ),
    );
  }

  Widget buildNotificationItem({
    bool isSwitch = false,
    required String title,
    required String subTitle1,
    required String subTitle2,
  }) {
    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        return Padding(
          padding: EdgeInsets.only(bottom: 1.h),
          child: Container(
            height: 31.w,
            width: 90.w,
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 1.5.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(
                  flex: 1,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AppSizedBox.s1,
                    Text(
                      title,
                      style: AppTextStyle.getSemiBoldStyle(
                          color: AppColors.titleColor, fontSize: 11.sp),
                    ),
                    AppSizedBox.s2,
                    Text(
                      subTitle1,
                      style:
                          AppTextStyle.getRegularStyle(color: AppColors.subTitle, fontSize: 7.sp),
                    ),
                    Text(
                      subTitle2,
                      style:
                          AppTextStyle.getRegularStyle(color: AppColors.subTitle, fontSize: 7.sp),
                    ),
                  ],
                ),
                Transform.scale(
                  scale: .6,
                  child: Switch.adaptive(
                      value: isSwitch,
                      onChanged: (value) {
                        setState(() {
                          isSwitch = value;
                        });
                      }),
                ),
                SizedBox(
                  width: 4.w,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
