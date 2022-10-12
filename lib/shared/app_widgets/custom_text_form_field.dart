import 'package:flutter/material.dart';
import 'package:hassel/shared/app_utils/app_colors.dart';
import 'package:sizer/sizer.dart';

class CustomTextField extends StatelessWidget {
  final bool obscure;
  final bool align;
  final bool enable;
  final String? initialValue;
  final int? max;
  final int? min;
  final double? width;
  final double? hi;
  final Color color;
  final String? Function(String?)? validator;
  final String? hint;
  final TextEditingController? controller;
  final IconData? suffix;
  final Widget? prefix;
  final TextInputType? type;
  final VoidCallback? visiblpass;
  final VoidCallback? onedit;
  final double radius;
  final TextAlign textAlign;
  final VoidCallback? ontap;
  final FocusNode? focusNode;
  final TextInputAction? action;
  const CustomTextField(
      {this.controller,
      this.align = true,
      this.enable = true,
      this.action,
      this.initialValue,
      this.focusNode,
      required this.hint,
      this.max = 1,
      this.min,
      this.obscure = false,
      this.onedit,
      this.suffix,
      this.type,
      required this.validator,
      this.visiblpass,
      Key? key,
      this.prefix,
      this.ontap,
      this.radius = 18,
      this.width,
      this.hi = 6.5,
      this.textAlign = TextAlign.center,
      this.color = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(radius.h)),
          width: width ?? size.width * .8,
          child: TextFormField(
            textAlign: textAlign,
            // textAlignVertical: TextAlignVertical.bottom,
            // onTap: ontap,
            // enabled: enable,
            // autofocus: true,
            // obscuringCharacter: '*',
            onEditingComplete: onedit,
            textInputAction: action,
            maxLines: max,
            minLines: min,
            initialValue: initialValue,
            controller: controller,
            style: TextStyle(
                fontSize: 15.0.sp, fontWeight: FontWeight.w400, color: AppColors.headerColor),
            cursorColor: AppColors.primaryColor,
            keyboardType: type,
            obscureText: obscure,
            validator: validator,

            decoration: buildInputDecoration(color: color),
          ),
        ),
        if (!enable)
          SizedBox(
            height: 2.h,
          )
      ],
    );
  }

  InputDecoration buildInputDecoration({Color color = Colors.white}) {
    return InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 1.0.h),

        // errorText: '',
        fillColor: color,
        filled: true,
        alignLabelWithHint: true,
        suffixIconConstraints: const BoxConstraints(
          minWidth: 10,
          minHeight: 10,
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 25,
          minHeight: 25,
        ),
        suffixIcon: suffix != null
            ? InkResponse(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(start: 3.w, end: 4.w),
                  child: Icon(
                    suffix,
                    color: Colors.grey,
                  ),
                ),
                onTap: ontap,
              )
            : SizedBox(
                width: 5.w,
              ),
        prefixIcon: GestureDetector(
          child: Padding(
            padding: EdgeInsetsDirectional.only(start: 4.w, end: 3.w),
            child: prefix,
          ),
          onTap: visiblpass,
        ),
        hintText: hint!,
        hintStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.subTitle,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(.5.h),
            borderSide: BorderSide(color: Colors.grey.shade300)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(.5.h),
            borderSide: const BorderSide(color: Colors.white)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(.5.h),
            borderSide: BorderSide(color: AppColors.primaryColor, width: 2)),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(.5.h),
          borderSide: const BorderSide(color: Colors.red),
        ));
  }
}
