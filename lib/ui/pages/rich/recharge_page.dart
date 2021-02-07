import 'dart:typed_data';

import 'package:dh/provider/provider_widget.dart';
import 'package:dh/res/styles.dart';
import 'package:dh/routers/fluro_navigator.dart';
import 'package:dh/routers/module/rich_router.dart';
import 'package:dh/ui/widgets/custom_app_bar.dart';
import 'package:dh/view_model/recharge_view_model.dart';
import 'package:flutter/material.dart';
import 'package:dh/utils/index.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui' as ui;

class RechargePage extends StatefulWidget {
  final String token;

  const RechargePage({Key key, this.token}) : super(key: key);

  @override
  _RechargePageState createState() => _RechargePageState();
}

class _RechargePageState extends State<RechargePage> {
  //充值类型
  int rechargeType = 0;
  String name = "USDT";
  GlobalKey _globalKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.colorBackgroundColor,
      appBar: CustomAppBar(
        backgroundColor: Styles.colorBackgroundColor,
        isBack: true,
        centerTitle: "充值",
        actionName: "充值记录",
        onPressed: () {
          NavigatorUtil.push(
              context,
              RichRouter.rechargeRecord +
                  "?type=" +
                  rechargeType.toString() +
                  "&name=" +
                  name);
        },
        onBack: (){
          NavigatorUtil.popResult(context, "refresh");
        },
      ),
      body: ProviderWidget<RechargeViewModel>(
        model: RechargeViewModel(),
        onModelReady: (model) {
          model.initData();
        },
        builder: (ctx, model, child) {
          return Container(
            margin: EdgeInsets.only(left: 34.w, right: 32.w),
            child: ListView(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: Styles.color2B3448, width: 2.h),
                          top: BorderSide(
                              color: Styles.color2B3448, width: 2.h))),
                  height: 88.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 342.w,
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                                rechargeType == 0
                                    ? 'assets/images/rich/USDT.png'
                                    : 'assets/images/rich/filcoin.png',
                                width: 36.w,
                                height: 36.w),
                            Padding(
                              padding: EdgeInsets.only(left: 10.w),
                              child: Text(
                                rechargeType == 0 ? "USDT(ERC20)" : "Fil",
                                style: Styles.theme(
                                    color: Styles.colorWhite,
                                    fontSize: 32.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                          width: 342.w,
                          child: GestureDetector(
                            onTap: () {
                              this.rechargeType =
                                  this.rechargeType == 0 ? 1 : 0;
                              name = this.name == "USDT" ? "Fil" : "USDT";
                              setState(() {});
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  "切换币种",
                                  style: Styles.theme(
                                      color: Styles.colorB2C6EA,
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10.w),
                                  child: Image.asset(
                                      'assets/images/rich/more_s.png',
                                      width: 14.w,
                                      height: 24.w),
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text("扫描二维码获取充币地址",
                      style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w500,
                          color: Styles.colorWhite)),
                  height: 56.h,
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 56.h),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Styles.colorECECEC,
                    ),
                    child: RepaintBoundary(
                      //生成二维码，并将二维码包裹在RepaintBoundary插件中
                      //截图插件
                      key: _globalKey,
                      child: new QrImage(
                        backgroundColor: Styles.colorWhite,
                        foregroundColor: Styles.colorBlack,
                        data: widget.token,
                        size: 384.w,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 195.w, right: 195.w, top: 35.h),
                  width: 360.w,
                  height: 88.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Styles.color161E30,
                      border: Border.all(color: Styles.color4A90EA),
                      borderRadius: BorderRadius.all(Radius.circular(10.w))),
                  child: GestureDetector(
                    onTap: () async {
                      if (Platform.isIOS) {
                        _saveAddressImage();
                      } else {
                        await handlePhotosPermission();
                        _saveAddressImage();
                      }
                    },
                    child: Text(
                      "保存二维码至相册",
                      style: Styles.theme(
                          color: Styles.color73AAFF, fontSize: 28.ssp),
                    ),
                  ),
                ),
                Container(
                  height: 250.h,
                  margin: EdgeInsets.only(top: 22.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "充币地址",
                        style: Styles.theme(
                            fontWeight: FontWeight.w500,
                            color: Styles.colorB2C6EA,
                            fontSize: 28.ssp),
                      ),
                      Container(
                        width: 400.w,
                        alignment: Alignment.center,
                        child: Text(
                          widget.token,
                          style: Styles.theme(
                              fontWeight: FontWeight.w400,
                              color: Styles.color999999,
                              fontSize: 28.ssp),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 195.w, right: 195.w, top: 35.h),
                        width: 360.w,
                        height: 88.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Styles.color161E30,
                            border: Border.all(color: Styles.color4A90EA),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.w))),
                        child: GestureDetector(
                          onTap: () {
                            ClipboardData data =
                                new ClipboardData(text: widget.token);
                            Clipboard.setData(data);
                            ToastUtil.openToast('链接已复制');
                          },
                          child: Text(
                            "复制地址",
                            style: Styles.theme(
                                color: Styles.color73AAFF, fontSize: 28.ssp),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 64.h, bottom: 90.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 20.h),
                          child: Text("温馨提示:",
                              style: TextStyle(
                                  fontSize: 24.sp, color: Styles.color9A9A9A)),
                        ),
                        HtmlWidget(
                          model.note,
                          webView: true,
                        )
                      ],
                    ))
              ],
            ),
          );
        },
      ),
    );
  }

  /// 图片存储权限处理
  static Future<Null> handlePhotosPermission() async {
    // 判断是否有权限
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler().requestPermissions([PermissionGroup.camera]);
    Future<PermissionStatus> permission =
        PermissionHandler().checkPermissionStatus(PermissionGroup.photos);
    if (permission == PermissionStatus.denied) {
      // 无权限的话就显示设置页面
      bool isOpened = await PermissionHandler().openAppSettings();
      debugPrint('无权限');
    }
    PermissionHandler().requestPermissions(<PermissionGroup>[
      PermissionGroup.storage, // 在这里添加需要的权限
    ]);
  }

  _saveAddressImage() async {
    RenderRepaintBoundary boundary =
        _globalKey.currentContext.findRenderObject();
    var image = await boundary.toImage();
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    final result =
        await ImageGallerySaver.saveImage(Uint8List.fromList(pngBytes));
    if (result != null && result != "") {
      //返回路径
      String path = Uri.decodeComponent(result);
      ToastUtil.openToast("成功保存到$path");
    } else {
      ToastUtil.openToast("保存失败!");
    }
  }
}
