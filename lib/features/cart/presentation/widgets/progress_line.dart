import 'package:flutter/material.dart';
import 'package:hassel/shared/app_utils/app_colors.dart';
import 'package:hassel/shared/app_utils/app_text_style.dart';
import 'package:sizer/sizer.dart';

import '../../../../app.dart';

class ScreenProgress extends StatelessWidget {
  final int ticks;

  const ScreenProgress({
    Key? key,
    required this.ticks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70.w,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: .5.h),
            child: Row(
              children: <Widget>[
                tick1(),
                line1(),
                tick2(),
                line2(),
                tick3(),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: .5.h),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                _processText1(context),
                SizedBox(
                  width: 19.w,
                ),
                _processText2(context),
                SizedBox(
                  width: 21.w,
                ),
                _processText3(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget tick(bool isChecked, int tick, {bool isTick = false}) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: .5.h),
        child: isChecked
            ? CircleAvatar(
                radius: 2.3.h,
                backgroundColor: AppColors.primaryColor,
                child: isTick
                    ? Text(
                        tick.toString(),
                        style: AppTextStyle.getMediumStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                        ),
                      )
                    : const Icon(
                        Icons.check,
                        color: Colors.white,
                      ))
            : CircleAvatar(
                radius: 2.3.h,
                backgroundColor: Colors.grey.shade300,
                child: CircleAvatar(
                  radius: 2.h,
                  child: Text(
                    tick.toString(),
                    style: AppTextStyle.getMediumStyle(
                      color: Colors.grey.shade400,
                      fontSize: 14.sp,
                    ),
                  ),
                  backgroundColor: Colors.white,
                ),
              ));
  }

  Widget tick1() {
    bool isTicks = ticks == 1;
    return ticks > 0 ? tick(true, 1, isTick: isTicks) : tick(false, 1);
  }

  Widget tick2() {
    bool isTicks = ticks == 2;
    return ticks > 1 ? tick(true, 2, isTick: isTicks) : tick(false, 2);
  }

  Widget tick3() {
    bool isTicks = ticks == 3;
    return ticks > 2 ? tick(true, 3, isTick: isTicks) : tick(false, 3);
  }

  Widget line1() {
    return ticks > 1 ? line(true) : line(false);
  }

  Widget line2() {
    return ticks > 2 ? line(true) : line(false);
  }

  Widget line3() {
    return ticks > 3 ? line(true) : line(false);
  }

  Widget _processText1(context) {
    return ticks > 0
        ? _processText(context, App.tr.receive, true)
        : _processText(context, App.tr.receive, false);
  }

  Widget _processText2(context) {
    return ticks > 1
        ? _processText(context, App.tr.address, true)
        : _processText(context, App.tr.address, false);
  }

  Widget _processText3(context) {
    return ticks > 2 ? _processText(context, 'الدفع', true) : _processText(context, 'الدفع', false);
  }

  Widget spacer() {
    return const Spacer(
      flex: 1,
    );
  }

  Widget line(bool isChecked) {
    return Expanded(
      child: Container(
        color: isChecked ? AppColors.primaryColor : Colors.grey.shade300,
        height: .4.h,
        // width: 17.w,
      ),
    );
  }
}

_processText(context, String text, bool isChecked) {
  return Text(
    text,
    style: TextStyle(
      color: isChecked ? AppColors.primaryColor : AppColors.subTitle,
      fontSize: 9.sp,
      fontWeight: FontWeight.w500,
    ),
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    softWrap: true,
  );
}
