import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hassel/data/model/productModel.dart';
import 'package:hassel/shared/app_utils/app_colors.dart';
import 'package:hassel/shared/app_utils/app_text_style.dart';
import 'package:hassel/shared/app_widgets/custom_network_image.dart';
import 'package:hassel/shared/app_widgets/widgets_helper.dart';
import 'package:sizer/sizer.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({
    Key? key,
  }) : super(key: key);
  static List<ProductModel> favorite = [];

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<ProductModel> productItems = List.from(FavoriteScreen.favorite);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetsHelper.customAppBar(context, title: 'المفضلة', onTap: () {
        Navigator.canPop(context);
      }),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  itemCount: productItems.length,
                  itemBuilder: (context, index) {
                    return buildFavoriteItem(
                        context, productItems[index], index);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFavoriteItem(BuildContext cxt, ProductModel item, int index) {
    return Slidable(
      key: Key(UniqueKey().toString()),
      endActionPane: ActionPane(
        extentRatio: .2,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            autoClose: false,
            onPressed: (context) {
              setState(() {
                productItems.removeAt(index);
                FavoriteScreen.favorite.remove(item);
              });
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: 2.h),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(.5.h),
            color: Colors.white,
          ),
          height: 12.h,
          child: Row(
            children: [
              SizedBox(
                width: 5.w,
              ),
              buildImage(
                height: 10.h,
                width: 28.w,
                imageUrl: item.images.first.src,
              ),
              SizedBox(
                width: 5.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '\$1.22 x 5',
                    style: AppTextStyle.getBoldStyle(
                        color: AppColors.primaryColor, fontSize: 11.sp),
                  ),
                  Text(
                    item.name,
                    style: AppTextStyle.getBoldStyle(
                        color: AppColors.titleColor, fontSize: 12.sp),
                  ),
                  Text(
                    '1.50 ibs',
                    style: AppTextStyle.getMediumStyle(
                        color: AppColors.subTitle, fontSize: 12.sp),
                  ),
                ],
              ),
              const Spacer(
                flex: 1,
              ),
              CircleAvatar(
                radius: 3.h,
                backgroundColor: AppColors.backGround,
                child: Icon(
                  Icons.shopping_bag,
                  size: 19.sp,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
