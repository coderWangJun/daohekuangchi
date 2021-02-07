import 'package:dh/provider/provider_widget.dart';
import 'package:dh/routers/fluro_navigator.dart';
import 'package:dh/routers/module/me_router.dart';
import 'package:dh/view_model/computing_view_model.dart';
import 'package:flutter/material.dart';
import 'package:dh/utils/index.dart';

class ComputingPowerManagementPage extends StatefulWidget {
  @override
  _ComputingPowerManagementPageState createState() =>
      _ComputingPowerManagementPageState();
}

class _ComputingPowerManagementPageState
    extends State<ComputingPowerManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff161D30),
      appBar: AppBar(
        title: Text("算力管理"),
        elevation: 0,
        backgroundColor: Color(0xff427CD3),
      ),
      body: ProviderWidget<ComputingViewModel>(
        model: ComputingViewModel(),
        onModelReady: (model) {
          model.initData();
        },
        builder: (ctx,model,child) {
          return Column(
            children: <Widget>[
              Container(
                width: 750.w,
                height: 288.h,
                decoration: BoxDecoration(color: Color(0xff427CD3)),
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(left: 73.w, right: 73.w, top: 30.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("等级：${model.computingEntity.upperhalf.levelname}",
                        style: TextStyle(fontSize: 26.sp, color: Colors.white)),
                    Text("总收益：${model.computingEntity.upperhalf.revenue} FiL",
                        style: TextStyle(fontSize: 26.sp, color: Colors.white)),
                  ],
                ),
              ),
              Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Container(
                    width: 750.w,
                    height: 163.h,
                    color: Color(0xff161D30),
                  ),
                  Positioned(
                    top: -203.h,
                    child: Container(
                      width: 692.w,
                      height: 327.h,
                      margin: EdgeInsets.only(left: 29.w, right: 29.w),
                      padding: EdgeInsets.symmetric(vertical: 23.h),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                              AssetImage("assets/images/mine/img_bg_blue.png"),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(10.w)),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 342.w,
                                height: 140.h,
                                decoration: BoxDecoration(
                                    border: Border(
                                      bottom:
                                      BorderSide(width: 1.w, color: Colors.white),
                                      right:
                                      BorderSide(width: 1.w, color: Colors.white),
                                    )),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(model.computingEntity.upperhalf.hash,
                                        style: TextStyle(
                                            fontSize: 40.sp, color: Colors.white)),
                                    Text("我的算力（T）",
                                        style: TextStyle(
                                            fontSize: 26.sp, color: Colors.white)),
                                  ],
                                ),
                              ),
                              Container(
                                width: 342.w,
                                height: 140.h,
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(model.computingEntity.upperhalf.team,
                                        style: TextStyle(
                                            fontSize: 40.sp, color: Colors.white)),
                                    Text("团队总算力（T）",
                                        style: TextStyle(
                                            fontSize: 26.sp, color: Colors.white)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 342.w,
                                height: 140.h,
                                decoration: BoxDecoration(
                                    border: Border(
                                      right:
                                      BorderSide(width: 1.w, color: Colors.white),
                                    )),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(model.computingEntity.upperhalf.club,
                                        style: TextStyle(
                                            fontSize: 40.sp, color: Colors.white)),
                                    Text("社区算力（T）",
                                        style: TextStyle(
                                            fontSize: 26.sp, color: Colors.white)),
                                  ],
                                ),
                              ),
                              Container(
                                width: 342.w,
                                height: 140.h,
                                decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(width: 1.w, color: Colors.white),
                                    )),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(model.computingEntity.upperhalf.total,
                                        style: TextStyle(
                                            fontSize: 40.sp, color: Colors.white)),
                                    Text("矿池总算力（T）",
                                        style: TextStyle(
                                            fontSize: 26.sp, color: Colors.white)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              InkWell(
                onTap: () {
                  NavigatorUtil.push(context, MeRouter.incomeDetails+"?type=1");
                },
                child: Container(
                  width: 686.w,
                  height: 104.h,
                  margin: EdgeInsets.only(left: 32.w, right: 32.w, top: 32.h),
                  padding: EdgeInsets.only(left: 33.w, right: 21.w),
                  decoration: BoxDecoration(
                      color: Color(0xff1E2538),
                      borderRadius: BorderRadius.circular(10.w)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("个人挖矿收益",
                          style: TextStyle(fontSize: 30.sp, color: Colors.white)),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("${model.computingEntity.lowerhalf.myester} FiL",
                              style: TextStyle(fontSize: 26.sp, color: Colors.white)),
                          Text("昨日收益",
                              style: TextStyle(fontSize: 26.sp, color: Color(0xff999999)))
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("${model.computingEntity.lowerhalf.myTotal} FiL",
                              style: TextStyle(fontSize: 26.sp, color: Color(0xff73AAFF))),
                          Text("累计收益",
                              style: TextStyle(fontSize: 26.sp, color: Color(0xff999999)))
                        ],
                      ),
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
                  NavigatorUtil.push(context, MeRouter.incomeDetails+"?type=2");
                },
                child: Container(
                  width: 686.w,
                  height: 104.h,
                  margin: EdgeInsets.only(left: 32.w, right: 32.w, top: 32.h),
                  padding: EdgeInsets.only(left: 33.w, right: 21.w),
                  decoration: BoxDecoration(
                      color: Color(0xff1E2538),
                      borderRadius: BorderRadius.circular(10.w)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("团队挖矿收益",
                          style: TextStyle(fontSize: 30.sp, color: Colors.white)),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("${model.computingEntity.lowerhalf.millteam} FiL",
                              style: TextStyle(fontSize: 26.sp, color: Colors.white)),
                          Text("昨日收益",
                              style: TextStyle(fontSize: 26.sp, color: Color(0xff999999)))
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("${model.computingEntity.lowerhalf.millincome} FiL",
                              style: TextStyle(fontSize: 26.sp, color: Color(0xff73AAFF))),
                          Text("累计收益",
                              style: TextStyle(fontSize: 26.sp, color: Color(0xff999999)))
                        ],
                      ),
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
                  NavigatorUtil.push(context, MeRouter.incomeDetails+"?type=3");
                },
                child: Container(
                  width: 686.w,
                  height: 104.h,
                  margin: EdgeInsets.only(left: 32.w, right: 32.w, top: 32.h),
                  padding: EdgeInsets.only(left: 33.w, right: 21.w),
                  decoration: BoxDecoration(
                      color: Color(0xff1E2538),
                      borderRadius: BorderRadius.circular(10.w)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("社区挖矿收益",
                          style: TextStyle(fontSize: 30.sp, color: Colors.white)),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("${model.computingEntity.lowerhalf.millareaDays} FiL",
                              style: TextStyle(fontSize: 26.sp, color: Colors.white)),
                          Text("昨日收益",
                              style: TextStyle(fontSize: 26.sp, color: Color(0xff999999)))
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("${model.computingEntity.lowerhalf.millareaIncome} FiL",
                              style: TextStyle(fontSize: 26.sp, color: Color(0xff73AAFF))),
                          Text("累计收益",
                              style: TextStyle(fontSize: 26.sp, color: Color(0xff999999)))
                        ],
                      ),
                      Image.asset(
                        "assets/images/mine/more.png",
                        width: 14.w,
                        height: 24.h,
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
