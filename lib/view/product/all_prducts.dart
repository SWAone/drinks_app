import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:prostore/controller/swa_stor/home_c/home_controller.dart';
import 'package:prostore/model/category_model.dart';
import 'package:prostore/model/item_model.dart';
import 'package:prostore/view/product/product_full.dart';
import 'package:prostore/widget/all_product_scrren/all_product_box.dart';
import 'package:prostore/widget/app_head_icon.dart';
import 'package:prostore/widget/home_widget/app_head.dart';
import 'package:prostore/widget/home_widget/app_product.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AllProductsPage extends StatelessWidget {
  String title;
  List items;

  AllProductsPage({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        systemNavigationBarDividerColor: Colors.white));
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (homeController) {
            return Column(
              children: [
                AppHead(
                  showAppIcon: false,
                  isTowIcon: true,
                  prefxItem: AppHeadIcon(),
                  title: 'المواد التي تم العثور عليها',
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                ),
                Expanded(
                  child: Center(
                      child: homeController.loding
                          ? SizedBox(
                              width: 30.w,
                              height: 25.h,
                              child: Center(
                                child: LottieBuilder.asset(
                                    'assets/anmtions/home_anmtion/mainLoding.json'),
                              ),
                            )
                          : items.isNotEmpty
                              ? SizedBox(
                                  child: GridView.builder(
                                    controller:
                                        homeController.filterScrollController,
                                    padding: EdgeInsets.only(
                                        left: 25.w,
                                        right: 25.w,
                                        top: 35.h,
                                        bottom: 20.h),
                                    itemCount: items.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 10.h,
                                            crossAxisSpacing: 15.w,
                                            mainAxisExtent: 240.h),
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Get.to(() =>
                                              ProductFull(item: items[index]));
                                        },
                                        child: AppProduct(
                                          prodct: items[index],
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : Text('لا يوجد نتائج')),
                ),
                ItemModel.skipLoding || CategoryMdel.skipLoding
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
