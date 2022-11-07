import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassel/core/app_business_logic/state_renderer/state_renderer_impl.dart';
import 'package:hassel/core/dependency_injection/dependency_injection.dart';
import 'package:hassel/data/model/category_model.dart';
import 'package:hassel/data/model/productModel.dart';
import 'package:hassel/features/home/presentation/cubits/category_product_cubit.dart';
import 'package:hassel/features/home/presentation/widgets/product_item.dart';
import 'package:hassel/shared/app_widgets/widgets_helper.dart';
import 'package:sizer/sizer.dart';

class ProductScreen extends StatefulWidget {
  final CategoryModel item;

  const ProductScreen({Key? key, required this.item}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetsHelper.customAppBar(context, title: widget.item.name),
      body: BlocProvider(
        create: (context) => getIt<CategoryProductsCubit>()
          ..getCategoryProducts(widget.item.id.toString()),
        child: BlocConsumer<CategoryProductsCubit, FlowState>(
          listener: (context, state) {
            state.flowStateListener(context);
          },
          builder: (context, state) {
            var cubit = CategoryProductsCubit.get(context);
            List<ProductModel> productsList = cubit.products;

            return state.flowStateBuilder(context,
                screenContent: buildScreenContent(productsList), retry: () {
              cubit.getCategoryProducts(widget.item.id.toString());
            });
          },
        ),
      ),
    );
  }

  Padding buildScreenContent(List<ProductModel> productsList) {
    return Padding(
      padding: EdgeInsets.only(left: 5.w, right: 5.w),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(padding: EdgeInsets.symmetric(vertical: 1.h)),
          buildProductLit(productsList),
          SliverPadding(padding: EdgeInsets.symmetric(vertical: 3.h)),
        ],
      ),
    );
  }

  SliverGrid buildProductLit(List<ProductModel> productsList) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: .63,
        crossAxisSpacing: 4.w,
        mainAxisSpacing: 3.w,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return StatefulBuilder(builder: (context, snapshot) {
            return ProductItem(
              product: productsList[index],
              cat: false,
            );
          });
        },
        childCount: productsList.length,
      ),
    );
  }
}
