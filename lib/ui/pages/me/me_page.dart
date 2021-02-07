import 'package:dh/common/constants.dart';
import 'package:dh/http/result_data.dart';
import 'package:dh/provider/provider_widget.dart';
import 'package:dh/routers/fluro_navigator.dart';
import 'package:dh/routers/module/home_router.dart';
import 'package:dh/routers/module/login_router.dart';
import 'package:dh/routers/module/me_router.dart';
import 'package:dh/ui/widgets/alert.dart';
import 'package:dh/ui/widgets/custom_button.dart';
import 'package:dh/view_model/me_view_model.dart';
import 'package:flutter/material.dart';
import 'package:dh/utils/index.dart';

class MePage extends StatefulWidget {
  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ProviderWidget<MeViewModel>(
      model: MeViewModel(),
      onModelReady: (model) {
        model.initData();
      },
      builder: (ctx, model, child) {
        return NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: 240.h,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: Container(
                    width: 750.w,
                    height: 240.h,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              "assets/images/mine/head_bg.png",
                            ),
                            fit: BoxFit.cover)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 750.w,
                          height: 88.h,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 30.h),
                          child: Text("我的",
                              style: TextStyle(
                                  fontSize: 36.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 32.w, right: 40.w),
                            child: InkWell(
                              onTap: () {
                                NavigatorUtil.pushResult(
                                    context, MeRouter.personalCenter, (res) {
                                  model.initData();
                                });
                              },
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 20.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        model.icon == ""
                                            ? Container(
                                                width: 104.w,
                                                height: 104.w,
                                                alignment: Alignment.center,
                                                child: CircleAvatar(
                                                  radius: 50,
                                                  backgroundImage: AssetImage(
                                                      "assets/images/mine/img_filcoin.png"),
                                                ),
                                              )
                                            : Container(
                                                width: 104.w,
                                                height: 104.w,
                                                alignment: Alignment.center,
                                                child: CircleAvatar(
                                                  radius: 50,
                                                  backgroundImage:
                                                      NetworkImage(model.icon),
                                                ),
                                              ),
                                        Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "${model.hash_wa} TB",
                                            style: TextStyle(
                                                fontSize: 26.sp,
                                                color: Colors.white),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          width: 312.w,
                                          child: Text(model.username,
                                              softWrap: false,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 36.sp,
                                                  color: Colors.white)),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10.h),
                                          child: Text(model.phone,
                                              style: TextStyle(
                                                  fontSize: 26.sp,
                                                  color: Colors.white)),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10.h),
                                          child: Text("UID:${model.userid}",
                                              style: TextStyle(
                                                  fontSize: 26.sp,
                                                  color: Colors.white)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Image.asset(
                                      "assets/images/mine/more_w.png",
                                      width: 52.w,
                                      height: 52.h,
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              )
            ];
          },
          body: Container(
            color: Color(0xff161E30),
            child: ListView(
              padding: EdgeInsets.only(top: 20.h, bottom: 0),
              children: <Widget>[
                Container(
                  width: 686.w,
                  margin: EdgeInsets.only(left: 32.w, right: 32.w, top: 20.h),
                  padding: EdgeInsets.only(
                      left: 24.w, right: 23.w, top: 12.h, bottom: 12.h),
                  decoration: BoxDecoration(
                      color: Color(0xff1E2638),
                      borderRadius: BorderRadius.circular(10.w)),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 84.h,
                        child: InkWell(
                          onTap: () {
                            NavigatorUtil.push(context, HomeRouter.invite);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Image.asset("assets/images/mine/icon_yao.png",
                                      width: 56.w, height: 56.h),
                                  Container(
                                    margin: EdgeInsets.only(left: 10.w),
                                    child: Text("邀请好友",
                                        style: TextStyle(
                                            fontSize: 30.sp,
                                            color: Color(0xffffffff))),
                                  )
                                ],
                              ),
                              Image.asset("assets/images/mine/more.png",
                                  width: 14.w, height: 24.h)
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 1.h,
                        color: Color(0xff2C3448),
                      ),
                      Container(
                        width: double.infinity,
                        height: 84.h,
                        child: InkWell(
                          onTap: () {
                            NavigatorUtil.push(context, MeRouter.products);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Image.asset(
                                      "assets/images/mine/icon_ding.png",
                                      width: 56.w,
                                      height: 56.h),
                                  Container(
                                    margin: EdgeInsets.only(left: 10.w),
                                    child: Text("订单管理",
                                        style: TextStyle(
                                            fontSize: 30.sp,
                                            color: Color(0xfffffffff))),
                                  )
                                ],
                              ),
                              Image.asset("assets/images/mine/more.png",
                                  width: 14.w, height: 24.h)
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 2.h,
                        color: Color(0xff2C3448),
                      ),
                      Container(
                        width: double.infinity,
                        height: 84.h,
                        child: InkWell(
                          onTap: () {
                            NavigatorUtil.push(
                                context, MeRouter.computingPower);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Image.asset(
                                      "assets/images/mine/icon_zichan.png",
                                      width: 56.w,
                                      height: 56.h),
                                  Container(
                                    margin: EdgeInsets.only(left: 10.w),
                                    child: Text("算力管理",
                                        style: TextStyle(
                                            fontSize: 30.sp,
                                            color: Color(0xffffffff))),
                                  )
                                ],
                              ),
                              Image.asset("assets/images/mine/more.png",
                                  width: 14.w, height: 24.h)
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 1.h,
                        color: Color(0xff2C3448),
                      ),
                      Container(
                        width: double.infinity,
                        height: 84.h,
                        child: InkWell(
                          onTap: () {
                            NavigatorUtil.pushResult(
                                context,
                                MeRouter.certification +
                                    "?status=${model.isReal}", (res) {
                              model.initData();
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Image.asset("assets/images/mine/icon_ren.png",
                                      width: 56.w, height: 56.h),
                                  Container(
                                    margin: EdgeInsets.only(left: 10.w),
                                    child: Text("实名认证",
                                        style: TextStyle(
                                            fontSize: 30.sp,
                                            color: Color(0xffffffff))),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 15.w),
                                    child: Text(
                                        model.isReal == "0"
                                            ? "未认证"
                                            : model.isReal == "1"
                                                ? "已认证"
                                                : model.isReal == "2"
                                                    ? "审核中"
                                                    : "审核失败",
                                        style: TextStyle(
                                            fontSize: 30.sp,
                                            color: Color(0xff9a9a9a))),
                                  ),
                                  Image.asset("assets/images/mine/more.png",
                                      width: 14.w, height: 24.h)
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 1.h,
                        color: Color(0xff2C3448),
                      ),
                      Container(
                        width: double.infinity,
                        height: 84.h,
                        child: InkWell(
                          onTap: () {
                            NavigatorUtil.push(context, MeRouter.accountCenter);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Image.asset(
                                      "assets/images/mine/icon_safe.png",
                                      width: 56.w,
                                      height: 56.h),
                                  Container(
                                    margin: EdgeInsets.only(left: 10.w),
                                    child: Text("安全中心",
                                        style: TextStyle(
                                            fontSize: 30.sp,
                                            color: Color(0xffffffff))),
                                  )
                                ],
                              ),
                              Image.asset("assets/images/mine/more.png",
                                  width: 14.w, height: 24.h)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 686.w,
                  margin: EdgeInsets.only(left: 32.w, right: 32.w, top: 40.h),
                  padding: EdgeInsets.only(
                      left: 24.w, right: 23.w, top: 12.h, bottom: 12.h),
                  decoration: BoxDecoration(
                      color: Color(0xff1E2638),
                      borderRadius: BorderRadius.circular(10.w)),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 84.h,
                        child: InkWell(
                          onTap: () {
                            NavigatorUtil.push(context, MeRouter.service);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Image.asset("assets/images/mine/icon_ser.png",
                                      width: 56.w, height: 56.h),
                                  Container(
                                    margin: EdgeInsets.only(left: 10.w),
                                    child: Text("联系客服",
                                        style: TextStyle(
                                            fontSize: 30.sp,
                                            color: Color(0xffffffff))),
                                  )
                                ],
                              ),
                              Image.asset("assets/images/mine/more.png",
                                  width: 14.w, height: 24.h)
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 1.h,
                        color: Color(0xff2C3448),
                      ),
                      Container(
                        width: double.infinity,
                        height: 84.h,
                        child: InkWell(
                          onTap: () {
                            NavigatorUtil.push(context, MeRouter.helper);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Image.asset(
                                      "assets/images/mine/icon_help.png",
                                      width: 56.w,
                                      height: 56.h),
                                  Container(
                                    margin: EdgeInsets.only(left: 10.w),
                                    child: Text("帮助中心",
                                        style: TextStyle(
                                            fontSize: 30.sp,
                                            color: Color(0xffffffff))),
                                  )
                                ],
                              ),
                              Image.asset("assets/images/mine/more.png",
                                  width: 14.w, height: 24.h)
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 2.h,
                        color: Color(0xff2C3448),
                      ),
                      Container(
                        width: double.infinity,
                        height: 84.h,
                        child: InkWell(
                          onTap: () {
                            NavigatorUtil.push(context, MeRouter.system);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Image.asset("assets/images/mine/icon_sys.png",
                                      width: 56.w, height: 56.h),
                                  Container(
                                    margin: EdgeInsets.only(left: 10.w),
                                    child: Text("系统设置",
                                        style: TextStyle(
                                            fontSize: 30.sp,
                                            color: Color(0xffffffff))),
                                  )
                                ],
                              ),
                              Image.asset("assets/images/mine/more.png",
                                  width: 14.w, height: 24.h)
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 1.h,
                        color: Color(0xff2C3448),
                      ),
                      Container(
                        width: double.infinity,
                        height: 84.h,
                        child: InkWell(
                          onTap: () {
                            NavigatorUtil.push(context, MeRouter.appDownload);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Image.asset(
                                      "assets/images/mine/icon_download.png",
                                      width: 56.w,
                                      height: 56.h),
                                  Container(
                                    margin: EdgeInsets.only(left: 10.w),
                                    child: Text("APP下载",
                                        style: TextStyle(
                                            fontSize: 30.sp,
                                            color: Color(0xffffffff))),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Image.asset("assets/images/mine/more.png",
                                      width: 14.w, height: 24.h),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 32.w, right: 32.w, top: 113.h),
                  child: CustomButton(
                    "安全退出",
                    width: 686.w,
                    height: 98.h,
                    radius: 49.w,
                    color: Color(0xff4A90EA),
                    fontSize: 32.sp,
                    onPressed: () {
                      Alert.show(context,
                          title: "提示",
                          content: "确定退出登录吗?",
                          isCancel: true, onOk: () async {
                        ResultData resultData = await model.logout();
                        if (resultData.code == Constants.successCode) {
                          NavigatorUtil.push(context, LoginRouter.login,
                              replace: true);
                        } else {
                          ToastUtil.openToast(resultData.message);
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
