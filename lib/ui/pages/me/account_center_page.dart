import 'package:dh/provider/provider_widget.dart';
import 'package:dh/routers/fluro_navigator.dart';
import 'package:dh/routers/module/me_router.dart';
import 'package:dh/ui/widgets/custom_app_bar.dart';
import 'package:dh/utils/index.dart';
import 'package:dh/view_model/account_center_view_model.dart';
import 'package:flutter/material.dart';

class AccountCenterPage extends StatefulWidget {
  @override
  _AccountCenterPageState createState() => _AccountCenterPageState();
}

class _AccountCenterPageState extends State<AccountCenterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff161D30),
        appBar: CustomAppBar(
          centerTitle: "安全中心",
          isBack: true,
          backgroundColor: Color(0xff161D30),
        ),
        body: ProviderWidget<AccountCenterViewModel>(
          model: AccountCenterViewModel(),
          onModelReady: (model) {
            model.initData();
          },
          builder: (ctx, model, child) {
            return Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    if (model.busy == false)
                      NavigatorUtil.pushResult(
                          context, MeRouter.bindPhone + "?phone=${model.phone}",
                          (res) {
                        if (mounted) {
                          setState(() {
                            model.initData();
                          });
                        }
                      });
                  },
                  child: Container(
                    width: 686.w,
                    height: 114.h,
                    margin: EdgeInsets.only(top: 32.h,left: 32.w,right: 32.w),
                    padding: EdgeInsets.symmetric(horizontal: 33.w),
                    decoration: BoxDecoration(
                      color: Color(0xff1E2538),
                      borderRadius: BorderRadius.circular(10.w)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("手机绑定", style: TextStyle(fontSize: 30.sp,color: Colors.white)),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 10.w),
                              child: Text(model.phone,
                                  style: TextStyle(
                                      fontSize: 30.sp,
                                      color: Color(0xff999999))),
                            ),
                            Image.asset(
                              "assets/images/mine/more.png",
                              width: 13.w,
                              height: 23.h,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (model.busy == false)
                      NavigatorUtil.push(context,
                          MeRouter.changeLogin + "?phone=${model.phone}");
                  },
                  child: Container(
                    width: 686.w,
                    height: 114.h,
                    margin: EdgeInsets.only(top: 32.h,left: 32.w,right: 32.w),
                    padding: EdgeInsets.symmetric(horizontal: 33.w),
                    decoration: BoxDecoration(
                        color: Color(0xff1E2538),
                        borderRadius: BorderRadius.circular(10.w)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("登录密码", style: TextStyle(fontSize: 30.sp,color: Colors.white)),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 10.w),
                              child: Text("修改",
                                  style: TextStyle(
                                      fontSize: 30.sp,
                                      color: Color(0xff999999))),
                            ),
                            Image.asset(
                              "assets/images/mine/more.png",
                              width: 13.w,
                              height: 23.h,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (model.busy == false)
                      NavigatorUtil.push(context,
                          MeRouter.changePay + "?phone=${model.phone}");
                  },
                  child: Container(
                    width: 686.w,
                    height: 114.h,
                    margin: EdgeInsets.only(top: 32.h,left: 32.w,right: 32.w),
                    padding: EdgeInsets.symmetric(horizontal: 33.w),
                    decoration: BoxDecoration(
                        color: Color(0xff1E2538),
                        borderRadius: BorderRadius.circular(10.w)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("资金密码", style: TextStyle(fontSize: 30.sp,color: Colors.white)),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 10.w),
                              child: Text("修改",
                                  style: TextStyle(
                                      fontSize: 30.sp,
                                      color: Color(0xff999999))),
                            ),
                            Image.asset(
                              "assets/images/mine/more.png",
                              width: 13.w,
                              height: 23.h,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (model.busy == false)
                      NavigatorUtil.pushResult(
                          context,
                          MeRouter.bindEmail +
                              "?phone=${model.phone}" +
                              "&username=${model.username}",
                          (res) => {model.initData()});
                  },
                  child: Container(
                    width: 686.w,
                    height: 114.h,
                    margin: EdgeInsets.only(top: 32.h,left: 32.w,right: 32.w),
                    padding: EdgeInsets.symmetric(horizontal: 33.w),
                    decoration: BoxDecoration(
                        color: Color(0xff1E2538),
                        borderRadius: BorderRadius.circular(10.w)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("邮箱绑定", style: TextStyle(fontSize: 30.sp,color: Colors.white)),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 10.w),
                              child: Text(model.email,
                                  style: TextStyle(
                                      fontSize: 30.sp,
                                      color: Color(0xff999999))),
                            ),
                            Image.asset(
                              "assets/images/mine/more.png",
                              width: 13.w,
                              height: 23.h,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }
}
