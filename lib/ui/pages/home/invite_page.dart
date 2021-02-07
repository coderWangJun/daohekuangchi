import 'package:dh/provider/provider_widget.dart';
import 'package:dh/res/styles.dart';
import 'package:dh/routers/fluro_navigator.dart';
import 'package:dh/routers/module/home_router.dart';
import 'package:dh/routers/module/me_router.dart';
import 'package:dh/ui/widgets/alert.dart';
import 'package:dh/ui/widgets/custom_app_bar.dart';
import 'package:dh/ui/widgets/custom_button.dart';
import 'package:dh/ui/widgets/custom_text.dart';
import 'package:dh/view_model/invite_view_model.dart';
import 'package:flutter/material.dart';
import 'package:dh/utils/index.dart';
import 'package:flutter/services.dart';

class InvitePage extends StatefulWidget {
  @override
  _InvitePageState createState() => _InvitePageState();
}

class _InvitePageState extends State<InvitePage> {

  void _showBottomSheet(InviteViewModel model) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        elevation: 10,
        isDismissible: true,
        isScrollControlled: true,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.w)),
        builder: (BuildContext context) {
          return Container(
            color: Color(0xff2B3448),
            child: Wrap(
              children: <Widget>[
                Container(
                  width: 750.w,
                  height: 98.h,
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(),
                      Container(
                        alignment: Alignment.center,
                        child: Text("分享",
                            style: TextStyle(
                                fontSize: 32.sp, color: Colors.white)),
                      ),
                      InkWell(
                        onTap: () {
                          NavigatorUtil.pop(context);
                        },
                        child: Image.asset(
                          "assets/images/home/exit.png",
                          width: 48.w,
                          height: 48.h,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 750.w,
                  height: 196.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          NavigatorUtil.pop(context);
                          NavigatorUtil.push(context, MeRouter.mineInvite);
                        },
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              "assets/images/home/save.png",
                              width: 104.w,
                              height: 104.h,
                            ),
                            Container(
                              child: Text("我的专属海报",
                                  style: TextStyle(fontSize: 28.sp,color: Colors.white)),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          ClipboardData data =
                              new ClipboardData(text: model.inviteEntity.img);
                          Clipboard.setData(data);
                          ToastUtil.openToast('复制成功');
                        },
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              "assets/images/home/lian.png",
                              width: 104.w,
                              height: 104.h,
                            ),
                            Container(
                              child: Text("复制链接",
                                  style: TextStyle(fontSize: 28.sp,color: Colors.white)),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<InviteViewModel>(
        model: InviteViewModel(), //此处引入新增的model
        onModelReady: (model) {
          //初始化页面数据
          model.initData().then((res) {
            if (res.code == "0002") {
              ToastUtil.openToast(res.message);
              NavigatorUtil.pop(context);
            }
          });
        },
        builder: (ctx, model, child) {
          return Scaffold(
              appBar: CustomAppBar(
                centerTitle: "邀请好友",
                fontSize: 34.sp,
                backgroundColor: Color(0xff161D30),
              ),
              backgroundColor: Color(0xff161D30),
              body: Builder(builder: (_) {
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 34.h, left: 32.w),
                        padding: EdgeInsets.only(top: 75.h),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.sp)),
                          color: Color(0xff2B3448),
                        ),
                        width: 686.w,
                        child: Column(
                          children: <Widget>[
                            CustomText(
                              "邀请好友一起赚钱",
                              color: Color(0xffFFEA5F),
                              fontSize: 40,
                            ),
                            CustomText(
                              "邀请好友下载APP获取超高奖励",
                              color: Color(0xffFFEA5F),
                              fontSize: 32,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 110.h),
                              child: CustomText(
                                "专属邀请码",
                                color: Colors.white,
                                fontSize: 30,
                              ),
                            ),
                            Container(
                              width: 275.w,
                              margin: EdgeInsets.only(top: 32.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  CustomText(
                                    model.inviteEntity.invitecode,
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      ClipboardData data = new ClipboardData(
                                          text: model.inviteEntity.invitecode);
                                      Clipboard.setData(data);
                                      ToastUtil.openToast('邀请码已复制');
                                    },
                                    child: Image.asset(
                                      "assets/images/home/icon_copy.png",
                                      width: 56.w,
                                      height: 56.w,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                ClipboardData data = new ClipboardData(
                                    text: model.inviteEntity.img);
                                Clipboard.setData(data);
                                Alert.show(
                                  context,
                                  child: Column(
                                    children: <Widget>[
                                      Text("分享链接已复制",
                                          style: Styles.theme(
                                            fontSize: 32.ssp,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Color.fromRGBO(250, 150, 69, 1),
                                          )),
                                      Text("可直接粘贴发送给好友",
                                          style: Styles.theme(
                                            fontSize: 32.ssp,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Color.fromRGBO(250, 150, 69, 1),
                                          ))
                                    ],
                                  ),
                                  isCancel: false,
                                  onOk: () {},
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 76.h),
                                child: CustomButton(
                                  '立即邀请',
                                  color: Color(0xffFFD454),
                                  width: 280.w,
                                  height: 72.h,
                                  radius: 36,
                                  fontSize: 32.sp,
                                  onPressed: () {
                                    _showBottomSheet(model);
                                  },
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 31.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(),
                                  Text.rich(
                                    TextSpan(children: <InlineSpan>[
                                      WidgetSpan(
                                        child: CustomText(
                                          '您已邀请',
                                          fontSize: 24,
                                          color:
                                              Color.fromRGBO(102, 102, 102, 1),
                                        ),
                                      ),
                                      WidgetSpan(
                                        child: CustomText(
                                          model.inviteEntity.referNum
                                              .toString(),
                                          fontSize: 24,
                                          color:
                                              Color.fromRGBO(242, 174, 78, 1),
                                        ),
                                      ),
                                      WidgetSpan(
                                        child: CustomText(
                                          '人，购买算力人数为',
                                          fontSize: 24,
                                          color:
                                              Color.fromRGBO(102, 102, 102, 1),
                                        ),
                                      ),
                                      WidgetSpan(
                                        child: CustomText(
                                          model.inviteEntity.invest,
                                          fontSize: 24,
                                          color:
                                              Color.fromRGBO(242, 174, 78, 1),
                                        ),
                                      ),
                                      WidgetSpan(
                                        child: CustomText(
                                          '，累积获得',
                                          fontSize: 24,
                                          color:
                                              Color.fromRGBO(102, 102, 102, 1),
                                        ),
                                      ),
                                      WidgetSpan(
                                        child: CustomText(
                                          model.inviteEntity.totalcash,
                                          fontSize: 24,
                                          color:
                                              Color.fromRGBO(242, 174, 78, 1),
                                        ),
                                      ),
                                      WidgetSpan(
                                        child: CustomText(
                                          '佣金',
                                          fontSize: 24,
                                          color:
                                              Color.fromRGBO(102, 102, 102, 1),
                                        ),
                                      ),
                                    ]),
                                    textAlign: TextAlign.center,
                                  ),
                                  Container(),
                                ],
                              ),
                            ),
                            Container(
//                              margin: EdgeInsets.only(top: 44.h),
                              width: 686.w,
                              height: 298.h,
                              child: Image.asset(
                                "assets/images/home/img_liu.png",
                                width: 686.w,
                                height: 298.h,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.sp)),
                          color: Color(0xff2B3448),
                        ),
                        margin: EdgeInsets.only(top: 34.h, left: 32.w),
                        width: 686.w,
                        height: 352.h,
                        child: Column(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                NavigatorUtil.push(
                                    context, HomeRouter.inviteRecord);
                              },
                              child: Container(
                                width: 686.w,
                                height: 64.h,
                                padding:
                                    EdgeInsets.only(left: 25.w, right: 33.w),
                                margin: EdgeInsets.only(top: 20.h),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1.w,
                                            color: Color(0xffECECEC)))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    CustomText(
                                      '我的奖励',
                                      fontSize: 28,
                                      color: Color(0xffB1C6EA),
                                    ),
                                    Image.asset(
                                      'assets/images/home/more_home.png',
                                      width: 14.w,
                                      height: 24.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 25.w, right: 33.w),
                              margin: EdgeInsets.only(top: 40.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  CustomText(
                                    '累积邀请人数',
                                    fontSize: 28,
                                    color: Color(0xffB1C6EA),
                                  ),
                                  CustomText(
                                    model.inviteEntity.referNum.toString() +
                                        '人',
                                    fontSize: 28,
                                    color: Color.fromRGBO(242, 174, 78, 1),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 25.w, right: 33.w),
                              margin: EdgeInsets.only(top: 20.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  CustomText(
                                    '累积购买人数',
                                    fontSize: 28,
                                    color: Color(0xffB1C6EA),
                                  ),
                                  CustomText(
                                    model.inviteEntity.invest + '人',
                                    fontSize: 28,
                                    color: Color.fromRGBO(242, 174, 78, 1),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 25.w, right: 33.w),
                              margin: EdgeInsets.only(top: 20.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  CustomText(
                                    '累计推广算力',
                                    fontSize: 28,
                                    color: Color(0xffFF4E25),
                                  ),
                                  CustomText(
                                    model.inviteEntity.refercash + ' TB',
                                    fontSize: 28,
                                    color: Color(0xffFF4E25),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 25.w, right: 33.w),
                              margin: EdgeInsets.only(top: 20.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  CustomText(
                                    '累积获得佣金',
                                    fontSize: 28,
                                    color: Color(0xffB1C6EA),
                                  ),
                                  CustomText(
                                    model.inviteEntity.totalcash + ' USDT',
                                    fontSize: 28,
                                    color: Color.fromRGBO(242, 174, 78, 1),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }));
        });
  }
}
