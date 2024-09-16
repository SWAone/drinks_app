import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prostore/api/api.dart';
import 'package:prostore/const/app_color.dart';
import 'package:prostore/controller/swa_stor/home_c/home_controller.dart';
import 'package:prostore/main.dart';
import 'package:prostore/model/ads_model.dart';
import 'package:prostore/model/category_model.dart';
import 'package:prostore/model/item_model.dart';
import 'package:prostore/view/product/all_prducts.dart';
import 'package:prostore/view/product/filter_product.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:prostore/widget/home_widget/app_product.dart';
import 'package:get/get.dart';
import 'package:prostore/widget/loding/product_loding.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shimmer/shimmer.dart';

class HomePageSc extends StatelessWidget {
  HomeController homeController = Get.put(HomeController());
  HomePageSc({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color(0xFFC0D3E4),
        systemNavigationBarDividerColor: AppColor.primaryColor));
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          ItemModel.skip = 0;
          ItemModel.skip2 = 0;
          CategoryMdel.skip = 0;
          AdsModel.skip = 0;
          homeController.adss.clear();
          homeController.getTheam();
          homeController.products.clear();
          homeController.sortedProdect.clear();
          homeController.categores.clear();

          AdsModel.gnerateList(
              await Api.fetchData(path: '/ads?skip=0'), homeController.adss);
          ItemModel.gnerateList(await Api.fetchData(path: '/product?skip=0'),
              homeController.products);

          CategoryMdel.gnerateList(
              await Api.fetchData(path: '/category?skip=0'),
              homeController.categores);

