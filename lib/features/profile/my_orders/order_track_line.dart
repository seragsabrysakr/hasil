import 'package:flutter/material.dart';
import 'package:hassel/shared/app_utils/app_assets.dart';
import 'package:hassel/shared/app_utils/app_colors.dart';
import 'package:sizer/sizer.dart';

class TrackProgress extends StatelessWidget {
  final int ticks;

  const TrackProgress({
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
            child: Column(
              children: <Widget>[
                tick1(),
                line1(),
                tick2(),
                line2(),
                tick3(),
                line3(),
                tick4(),
                line4(),
                tick5(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget tick(
    bool isChecked,
    int tick, {
    bool isTick = false,
    required String image1,
    required String image2,
  }) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: .5.h),
        child: CircleAvatar(
          radius: 3.h,
          backgroundColor: AppColors.backGround,
          child: Image.asset(
            isTick ? image1 : image2,
            scale: 1.7,
          ),
        ));
  }

  Widget tick1() {
    bool isTicks = ticks >= 0;
    return isTicks
        ? tick(true, 0,
            isTick: isTicks,
            image1: AppAssets.orderOn,
            image2: AppAssets.orderOff)
        : tick(false, 0, image1: AppAssets.orderOn, image2: AppAssets.orderOff);
  }

  Widget tick2() {
    bool isTicks = ticks >= 1;
    return isTicks
        ? tick(true, 1,
            isTick: isTicks,
            image1: AppAssets.orderOn,
            image2: AppAssets.orderOff)
        : tick(false, 1, image1: AppAssets.orderOn, image2: AppAssets.orderOff);
  }

  Widget tick3() {
    bool isTicks = ticks >= 2;
    return isTicks
        ? tick(true, 2,
            isTick: isTicks,
            image1: AppAssets.orderOn,
            image2: AppAssets.orderOff)
        : tick(false, 2, image1: AppAssets.orderOn, image2: AppAssets.orderOff);
  }

  Widget tick4() {
    bool isTicks = ticks >= 3;
    return isTicks
        ? tick(true, 3,
            isTick: isTicks,
            image1: AppAssets.orderOn,
            image2: AppAssets.orderOff)
        : tick(false, 3, image1: AppAssets.orderOn, image2: AppAssets.orderOff);
  }

  Widget tick5() {
    bool isTicks = ticks >= 4;
    return isTicks
        ? tick(true, 4,
            isTick: isTicks,
            image1: AppAssets.orderOn,
            image2: AppAssets.orderOff)
        : tick(false, 4, image1: AppAssets.orderOn, image2: AppAssets.orderOff);
  }

  Widget line1() {
    return ticks > 2 ? line(true) : line(false);
  }

  Widget line2() {
    return ticks > 3 ? line(true) : line(false);
  }

  Widget line3() {
    return ticks > 4 ? line(true) : line(false);
  }

  Widget line4() {
    return ticks > 5 ? line(true) : line(false);
  }

  Widget line5() {
    return ticks > 5 ? line(true) : line(false);
  }

  Widget spacer() {
    return const Spacer(
      flex: 1,
    );
  }

  Widget line(bool isChecked) {
    return SizedBox(
      child: Container(
        color: isChecked ? AppColors.primaryColor : Colors.grey.shade300,
        width: .2.h,
        height: 3.8.h,
        // width: 17.w,
      ),
    );
  }
}
