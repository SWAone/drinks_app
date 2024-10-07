import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:prostore/api/api.dart';
import 'package:prostore/controller/swa_stor/home_c/home_controller.dart';
import 'package:prostore/main.dart';
import 'package:prostore/model/item_model.dart';
import 'package:prostore/view/product/product_full.dart';
import 'package:intl/intl.dart';

class AppProduct extends StatelessWidget {
  HomeController homeController = Get.put(HomeController());
  ItemModel prodct;
  String imagUrl;
  bool isLoding;

  AppProduct(
      {super.key,
      this.isLoding = false,
      required this.prodct,
      this.imagUrl = 'assets/home_icon/Mask Group (1).png'});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(ProductFull(item: prodct));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: HexColor('#000000').withOpacity(0.25), blurRadius: 3)
            ], color: Colors.black, borderRadius: BorderRadius.circular(11.r)),
            child: CachedNetworkImage(
              width: 144.w,
              height: 180.h,
              imageUrl: "${Api.imgsPath}${prodct.imags}",
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          SizedBox(
            height: 14.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 1.w, right: 5.w, bottom: 4.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 126.w,
                  child: Text(
                    prodct.title!,
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w300),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                SizedBox(
                  width: 90.w,
                  child: Text(
                    '${NumberFormat('#,##0', 'en_US').format(double.parse('${prodct.price!}'))} د.ع',
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w800),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
