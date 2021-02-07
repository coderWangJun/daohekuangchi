import 'package:flutter/material.dart';
import 'package:dh/utils/index.dart';

class CustomItemClickPage extends StatelessWidget {
  final String title;
  final GestureTapCallback onTap;

  const CustomItemClickPage({Key key, @required this.title, @required this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 750.w,
        height: 98.h,
        margin: EdgeInsets.only(top: 16.h),
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(title,style: TextStyle(fontSize: 28.sp),),
            Image.asset(
              "assets/images/mine/more.png",
              width: 48.w,
              height: 48.h,
            ),
          ],
        ),
      ),
    );
  }
}
