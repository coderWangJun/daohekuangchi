import 'dart:typed_data';

import 'package:dh/provider/provider_widget.dart';
import 'package:dh/routers/fluro_navigator.dart';
import 'package:dh/ui/widgets/custom_app_bar.dart';
import 'package:dh/view_model/mine_invite_view_model.dart';
import 'package:flutter/material.dart';
import 'package:dh/utils/index.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui' as ui;

class InvitePage extends StatelessWidget {
  GlobalKey _globalKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: "邀请好友",
        isBack: true,
        backgroundColor: Color(0xff161E30),
      ),
      body: ProviderWidget<MineInviteViewModel>(
        model: MineInviteViewModel(),
        onModelReady: (model) {
          model.initData().then((res) {
            if (res.code == "0002") {
              ToastUtil.openToast(res.message);
              NavigatorUtil.pop(context);
            }
          });
        },
        builder: (ctx, model, child) {
          return RepaintBoundary(
            key: _globalKey,
            child: Container(
              width: 750.w,
              height: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/mine/yqhaibao_bg.png"),
                      fit: BoxFit.fill)),
              child: Stack(
                children: <Widget>[
                  Container(
                    width: 750.w,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/images/mine/yqhaibao_bg.png"),
                            fit: BoxFit.fill)),
                  ),
                  Positioned(
                    bottom: 208.h,
                    left: 238.w,
                    child: Container(
                      width: 180.w,
                      height: 180.w,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.w)),
                      child: new QrImage(
                        backgroundColor: Colors.white,
                        data: model.url,
                        size: 180.w,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 450.w,
                    bottom: 250.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("欢迎注册",
                            style: TextStyle(fontSize: 28.sp, color: Colors.white)),
                        Text("加入道和矿池",
                            style: TextStyle(fontSize: 28.sp, color: Colors.white)),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 60.h,
                    child: Container(
                      width: 750.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            width: 280.w,
                            height: 80.h,
                            decoration: BoxDecoration(
                                color: Color(0xff4D97F7),
                                borderRadius: BorderRadius.circular(10.w)),
                            child: FlatButton(
                              onPressed: () async {
                                if (Platform.isIOS) {
                                  _saveInvite();
                                } else {
                                  await handlePhotosPermission();
                                  _saveInvite();
                                }
                              },
                              child: Text(
                                "保存海报至相册",
                                style: TextStyle(
                                    fontSize: 28.sp, color: Colors.white),
                              ),
                            ),
                          ),
                          Container(
                            width: 280.w,
                            height: 80.h,
                            decoration: BoxDecoration(
                                color: Color(0xff4D97F7),
                                borderRadius: BorderRadius.circular(10.w)),
                            child: FlatButton(
                              onPressed: () async {
                                ClipboardData data = new ClipboardData(
                                    text: model.url);
                                Clipboard.setData(data);
                                ToastUtil.openToast('复制成功');
                              },
                              child: Text(
                                "复制邀请链接",
                                style: TextStyle(
                                    fontSize: 28.sp, color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ),
                ],
              ),
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

  _saveInvite() async {
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
