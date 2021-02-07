import 'package:barcode_scan/barcode_scan.dart';
import 'package:dh/common/constants.dart';
import 'package:dh/provider/provider_widget.dart';
import 'package:dh/res/styles.dart';
import 'package:dh/routers/fluro_navigator.dart';
import 'package:dh/routers/module/me_router.dart';
import 'package:dh/routers/module/rich_router.dart';
import 'package:dh/ui/widgets/custom_button.dart';
import 'package:dh/ui/widgets/custom_load_image.dart';
import 'package:dh/view_model/app_view_model.dart';
import 'package:dh/view_model/rich_view_model.dart';
import 'package:flutter/material.dart';
import 'package:dh/utils/index.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:async';

import 'package:sticky_headers/sticky_headers.dart';

class AppPage extends StatefulWidget {
  @override
  _RichPageState createState() => _RichPageState();
}

class _RichPageState extends State<AppPage> {
  RichViewModel _viewModel;

  bool showMoney = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<AppViewModel>(
      model: AppViewModel(),
      onModelReady: (model) {},
      builder: (ctx, model, child) {
        return NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Styles.color00C6BE,
                automaticallyImplyLeading: false,
                expandedHeight: 320.h,
                centerTitle: true,
                title: Text(
                  "应用",
                  style: Styles.theme(
                      color: Styles.colorWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 36.ssp),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: Container(
                    width: 750.w,
                    height: 360.h,
                    decoration: model.hasBackground
                        ? BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  "assets/images/mine/head_bg.png",
                                ),
                                fit: BoxFit.cover))
                        : BoxDecoration(
                            color: Styles.color00C6BE,
                          ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 176.h, left: 64.w),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "道和天下",
                            style: Styles.theme(
                                fontSize: 48.sp,
                                color: Styles.colorWhite,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 64.w, top: 36.h),
                          alignment: Alignment.centerLeft,
                          height: 48.h,
                          child: Text(
                            "打造应用生态，助力IPFS-Filecoin发展",
                            style: Styles.theme(
                                fontSize: 32.sp, color: Styles.colorWhite),
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
            alignment: Alignment.center,
            child: ListView(
                padding: EdgeInsets.only(left: 32.w, right: 32.w, top: 64.w),
                children: <Widget>[
                  Container(
                    height: 258.h,
                    width: 686.w,
                    decoration: BoxDecoration(
                        color: Styles.color1E2638,
                        borderRadius: BorderRadius.all(Radius.circular(10.w))),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 120.h,
                          padding: EdgeInsets.only(left: 32.w),
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                "assets/images/common/icon_diamon.png",
                                width: 80.w,
                                height: 80.w,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 23.w),
                                child: Text(
                                  "量化理财",
                                  style: Styles.theme(
                                    fontSize: 32.sp,
                                    color: Styles.colorWhite,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 138.h,
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.only(
                            left: 32.w,
                            right: 32.w,
                            top: 10.h
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                height: 76.h,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        "穿越牛熊",
                                        style: Styles.theme(
                                          fontSize: 28.sp,
                                          color: Styles.colorWhite,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "让您的资产持续增值",
                                        style: Styles.theme(
                                          fontSize: 28.sp,
                                          color: Styles.colorWhite,
                                        ),
                                      ),
                                    )
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                ),
                              ),
                              Container(
                                height: 80.h,
                                child: CustomButton(
                                  "立即前往",
                                  width: 180.w,
                                  //height: 85.h,
                                  radius: 6.w,
                                  fontSize: 32.sp,
                                  onPressed: () {
                                    ToastUtil.openToast("功能暂未开放");
                                  },
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 258.h,
                    width: 686.w,
                    margin: EdgeInsets.only(top: 40.h),
                    decoration: BoxDecoration(
                        color: Styles.color1E2638,
                        borderRadius: BorderRadius.all(Radius.circular(10.w))),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 120.h,
                          padding: EdgeInsets.only(left: 32.w),
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                "assets/images/common/icon_zhiya.png",
                                width: 80.w,
                                height: 80.w,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 23.w),
                                child: Text(
                                  "质押借贷",
                                  style: Styles.theme(
                                    fontSize: 32.sp,
                                    color: Styles.colorWhite,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 138.h,
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.only(
                            left: 32.w,
                            right: 32.w,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                height: 85.h,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        "轻松抵押资产借贷",
                                        style: Styles.theme(
                                          fontSize: 28.sp,
                                          color: Styles.colorWhite,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "保持抵押资产的增值机会",
                                        style: Styles.theme(
                                          fontSize: 28.sp,
                                          color: Styles.colorWhite,
                                        ),
                                      ),
                                    )
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                ),
                              ),
                              Container(
                                height: 80.h,
                                child: CustomButton(
                                  "立即前往",
                                  width: 180.w,
                                  height: 85.h,
                                  radius: 6.w,
                                  fontSize: 32.sp,
                                  onPressed: () {
                                    ToastUtil.openToast("功能暂未开放");
                                  },
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 258.h,
                    width: 686.w,
                    margin: EdgeInsets.only(top: 40.h),
                    decoration: BoxDecoration(
                        color: Styles.color1E2638,
                        borderRadius: BorderRadius.all(Radius.circular(10.w))),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 120.h,
                          padding: EdgeInsets.only(left: 32.w),
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                "assets/images/common/icon_shop.png",
                                width: 80.w,
                                height: 80.w,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 23.w),
                                child: Text(
                                  "商城支付",
                                  style: Styles.theme(
                                    fontSize: 32.sp,
                                    color: Styles.colorWhite,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 138.h,
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.only(
                            left: 32.w,
                            right: 32.w,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                height: 85.h,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        "让资产在流通中",
                                        style: Styles.theme(
                                          fontSize: 28.sp,
                                          color: Styles.colorWhite,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "产生价值的最大化",
                                        style: Styles.theme(
                                          fontSize: 28.sp,
                                          color: Styles.colorWhite,
                                        ),
                                      ),
                                    )
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                ),
                              ),

                              Container(
                                height: 80.h,
                                child: CustomButton(
                                  "立即前往",
                                  width: 180.w,
                                  height: 72.h,
                                  radius: 6.w,
                                  fontSize: 32.sp,
                                  onPressed: () {
                                    ToastUtil.openToast("功能暂未开放");
                                  },
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ]),
          ),
        );
      },
    );
  }
}
