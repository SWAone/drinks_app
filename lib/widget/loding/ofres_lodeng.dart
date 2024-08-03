import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class OfresLodeng extends StatelessWidget {
  bool category;
  OfresLodeng({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return _offers();
  }

  Widget _offers() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: EdgeInsets.only(top: 20.h),
        height: 158.h,
        width: 424.w,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                    color: Colors.red,
                  ),
                  width: 110.w,
                  height: 158.h,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: category ? 10 : 60.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 20.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(
                    height: 23.h,
                  ),
                  Container(
                    width: 160.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      color: Colors.red,
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
