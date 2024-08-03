import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget AppTextInput(
    {String? lable,
    double botomPading = 0,
    bool pasword = false,
    TextEditingController? controlle,
    TextInputType? keyboardType,
    void Function(String?)? onSaved}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Padding(
        padding: EdgeInsets.only(right: 30.w),
        child: Text(
          lable!,
          style: TextStyle(fontSize: 18.sp),
        ),
      ),
      SizedBox(
        width: 10.w,
      ),
      Padding(
        padding: EdgeInsets.only(left: 50.w),
        child: SizedBox(
          width: 200.w,
          child: TextFormField(
            controller: controlle,
            obscureText: pasword,
            keyboardType: keyboardType,
            validator: (value) {
              if (value!.isEmpty) {
                return "لا يمكن ترك الحقل فارغ";
              }
              return null;
            },
            onSaved: onSaved,
          ),
        ),
      ),
    ],
  );
}
