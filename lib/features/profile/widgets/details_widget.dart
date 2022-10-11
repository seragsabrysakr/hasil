import 'package:flutter/material.dart';
import 'package:hassel/shared/app_utils/app_colors.dart';
import 'package:hassel/shared/app_utils/app_sized_box.dart';
import 'package:hassel/shared/app_utils/app_text_style.dart';
import 'package:sizer/sizer.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';

class DetailsWidget extends StatefulWidget {
  final String imageLeading;
  final Widget content;
  final Widget detailsWidget;
  bool details;
  bool logo;
  bool delivered;
  VoidCallback? onTap;
  DetailsWidget({
    Key? key,
    required this.imageLeading,
    required this.content,
    this.details = false,
    this.logo = true,
    this.delivered = false,
    required this.detailsWidget,
    this.onTap,
  }) : super(key: key);

  @override
  State<DetailsWidget> createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<DetailsWidget> {
  bool details = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 4.w,
          ),
          child: TouchRippleEffect(
            onTap: widget.onTap ?? () {},
            rippleColor: Colors.grey.shade400,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(2.h),
              child: Column(
                children: [
                  AppSizedBox.s2,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TouchRippleEffect(
                        onTap: () {},
                        rippleDuration: const Duration(milliseconds: 700),
                        rippleColor: AppColors.primaryColor.withOpacity(.5),
                        child: CircleAvatar(
                          radius: 3.h,
                          backgroundColor: AppColors.backGround,
                          child: Image.asset(
                            widget.imageLeading,
                            scale: 1.5,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      widget.content,
                      SizedBox(
                        width: 5.w,
                      ),
                      TouchRippleEffect(
                          onTap: () {
                            setState(() {
                              details = !details;
                            });
                          },
                          rippleDuration: const Duration(milliseconds: 200),
                          rippleColor: AppColors.primaryColor.withOpacity(.5),
                          child: CircleAvatar(
                            radius: 2.8.w,
                            backgroundColor:
                                !widget.delivered ? AppColors.primaryColor : Colors.grey.shade300,
                            child: Center(
                              child: Icon(
                                !details ? Icons.arrow_drop_up : Icons.arrow_drop_down_outlined,
                                color:
                                    // details ?
                                    Colors.white,
                                //  : AppColors.navColorsUnActive,
                                size: 16.sp,
                              ),
                            ),
                          )),
                    ],
                  ),
                  if (!details) widget.detailsWidget
                ],
              ),
            ),
          ),
        ),
        if (widget.logo) PositionedDirectional(start: 4.w, top: 0, child: buildDefault())
      ],
    );
  }

  Container buildDefault() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(.3.h),
        color: AppColors.greenColorTrans,
      ),
      height: 2.2.h,
      width: 6.h,
      child: Center(
        child: Text(
          'افتراضي',
          style: AppTextStyle.getRegularStyle(color: AppColors.primaryColor, fontSize: 7.sp),
        ),
      ),
    );
  }
}
