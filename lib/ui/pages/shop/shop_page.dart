import 'package:dh/routers/fluro_navigator.dart';
import 'package:dh/routers/module/me_router.dart';
import 'package:flutter/material.dart';
import 'package:dh/utils/index.dart';
import 'package:dh/ui/pages/shop/shop_list_page.dart';
import 'package:flutter/widgets.dart';
import 'package:dh/res/styles.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage>
    with SingleTickerProviderStateMixin {
  int current = 1;
  int currentType = 1;
  var isPageCanChanged = true;
  PageController mPageController;

  double padding = 0;
  ScrollController _recordScrollController;

  @override
  void initState() {
    super.initState();

    mPageController = PageController(initialPage: 0);
    _recordScrollController = new ScrollController();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _recordScrollController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
        child: Container(
          color: Styles.colorBackgroundColor,
          child: Column(
            children: <Widget>[
              Container(
                width: 750.w,
                height: 332.h,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/images/shop/topbg.png",
                        ),
                        fit: BoxFit.cover)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 750.w,
                      height: 88.h,
                      child: Stack(
                        children: <Widget>[
                          Container(
padding: EdgeInsets.only(top: 20.h),
                            alignment: Alignment.topCenter,
                            child: Text("云算力",
                                style: TextStyle(
                                    fontSize: 36.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Positioned(
                              top: 28.h,
                              right: 32.w,
                              child: InkWell(
                                onTap: () {
                                  NavigatorUtil.push(
                                      context, MeRouter.products);
                                },
                                child: Text(
                                  '订单详情',
                                  style: TextStyle(
                                      color: Styles.colorFFFFFF,
                                      fontSize: 28.sp),
                                ),
                              ))
                        ],
                      ),
                    ),
                    Container(
                        width: 750.w,
                        padding: EdgeInsets.only(left: 66.w),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(top: 58.h,bottom: 24.h),
                                  child: Text(
                                    "IPFS-Filecoin",
                                    style: TextStyle(
                                        fontSize: 36.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Styles.colorFFFFFF),
                                  )),
                              Text(
                                "炒币不如囤币，囤币不如挖矿",
                                style: TextStyle(
                                    fontSize: 32.sp, color: Colors.white),
                              )
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                height: 112.h,
                decoration: BoxDecoration(
                    color: Styles.colorBackgroundColor,
                    image: DecorationImage(
                        image:
                        AssetImage('assets/images/shop/topbg_b.png'),
                        alignment: Alignment.topLeft,
                        fit: BoxFit.contain)),
                child: Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Positioned(
                      left: 32.w,
//                            top: 30.h,
                      child: Container(
                        width: 686.w,
                        height: 112.h,
                        padding: EdgeInsets.only(left: 33.w),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            color: Styles.color1E2638,
                            borderRadius:
                            BorderRadius.all(Radius.circular(20.w))),
                        child: Text(
                          '道和矿池-简单、安全、稳定、专业',
                          style: TextStyle(color: Styles.colorFFFFFF),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //云算力内容
              Container(
                height: 750.h,
                width: 750.w,
                margin: EdgeInsets.only(top: 50.h),
                color: Styles.colorBackgroundColor,
                child: ShopListPage(index: "1"),
              ),
            ],
          ),
        ));
  }
}
