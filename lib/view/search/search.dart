import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prostore/main.dart';
import 'package:prostore/model/item_model.dart';
import 'package:prostore/nav_bar.dart';
import 'package:prostore/view/order/my_orders.dart';
import 'package:prostore/widget/app_boton.dart';
import 'package:prostore/widget/app_head_icon.dart';
import 'package:prostore/widget/app_search.dart';
import 'package:prostore/widget/home_widget/app_head.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:prostore/widget/home_widget/app_product.dart';

class SearchSc extends StatelessWidget {
  const SearchSc({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppHead(
              title: 'البحث عن المواد',
              prefxItem: AppHeadIcon(),
              isTowIcon: true,
            ),
            Column(
              children: [
                Row(
                  children: [
                    AppSearch(),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.sp)),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 27.w, right: 27.w),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 10.h),
                    itemCount: 6,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 260.h,
                        mainAxisSpacing: 0.h,
                        crossAxisSpacing: 30.w),
                    itemBuilder: (context, index) {
                      return AppProduct(
                        prodct: new ItemModel.formJson({}),
                      );
                    },
                  ),
                ),
              ],
            )
            // Text(
            //   'تم ارسال طلبك بنجاح',
            //   style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
            // ),
            // AppBoton(
            //   titel: 'تتبع حالة الطلب',
            //   onTap: () {
            //     Get.back();
            //     Get.back();
            //     Get.back();

            //     navBarController.chingPageIndex(2);
            //   },
            // ),
          ],
        ),
      ),
    ));
  }
}
