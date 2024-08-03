import 'package:flutter/material.dart';
import 'package:prostore/widget/home_widget/app_head.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class NotfctionsPage extends StatelessWidget {
  bool isF = false;
  NotfctionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          AppHead(
            isTowIcon: true,
            title: 'الاشعارات',
            prefxItem: Text(''),
          ),
          !isF
              ? Expanded(
                  child: Center(
                      child: Text(
                  'لم يصلك اشعار لغاية الان',
                  style: TextStyle(fontSize: 15.sp),
                )))
              : Expanded(
                  child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(top: 37.h, left: 30.w, right: 30.w),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 30.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: HexColor('#0F0F0F').withOpacity(0.2),
                                blurRadius: 13),
                          ]),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 20.h, bottom: 20.h, right: 23.w, left: 17.w),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 4.h),
                              child: SizedBox(
                                width: double.infinity.w,
                                child: Text(
                                  'datadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadata',
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: HexColor('#222222')),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity.w,
                              child: Text(
                                'datadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadata',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: HexColor('#686868')),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ))
        ],
      ),
    ));
  }
}
