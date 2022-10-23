import 'package:flutter/material.dart';
import 'package:hassel/shared/app_widgets/widgets_helper.dart';
import 'package:sizer/sizer.dart';

class ProductScreen extends StatefulWidget {
  final String title;
  const ProductScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetsHelper.customAppBar(context, title: widget.title),
      body: Padding(
        padding: EdgeInsets.only(left: 5.w, right: 5.w),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPadding(padding: EdgeInsets.symmetric(vertical: 1.h)),
            // buildProductLit(),
            SliverPadding(padding: EdgeInsets.symmetric(vertical: 3.h)),
          ],
        ),
      ),
    );
  }

  // SliverGrid buildProductLit() {
  //   return SliverGrid(
  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: 2,
  //       childAspectRatio: .63,
  //       crossAxisSpacing: 4.w,
  //       mainAxisSpacing: 3.w,
  //     ),
  //     delegate: SliverChildBuilderDelegate(
  //       (BuildContext context, int index) {
  //         return StatefulBuilder(builder: (context, snapshot) {
  //           return ProductItem(product: products[index]);
  //         });
  //       },
  //       childCount: products.length,
  //     ),
  //   );
  // }
}
