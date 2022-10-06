import 'package:flutter/material.dart';
import 'package:hassel/shared/app_utils/app_colors.dart';
import 'package:sizer/sizer.dart';



class SliderDots extends StatelessWidget {
  final int numberOfDots;
  final int photoIndex;

  // ignore: use_key_in_widget_constructors
  const SliderDots({required this.numberOfDots, required this.photoIndex});

  Widget _inactivePhoto() {
    return Padding(
      padding: EdgeInsets.only(left: .5.w, right: .5.w),
      child: Container(
        height: 1.2.h,
        width: 1.2.h,
        decoration: BoxDecoration(
            color: Colors.grey.shade300, borderRadius: BorderRadius.circular(1.h)),
      ),
    );
  }

  Widget _activePhoto() {
    return Padding(
      padding: EdgeInsets.only(left: 1.w, right: 1.w),
      child: Container(
        height: 1.2.h,
        width: 1.2.h,
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(1.h),
           ),
      ),
    );
  }

  List<Widget> _buildDots() {
    List<Widget> dots = [];

    for (int i = 0; i < numberOfDots; ++i) {
      dots.add(i == photoIndex ? _activePhoto() : _inactivePhoto());
    }

    return dots;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildDots(),
      ),
    );
  }
}