          homeController.update();
        },
        child: WillPopScope(
          onWillPop: () {
            return exit(0);
          },
          child: GetBuilder<HomeController>(
              init: HomeController(),
              builder: (controler) {
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFC0D3E4),
                            Color(0xFFD3C6E0),
                            Color(0xFFD3C6E0),
                            Color(0xFFC0D3E4),
                          ],
                          stops: [0.0, 0.2, 0.5, 1.0],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 30.h, bottom: 14.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 10.h),
                              child: Center(
                                child: Image.asset(
                                    'assets/home_icon/app_title.png',
                                    width: 162.w),
                              ),
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 16.w),
                              child: Text(
                                userInfo.name != 'null'
                                    ? 'اهلا بك ${userInfo.name}'
                                    : 'اهلا بك',
                                style: TextStyle(
                                    color: HexColor('#354369'),
                                    fontSize: 18.sp),
                              ),
                            ),
                            SizedBox(
                              height: 9.h,
                            ),
                            Center(
                                child: thaem == 0
                                    ? serch(thaem)
                                    : serchThem(thaem))
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: controler.productsScrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            controler.categores.isNotEmpty
                                ? Container(
                                    // color: Colors.red,
                                    height: 100.h,
                                    child: ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      padding: EdgeInsets.only(
                                          left: 10.w, top: 13.h),
                                      itemCount: controler.categores.length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            controler.catogoryId = controler
                                                .categores[index].id
                                                .toString();
                                            controler
                                                    .isCatgoryDisplyOnAllPrductPage =
                                                true;
                                            print('object');

                                            controler.getElemntByCategory(
                                                isFirstTime: true,
                                                categoryId: controler
                                                    .categores[index].id
                                                    .toString());
                                            Get.to(AllProductsPage(
                                                title: controler
                                                    .categores[index]
                                                    .title![lanIndx],
                                                items:
                                                    controler.itemByCategory));
                                          },
                                          child: Padding(
                                              padding:
                                                  EdgeInsets.only(right: 10.w),
                                              child: catoCircl(
                                                  '${Api.imgsPath}${controler.categores[index].img!}',
                                                  controler.categores[index]
                                                      .title!)),
                                        );
                                      },
                                    ),
                                  )
                                : SizedBox(
                                    height: 100.h,
                                    child: ListView.separated(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      separatorBuilder: (context, index) {
                                        return SizedBox(
                                          width: 10.w,
                                        );
                                      },
                                      itemCount: 10,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return Shimmer.fromColors(
                                          child: Center(
                                              child: CircleAvatar(
                                            radius: 30.r,
                                          )),
                                          baseColor: Colors.grey[300]!,
                                          highlightColor: Colors.grey[100]!,
                                        );
                                      },
                                    ),
                                  ),
                            SizedBox(
                              height: 13.h,
                            ),
                            homeController.adss.isNotEmpty
                                ? _customSliderImage()
                                : Shimmer.fromColors(
                                    child: Center(
                                      child: Container(
                                        width: 320.w,
                                        height: 180.h,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 8.w),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8.r)),
                                      ),
                                    ),
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                  ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 17.h, bottom: 22.h, right: 10.w),
                              child: Text(
                                'جميع المشروبات',
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    color: AppColor.primaryColor),
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              mainAxisExtent: 280.h),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.w),
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: controler.products.isNotEmpty
                                          ? controler.products.length
                                          : 3,
                                      itemBuilder: (context, index) {
                                        return controler.products.isNotEmpty
                                            ? AppProduct(
                                                prodct:
                                                    controler.products[index])
                                            : ProductsLoding();
                                      },
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }),
        ),
      ),
    ));
  }

  Widget serchThem(them) {
    return them == 2
        ? serch(2)
        : Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Container(
                  margin: EdgeInsets.only(left: 0.w),
                  child: SizedBox(
                    height: 40.h,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: EdgeInsets.only(right: 10.w),
                        width: 270.45.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                            color: HexColor('#FAFAFA'),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 4),
                            ],
                            borderRadius: BorderRadius.circular(15.sp)),
                        child: TextFormField(
                            onFieldSubmitted: (value) {
                              homeController.skipSerch = 0;
                              homeController.serachEle(
                                  text: value, lableResult: 'items');
                              homeController.isSerch = true;
                              homeController.serchText = value;
                              Get.to(FilterdProdect(
                                  items: homeController.serachElemnt));
                            },
                            decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding:
                                      EdgeInsets.only(top: 10.h, bottom: 10.h),
                                  child: Image.asset(
                                    'assets/seach_icon/Union (1).png',
                                    width: 10.w,
                                    height: 10.h,
                                  ),
                                ),
                                hintStyle: TextStyle(color: Colors.grey),
                                contentPadding: EdgeInsets.all(0),
                                hintText: 'ابحث عن مشروبك المفضل',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none))),
                      ),
                    ),
                  ),
                ),
              ),
              them == 1
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: Image.asset(
                          'assets/theam/heart on ground.png',
                          width: 103.w,
                          height: 60.h,
                        ),
                      ),
                    )
                  : SizedBox.shrink()
            ],
          );
  }

  Widget serch(them) {
    return Container(
      margin: EdgeInsets.only(left: 0.w),
      child: SizedBox(
        width: 329.w,
        height: 40.h,
        child: Stack(
          children: [
            Container(
              width: 320.45.w,
              height: 40.h,
              decoration: BoxDecoration(
                  color: HexColor('#FAFAFA'),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5), blurRadius: 4),
                  ],
                  borderRadius: BorderRadius.circular(15.sp)),
              child: TextFormField(
                  onFieldSubmitted: (value) {
                    homeController.skipSerch = 0;
                    homeController.serachEle(text: value, lableResult: 'items');
                    homeController.isSerch = true;
                    homeController.serchText = value;
                    Get.to(FilterdProdect(items: homeController.serachElemnt));
                  },
                  decoration: InputDecoration(
                      suffixIcon: thaem != 0
                          ? Image.asset(
                              'assets/theam/pngwing.com (6) 1.png',
                              width: 100.w,
                            )
                          : null,
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                        child: Image.asset(
                          'assets/seach_icon/Union (1).png',
                          width: 10.w,
                          height: 10.h,
                        ),
                      ),
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding: EdgeInsets.all(0),
                      hintText: 'ابحث عن مشروبك المفضل',
                      border: OutlineInputBorder(borderSide: BorderSide.none))),
            ),
          ],
        ),
      ),
    );
  }

  Widget catoCircl(img, title) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 30.r,
                backgroundColor: HexColor('#BDCEE0'),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 26.r,
                backgroundColor: Colors.white,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 23.r,
                backgroundColor: HexColor('#BDCEE0'),
                child: Image.network(
                  img,
                  width: 25.w,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 6.h,
        ),
        Text(title)
      ],
    );
  }

  Widget _customSliderImage() {
    return CarouselSlider(
      options: CarouselOptions(
          height: 180.h,
          initialPage: 0,
          reverse: false,
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.antiAliasWithSaveLayer),
      items: homeController.adss.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 8.w),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: "${Api.imgsPath}${i.img}",
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
