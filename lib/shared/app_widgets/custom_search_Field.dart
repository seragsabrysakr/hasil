import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomSearch extends StatefulWidget {
  final TextEditingController controller;
  final Color? color;
  final Function(String)? onSearchTextChanged;
  final Function(String)? onSubmit;
  VoidCallback? onTap;
  FocusNode? focus;
  double? width;
  double? higth;
  String? hint;
  VoidCallback? search;
  bool enabled;
  bool isSearch;

  CustomSearch(
      {Key? key,
      required this.controller,
      this.onTap,
      this.search,
      this.focus,
      this.hint,
      this.width = 88,
      this.higth = 10,
      this.enabled = true,
      this.isSearch = false,
      required this.onSearchTextChanged,
      this.color = Colors.white,
      this.onSubmit})
      : super(key: key);

  @override
  State<CustomSearch> createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.higth?.h,
      width: widget.width?.w,
      child: TextField(
        textAlignVertical: TextAlignVertical.top,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        textAlign: TextAlign.start,
        cursorColor: Colors.black,
        focusNode: widget.focus,
        controller: widget.controller,
        onChanged: widget.onSearchTextChanged,
        onSubmitted: widget.onSubmit,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          enabled: widget.enabled,
          isDense: true,
          contentPadding:
              EdgeInsets.symmetric(vertical: 2.5.h, horizontal: 2.w),
          hintText: ' App.tr.search',
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 11.sp,
          ),
          hintTextDirection: TextDirection.ltr,
          filled: true,
          fillColor: widget.color,
          suffixIconConstraints: BoxConstraints(minHeight: 4.h, minWidth: 4.h),
          // suffixIcon: Material(
          //   color: Colors.transparent,
          //   borderRadius: BorderRadius.circular(10.h),
          //   child: InkWell(
          //     borderRadius: BorderRadius.circular(10.h),
          //     onTap: widget.onTap,
          //     child: Container(
          //       padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
          //       child: SvgPicture.asset(
          //         Resources.customize,
          //       ),
          //     ),
          //   ),
          // ),
          prefixIcon: IconButton(
            onPressed: widget.search,
            icon: Icon(
              Icons.search,
              size: 20.sp,
              color: Colors.grey,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(5.h),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(5.h),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(5.h),
          ),
        ),
      ),
    );
  }
}
