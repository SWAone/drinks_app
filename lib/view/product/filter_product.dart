import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:prostore/controller/swa_stor/home_c/home_controller.dart';
import 'package:prostore/model/item_model.dart';
import 'package:prostore/view/product/product_full.dart';
import 'package:prostore/widget/all_product_scrren/all_product_box.dart';
import 'package:prostore/widget/app_head_icon.dart';
import 'package:prostore/widget/home_widget/app_head.dart';
import 'package:prostore/widget/home_widget/app_product.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FilterdProdect extends StatelessWidget {
  List<ItemModel> items = [];
  FilterdProdect({
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (homeController) {
            return Column(
              children: [
                AppHead(
                  isTowIcon: true,
                  prefxItem: AppHeadIcon(),
                  title: 'النتائج',
                ),
                Expanded(
                  child: homeController.filterLoding
                      ? Center(child: Text('جار عرض البيانات...'))
                      : items.isNotEmpty
                          ? GridView.builder(
                              controller:
                                  homeController.filterPriceScrollController,
                              padding: EdgeInsets.only(
                                  left: 25.w,
                                  right: 25.w,
                                  top: 35.h,
                                  bottom: 20.h),
                              shrinkWrap: true,
                              itemCount: items.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 30.h,
                                      crossAxisSpacing: 29.w,
                                      mainAxisExtent: 235.h),
                              itemBuilder: (context, index) {
                                return AppProduct(prodct: items[index]);
                              },
                            )
                          : Center(child: Text('لم يتم العثور على نتائج')),
                ),
                homeController.loding
                    ? Center(
                        child: LottieBuilder.asset(
                          'assets/anmtions/home_anmtion/mainLoding.json',
                          height: 30.h,
                          width: 20.w,
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            );
          }),
    ));
  }
}
