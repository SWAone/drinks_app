import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:prostore/api/api.dart';
import 'package:prostore/main.dart';
import 'package:prostore/model/category_model.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:prostore/controller/swa_stor/home_c/home_controller.dart';
import 'package:prostore/model/item_model.dart';
import 'package:prostore/view/product/all_prducts.dart';
import 'package:prostore/view/product/product_full.dart';
import 'package:prostore/widget/all_product_scrren/all_product_box.dart';
import 'package:prostore/widget/app_head_icon.dart';
import 'package:prostore/widget/home_widget/app_head.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prostore/widget/loding/ofres_lodeng.dart';

class AllCategoryPage extends StatelessWidget {
  List<CategoryMdel> items = [];
  AllCategoryPage({super.key, required this.items});

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
                  showAppIcon: false,
                  isTowIcon: true,
                  prefxItem: AppHeadIcon(),
                  title: 'الاقسام التي تم العثور عليها',
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                ),
                Expanded(
                  child: Center(
                      child: items.isNotEmpty
                          ? SizedBox(
                              child: ListView.builder(
                                // controller:
                                //     homeController.allcategoryController,
                                padding: EdgeInsets.only(bottom: 10.h),
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  return homeController.categores.isNotEmpty
                                      ? Padding(
                                          padding: EdgeInsets.only(
                                              left: 20.w, right: 20.w),
                                          child: _offers(
                                              onTap: () {
                                                homeController
                                                    .getElemntByCategory(
                                                        isFirstTime: true,
                                                        categoryId:
                                                            homeController
                                                                .categores[
                                                                    index]
                                                                .id
                                                                .toString());
                                                Get.to(AllProductsPage(
                                                    title: homeController
                                                        .categores[index]
                                                        .title![lanIndx],
                                                    items: homeController
                                                        .itemByCategory));
                                              },
                                              title: homeController
                                                  .categores[index]
                                                  .title![lanIndx],
                                              body: homeController
                                                  .categores[index]
                                                  .body![lanIndx],
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                    blurRadius: 7,
                                                    spreadRadius: 7)
                                              ],
                                              imageUrl: homeController
                                                  .categores[index].img![0],
                                              category: true,
                                              reduse: 10))
                                      : OfresLodeng(
                                          category: true,
                                        );
                                },
                              ),
                            )
                          : Text('جار التحميل')),
                ),
                CategoryMdel.skipLoding
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

  Widget _offers(
      {String imageUrl = 'assets/home_icon/image 64.png',
      String title = 'هذ العرض بالباكيت',
      List<BoxShadow>? boxShadow,
      double reduse = 0,
      void Function()? onTap,
      String body = 'اربع قطع من جهاز تقشير الوجه با40 الف بسسس!',
      bool category = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: 20.h),
        height: 158.h,
        width: 424.w,
        //
        decoration: BoxDecoration(
            color: HexColor('#F8F8FA'),
            boxShadow: boxShadow,
            borderRadius: BorderRadius.circular(reduse.sp)),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  'assets/home_icon/Ellipse 251.png',
                  width: 102.w,
                  height: 102.h,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: CachedNetworkImage(
                  fadeOutDuration: Duration(milliseconds: 0),
                  width: 110.w,
                  height: 158.h,
                  imageUrl: "${Api.imgsPath}${imageUrl}",
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: category ? 10 : 60.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200.w,
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: 20.sp, color: Colors.grey.withOpacity(1)),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 23.h,
                  ),
                  Container(
                    width: 195.w,
                    child: Text(
                      body,
                      style: TextStyle(fontSize: 17.sp, color: Colors.black),
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
