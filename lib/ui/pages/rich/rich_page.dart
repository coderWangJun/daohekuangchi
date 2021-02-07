import 'package:barcode_scan/barcode_scan.dart';
import 'package:dh/common/constants.dart';
import 'package:dh/provider/provider_widget.dart';
import 'package:dh/res/styles.dart';
import 'package:dh/routers/fluro_navigator.dart';
import 'package:dh/routers/module/rich_router.dart';
import 'package:dh/view_model/rich_view_model.dart';
import 'package:flutter/material.dart';
import 'package:dh/utils/index.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:async';

class RichPage extends StatefulWidget {
  @override
  _RichPageState createState() => _RichPageState();
}

class _RichPageState extends State<RichPage> with TickerProviderStateMixin {
  RichViewModel _viewModel;

  int selectIndex = 0;

  TabController _tabController;

  int currentTab = 0;

  bool showMoney = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(length: 1, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      LogUtil.v(barcode);
      String type = barcode.indexOf("USDT") >= 0 ? "0" : "1";
      int index = barcode.indexOf("|");
      barcode = barcode.substring(index + 1);
      NavigatorUtil.push(
          context, RichRouter.transfer + "?other=" + barcode + "&type=" + type);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          //return this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() {
          //return this.barcode = 'Unknown error: $e';
        });
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<RichViewModel>(
      model: RichViewModel(),
      onModelReady: (model) {
        model.initData();
        _viewModel = model;
      },
      builder: (ctx, model, child) {
        return NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Styles.color00C6BE,
                automaticallyImplyLeading: false,
                expandedHeight: 320.h,
                centerTitle: true,
                leading: IconButton(
                  onPressed: () {
                    scan();
                  },
                  tooltip: '返回',
                  padding: const EdgeInsets.all(10.0),
                  icon: Image.asset('assets/images/rich/icon_saoma.png',
                      color: Colors.white, width: 64.w, height: 64.w),
                ),
                actions: <Widget>[
                  IconButton(
                    onPressed: () {
                      var username = _viewModel.username == null
                          ? SpUtil.getString(Constants.USER_NAME)
                          : _viewModel.username;
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) => BarCodeWidget(username: username),
                      );
                    },
                    padding: const EdgeInsets.all(10.0),
                    icon: Image.asset('assets/images/rich/icon_tiaoma.png',
                        color: Colors.white, width: 64.w, height: 64.w),
                  )
                ],
                title: Text(
                  "资产",
                  style: Styles.theme(
                      color: Styles.colorWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 36.ssp),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: Container(
                    width: 750.w,
                    decoration: BoxDecoration(
                      color: Styles.color00C6BE,
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 170.h, left: 38.w),
                          alignment: Alignment.centerLeft,
                          height: 48.h,
                          child: Text(
                            "总资产折合(USDT)",
                            style: Styles.theme(
                                fontSize: 26.sp, color: Styles.colorWhite),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 38.w, right: 32.w),
                          alignment: Alignment.centerLeft,
                          height: 72.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                showMoney ? model.total : "******",
                                style: Styles.theme(
                                    fontSize: 60.sp, color: Styles.colorWhite),
                              ),
                              GestureDetector(
                                onTap: () {
                                  this.showMoney = !showMoney;
                                  setState(() {});
                                },
                                child: showMoney
                                    ? Image.asset(
                                        "assets/images/common/show.png",
                                        width: 56.w,
                                        height: 56.w,
                                      )
                                    : Image.asset(
                                        "assets/images/common/hide.png",
                                        width: 56.w,
                                        height: 56.w,
                                      ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 38.w),
                          alignment: Alignment.centerLeft,
                          height: 48.h,
                          child: Text(
                            showMoney
                                ? "≈" + model.totalCny + " CNY"
                                : "******",
                            style: Styles.theme(
                                fontSize: 26.sp, color: Styles.colorWhite),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ];
          },
          body: Container(
            decoration: BoxDecoration(color: Styles.colorBackgroundColor),
            alignment: Alignment.topCenter,
            child:
                ListView(padding: EdgeInsets.only(top: 0.h), children: <Widget>[
              Container(
                height: 8.h,
                width: 750.w,
                color: Styles.color2C3448,
              ),
              Container(
                height: 354.h,
                margin: EdgeInsets.only(left: 32.w, right: 33.w),
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        NavigatorUtil.push(
                            context, RichRouter.flow + "?type=0&name=USDT");
                      },
                      child: Container(
                        height: 100.h,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Styles.color2B3448, width: 1.w))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Image.asset('assets/images/rich/USDT.png',
                                    width: 36.w, height: 36.w),
                                Padding(
                                  padding: EdgeInsets.only(left: 18.w),
                                  child: Text(
                                    "USDT",
                                    style: Styles.theme(
                                        fontSize: 32.sp,
                                        color: Styles.colorWhite,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                            Image.asset('assets/images/rich/more.png',
                                width: 14.w, height: 24.w),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 140.h,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Styles.color2B3448, width: 1.w))),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 140.h,
                            width: 228.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("可用",
                                    style: Styles.theme(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 26.sp,
                                        color: Styles.colorWhite)),
                                Text(model.usdtAvailable,
                                    style: Styles.theme(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 26.sp,
                                        color: Styles.colorWhite)),
                              ],
                            ),
                          ),
                          Container(
                            height: 140.h,
                            width: 228.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("冻结",
                                    style: Styles.theme(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 26.sp,
                                        color: Styles.colorWhite)),
                                Text(model.usdtFreeze,
                                    style: Styles.theme(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 26.sp,
                                        color: Styles.colorWhite)),
                              ],
                            ),
                          ),
                          Container(
                            height: 140.h,
                            width: 228.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("折合(CNY)",
                                    style: Styles.theme(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 26.sp,
                                        color: Styles.colorWhite)),
                                Text(model.usdtCny,
                                    style: Styles.theme(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 26.sp,
                                        color: Styles.colorWhite)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 112.h,
                      margin: EdgeInsets.only(left: 32.w, right: 33.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              NavigatorUtil.pushResult(
                                  context,
                                  RichRouter.recharge +
                                      "?token=" +
                                      model.walletToken, (res) {
                                model.initData();
                                setState(() {});
                              });
                            },
                            child: Row(
                              children: <Widget>[
                                Image.asset('assets/images/rich/icon_chong.png',
                                    width: 36.w, height: 36.w),
                                Padding(
                                  padding: EdgeInsets.only(left: 18.w),
                                  child: Text(
                                    "充币",
                                    style: Styles.theme(
                                        fontSize: 28.sp,
                                        color: Styles.colorB1C6EA,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              NavigatorUtil.pushResult(
                                  context, RichRouter.withdraw + "?type=0",
                                  (res) {
                                model.initData();
                                setState(() {});
                              });
                            },
                            child: Row(
                              children: <Widget>[
                                Image.asset('assets/images/rich/icon_ti.png',
                                    width: 36.w, height: 36.w),
                                Padding(
                                  padding: EdgeInsets.only(left: 18.w),
                                  child: Text(
                                    "提币",
                                    style: Styles.theme(
                                        fontSize: 28.sp,
                                        color: Styles.colorB1C6EA,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              NavigatorUtil.pushResult(
                                  context, RichRouter.transfer + "?type=0",
                                  (res) {
                                model.initData();
                                setState(() {});
                              });
                            },
                            child: Row(
                              children: <Widget>[
                                Image.asset('assets/images/rich/icon_zhuan.png',
                                    width: 36.w, height: 36.w),
                                Padding(
                                  padding: EdgeInsets.only(left: 18.w),
                                  child: Text(
                                    "转账",
                                    style: Styles.theme(
                                        fontSize: 28.sp,
                                        color: Styles.colorB1C6EA,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 8.h,
                width: 750.w,
                color: Styles.color2C3448,
              ),
              Container(
                height: 354.h,
                margin: EdgeInsets.only(left: 32.w, right: 33.w),
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        NavigatorUtil.push(
                            context, RichRouter.flow + "?type=1&name=Fil");
                      },
                      child: Container(
                        height: 100.h,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Styles.color2B3448, width: 1.w))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Image.asset('assets/images/rich/filcoin.png',
                                    width: 36.w, height: 36.w),
                                Padding(
                                  padding: EdgeInsets.only(left: 18.w),
                                  child: Text(
                                    "Fil",
                                    style: Styles.theme(
                                        fontSize: 32.sp,
                                        color: Styles.colorWhite,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                            Image.asset('assets/images/rich/more.png',
                                width: 14.w, height: 24.w),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 140.h,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Styles.color2B3448, width: 1.w))),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 140.h,
                            width: 228.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("可用",
                                    style: Styles.theme(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 26.sp,
                                        color: Styles.colorWhite)),
                                Text(model.filAvailable,
                                    style: Styles.theme(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 26.sp,
                                        color: Styles.colorWhite)),
                              ],
                            ),
                          ),
                          Container(
                            height: 140.h,
                            width: 228.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("冻结",
                                    style: Styles.theme(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 26.sp,
                                        color: Styles.colorWhite)),
                                Text(model.filFreeze,
                                    style: Styles.theme(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 26.sp,
                                        color: Styles.colorWhite)),
                              ],
                            ),
                          ),
                          Container(
                            height: 140.h,
                            width: 228.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("折合(CNY)",
                                    style: Styles.theme(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 26.sp,
                                        color: Styles.colorWhite)),
                                Text(model.filCny,
                                    style: Styles.theme(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 26.sp,
                                        color: Styles.colorWhite)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 112.h,
                      margin: EdgeInsets.only(left: 32.w, right: 33.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  ToastUtil.openToast("功能待开放");
//                                              NavigatorUtil.push(
//                                                  context, RichRouter.recharge+"?token="+model.walletToken);
                                },
                                child: Image.asset(
                                    'assets/images/rich/icon_chong.png',
                                    width: 36.w,
                                    height: 36.w),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 18.w),
                                child: Text(
                                  "充币",
                                  style: Styles.theme(
                                      fontSize: 28.sp,
                                      color: Styles.colorB1C6EA,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              ToastUtil.openToast("功能待开放");
//                              NavigatorUtil.pushResult(
//                                  context, RichRouter.withdraw + "?type=1",
//                                  (res) {
//                                model.initData();
//                                setState(() {});
//                              });
                            },
                            child: Row(
                              children: <Widget>[
                                Image.asset('assets/images/rich/icon_ti.png',
                                    width: 36.w, height: 36.w),
                                Padding(
                                  padding: EdgeInsets.only(left: 18.w),
                                  child: Text(
                                    "提币",
                                    style: Styles.theme(
                                        fontSize: 28.sp,
                                        color: Styles.colorB1C6EA,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              ToastUtil.openToast("功能待开放");
//                              NavigatorUtil.pushResult(
//                                  context, RichRouter.transfer + "?type=1",
//                                  (res) {
//                                model.initData();
//                                setState(() {});
//                              });
                            },
                            child: Row(
                              children: <Widget>[
                                Image.asset('assets/images/rich/icon_zhuan.png',
                                    width: 36.w, height: 36.w),
                                Padding(
                                  padding: EdgeInsets.only(left: 18.w),
                                  child: Text(
                                    "转账",
                                    style: Styles.theme(
                                        fontSize: 28.sp,
                                        color: Styles.colorB1C6EA,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}

class BarCodeWidget extends StatefulWidget {
  final String username;

  const BarCodeWidget({Key key, this.username}) : super(key: key);

  @override
  _BarCodeWidgetState createState() => _BarCodeWidgetState();
}

class _BarCodeWidgetState extends State<BarCodeWidget> {
  var selected = 0;
  String title = "USDT";

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          alignment: Alignment.center,
          child: Container(
            width: 538.w,
            height: 700.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.w)),
                color: Styles.colorWhite),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 85.h,
                  left: 132.w,
                  child: Container(
                      child: Text(
                    "内部转账收款码",
                    //"我的" + title + "收款码",
                    style: Styles.theme(
                        fontSize: 36.ssp,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue),
                  )),
                ),
                Positioned(
                  top: 165.h,
                  left: 71.w,
                  right: 71.w,
                  child: Container(
                    height: 396.w,
                    width: 396.w,
                    margin: EdgeInsets.only(top: 30.h),
                    child: new QrImage(
                      data: title + "|" + widget.username,
                      size: 396.w,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 98.h,
                    margin: EdgeInsets.only(top: 80.h),
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            selected = 0;
                            title = "USDT";
                            setState(() {});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    top: selected == 0
                                        ? BorderSide(
                                            color: Styles.color498FEA,
                                            width: 4.h)
                                        : BorderSide(
                                            color: Styles.colorE5E5E5,
                                            width: 1.h))),
                            height: 98.h,
                            width: 268.w,
                            alignment: Alignment.center,
                            child: Text(
                              "USDT收款",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: selected == 0
                                      ? Styles.colorEF5555
                                      : Styles.color999999,
                                  fontSize: 28.ssp),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            selected = 1;
                            title = "Fil";
                            setState(() {});
                          },
                          child: Container(
                            height: 98.h,
                            width: 268.w,
                            decoration: BoxDecoration(
                                border: Border(
                                    top: selected == 1
                                        ? BorderSide(
                                            color: Styles.color498FEA,
                                            width: 4.h)
                                        : BorderSide(
                                            color: Styles.colorE5E5E5,
                                            width: 1.h))),
                            alignment: Alignment.center,
                            child: Text(
                              'Fil收款码',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: selected == 1
                                      ? Styles.colorEF5555
                                      : Styles.color999999,
                                  fontSize: 28.ssp),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
