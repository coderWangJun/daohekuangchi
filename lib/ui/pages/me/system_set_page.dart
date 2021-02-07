import 'package:dh/routers/fluro_navigator.dart';
import 'package:dh/routers/module/me_router.dart';
import 'package:dh/ui/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:dh/utils/index.dart';

class SystemSetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff161D30),
      appBar: CustomAppBar(
        centerTitle: "系统设置",
        isBack: true,
        backgroundColor: Color(0xff161D30),
      ),
      body: Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              NavigatorUtil.push(context, MeRouter.about);
            },
            child: Container(
              width: 686.w,
              height: 104.h,
              margin: EdgeInsets.only(left: 32.w, right: 32.w, top: 32.h),
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              decoration: BoxDecoration(
                color: Color(0xff1E2538),
                borderRadius: BorderRadius.circular(10.w),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("关于我们",
                      style: TextStyle(fontSize: 30.sp, color: Colors.white)),
                  Image.asset(
                    "assets/images/mine/more.png",
                    width: 14.w,
                    height: 24.h,
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              width: 686.w,
              height: 104.h,
              margin: EdgeInsets.only(left: 32.w, right: 32.w, top: 32.h),
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              decoration: BoxDecoration(
                color: Color(0xff1E2538),
                borderRadius: BorderRadius.circular(10.w),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("监控视频  (暂未开放)",
                      style: TextStyle(fontSize: 30.sp, color: Colors.white)),
                  Image.asset(
                    "assets/images/mine/more.png",
                    width: 14.w,
                    height: 24.h,
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              NavigatorUtil.push(context, MeRouter.userLegal+"?type=2");
            },
            child: Container(
              width: 686.w,
              height: 104.h,
              margin: EdgeInsets.only(left: 32.w, right: 32.w, top: 32.h),
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              decoration: BoxDecoration(
                color: Color(0xff1E2538),
                borderRadius: BorderRadius.circular(10.w),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("用户协议",
                      style: TextStyle(fontSize: 30.sp, color: Colors.white)),
                  Image.asset(
                    "assets/images/mine/more.png",
                    width: 14.w,
                    height: 24.h,
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              NavigatorUtil.push(context, MeRouter.userLegal+"?type=3");
            },
            child: Container(
              width: 686.w,
              height: 104.h,
              margin: EdgeInsets.only(left: 32.w, right: 32.w, top: 32.h),
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              decoration: BoxDecoration(
                color: Color(0xff1E2538),
                borderRadius: BorderRadius.circular(10.w),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("法律声明",
                      style: TextStyle(fontSize: 30.sp, color: Colors.white)),
                  Image.asset(
                    "assets/images/mine/more.png",
                    width: 14.w,
                    height: 24.h,
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              width: 686.w,
              height: 104.h,
              margin: EdgeInsets.only(left: 32.w, right: 32.w, top: 32.h),
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              decoration: BoxDecoration(
                color: Color(0xff1E2538),
                borderRadius: BorderRadius.circular(10.w),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("检查更新",
                      style: TextStyle(fontSize: 30.sp, color: Colors.white)),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 20.w),
                        child: Text("已更新到最新版本",
                            style: TextStyle(
                                fontSize: 30.sp, color: Color(0xff999999))),
                      ),
                      Image.asset(
                        "assets/images/mine/more.png",
                        width: 14.w,
                        height: 24.h,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
