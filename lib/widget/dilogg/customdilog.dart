import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDialog extends StatelessWidget {
  String title, body, btnText, icoImage;
  void Function()? onPressed;
  TextStyle? style;
  CustomDialog(
      {super.key,
      this.icoImage = 'assets/dilog_icon/info-svgrepo-com.png',
      this.title = '',
      this.body = 'سيتم تسجيل خروجك',
      this.onPressed,
      this.style,
      this.btnText = 'تسجيل الخروج'});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0, 10),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                icoImage,
                height: 100.h,
              ),
              SizedBox(
                height: 20.h,
              ),
              title.isNotEmpty
                  ? Text(
                      title,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    )
                  : SizedBox.shrink(),
              SizedBox(height: 15.h),
              body.isNotEmpty
                  ? Text(
                      body,
                      style: TextStyle(fontSize: 17.sp),
                      textAlign: TextAlign.center,
                    )
                  : SizedBox.shrink(),
              SizedBox(height: 22),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: onPressed,
                  child: Text(
                    btnText,
                    style: style,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
