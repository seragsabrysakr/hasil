import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hassel/features/home/presentation/widgets/product_item.dart';
import 'package:hassel/shared/app_utils/app_colors.dart';
import 'package:hassel/shared/app_utils/app_text_style.dart';
import 'package:hassel/shared/app_widgets/widgets_helper.dart';
import 'package:sizer/sizer.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Product> productItems = List.of(favorits);
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

  Widget buildFavoriteItem(BuildContext cxt, Product item, int index) {
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
              Image.asset(
                item.image,
                scale: 2.5,
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

List<Product> favorits = [
  Product(
      name: 'خوخ سكري',
      count: 0,
      image: 'assets/images/static/k.png',
      color: AppColors.orangColorTrans,
      price: '٣٠ ريال',
      type: '150 kg',
      isFavorite: false,
      description:
          'يتميز الخوخ أو البرقوق أنه غني بالعديد من العناصر الغذائية المهمة لدعم وظائف الجسم، وتنظيم مستويات السكر في الجسم. إنّ موسم الذروة للخوخ هو من يولي إلى أغسطس، لكن يتواجد في المحلات التجارية ما بين مايو إلى أكتوبر.ي بالعديد من العناصر الغذائية المهمة لدعم وظائف الجسم، وتنظيم مستويات السكر في الجسم. إنّ موسم الذروة للخوخ هو من يولي إلى أغسطس، لكن يتواجد في المحلات التجارية ما بين مايو إلى أكتوبر.'),
  Product(
      name: "رومان مصري",
      image: 'assets/images/static/r.png',
      color: AppColors.redColorTrans,
      price: '٥٠ ريال',
      count: 2,
      type: 'صندوق',
      description:
          'الرمان المصرى يغزو أوروبا وروسيا ويتفوق على «الإسبانى» و«الإسرائيلى» بدأ موسم تصدير محصول الرمان عالمياً مبكراً، وانتهى مبكراً أيضاً، وتعد مصر وإسبانيا وإسرائيل من أبرز الدول المصدرة، لكن يحظى المحصول المصرى بأهمية بالغة على مستوى التعاقدات الدولية؛ بسبب ارتفاع جودته، وتنظيم العملية التصديرية.',
      isFavorite: true),
  Product(
      description:
          'الرمان المصرى يغزو أوروبا وروسيا ويتفوق على «الإسبانى» و«الإسرائيلى» بدأ موسم تصدير محصول الرمان عالمياً مبكراً، وانتهى مبكراً أيضاً، وتعد مصر وإسبانيا وإسرائيل من أبرز الدول المصدرة، لكن يحظى المحصول المصرى بأهمية بالغة على مستوى التعاقدات الدولية؛ بسبب ارتفاع جودته، وتنظيم العملية التصديرية.',
      name: "فراولة",
      image: 'assets/images/static/s.png',
      color: AppColors.redColorTrans,
      price: '٢٠٠ ريال',
      type: '150 kg',
      count: 3,
      isFavorite: false),
  Product(
      description:
          'الرمان المصرى يغزو أوروبا وروسيا ويتفوق على «الإسبانى» و«الإسرائيلى» بدأ موسم تصدير محصول الرمان عالمياً مبكراً، وانتهى مبكراً أيضاً، وتعد مصر وإسبانيا وإسرائيل من أبرز الدول المصدرة، لكن يحظى المحصول المصرى بأهمية بالغة على مستوى التعاقدات الدولية؛ بسبب ارتفاع جودته، وتنظيم العملية التصديرية.',
      name: "ليمون أخضر",
      image: 'assets/images/static/l.png',
      color: AppColors.greenColorTrans,
      price: '١٠٠ ريال',
      type: '150 kg',
      count: 0,
      isFavorite: true),
  Product(
      description:
          'الرمان المصرى يغزو أوروبا وروسيا ويتفوق على «الإسبانى» و«الإسرائيلى» بدأ موسم تصدير محصول الرمان عالمياً مبكراً، وانتهى مبكراً أيضاً، وتعد مصر وإسبانيا وإسرائيل من أبرز الدول المصدرة، لكن يحظى المحصول المصرى بأهمية بالغة على مستوى التعاقدات الدولية؛ بسبب ارتفاع جودته، وتنظيم العملية التصديرية.',
      name: "رومان مصري",
      image: 'assets/images/static/r.png',
      color: AppColors.redColorTrans,
      price: '٥٠ ريال',
      type: 'صندوق',
      count: 0,
      isFavorite: true),
  Product(
      description:
          'الرمان المصرى يغزو أوروبا وروسيا ويتفوق على «الإسبانى» و«الإسرائيلى» بدأ موسم تصدير محصول الرمان عالمياً مبكراً، وانتهى مبكراً أيضاً، وتعد مصر وإسبانيا وإسرائيل من أبرز الدول المصدرة، لكن يحظى المحصول المصرى بأهمية بالغة على مستوى التعاقدات الدولية؛ بسبب ارتفاع جودته، وتنظيم العملية التصديرية.',
      name: "فراولة",
      image: 'assets/images/static/s.png',
      color: AppColors.redColorTrans,
      price: '٢٠٠ ريال',
      type: '150 kg',
      count: 0,
      isFavorite: false)
];
