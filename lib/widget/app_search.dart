import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSearch extends StatelessWidget {
  const AppSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 25.h),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.sp),
            color: HexColor('#FAFAFA'),
            boxShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 4),
            ]),
        child: TextFormField(
            decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.only(top: 13.h, bottom: 14.h),
                  child: Image.asset(
                    'assets/seach_icon/Union (1).png',
                    width: 10.w,
                    height: 10.h,
                  ),
                ),
                contentPadding: EdgeInsets.all(10),
                hintText: 'البحث',
                border: OutlineInputBorder(borderSide: BorderSide.none))),
      ),
    );
  }
}
