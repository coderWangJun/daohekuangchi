import 'dart:async';

import 'package:dh/common/constants.dart';
import 'package:dh/http/index.dart';
import 'package:dh/provider/provider_widget.dart';
import 'package:dh/res/styles.dart';
import 'package:dh/routers/fluro_navigator.dart';
import 'package:dh/routers/module/rich_router.dart';
import 'package:dh/ui/widgets/alert.dart';
import 'package:dh/ui/widgets/custom_app_bar.dart';
import 'package:dh/ui/widgets/custom_button.dart';
import 'package:dh/view_model/transfer_view_model.dart';
import 'package:flutter/material.dart';
import 'package:dh/utils/index.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class TransferPage extends StatefulWidget {
  final String other;
  final int transferType;

  const TransferPage({Key key, this.other, this.transferType})
      : super(key: key);

  @override
  _TransferPageState createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  TextEditingController otherController = TextEditingController();
  TextEditingController numController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController vcodeController = TextEditingController();
  FocusNode numNode = FocusNode();
  FocusNode addrNode = FocusNode();
  FocusNode vcodeNode = FocusNode();
  FocusNode passwordNode = FocusNode();

  String title = "USDT";

  bool _isClick = true;

  /// 倒计时秒数
  final int _second = 60;

  /// 当前秒数
  int _currentSecond;
  StreamSubscription _subscription;

  Future _getVCode(TransferViewModel model) async {
    ResultData res = await model.sendSms("1", model.phone);
    if (res != null && res.code == Constants.successCode) {
      setState(() {
        _currentSecond = _second;
        _isClick = false;
      });
      _subscription = Stream.periodic(Duration(seconds: 1), (i) => i)
          .take(_second)
          .listen((i) {
        setState(() {
          _currentSecond = _second - i - 1;
          _isClick = _currentSecond < 1;
        });
      });
    }
  }

  int transferType = 0;

  @override
  void dispose() {
    _subscription?.cancel();
    passwordController.dispose();
    otherController.dispose();
    numController.dispose();
    vcodeController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.other != null && widget.other.isNotEmpty) {
      otherController.text = widget.other;

    }
    if (widget.transferType != null) {
      transferType = widget.transferType;
      title = transferType == 0 ? "USDT" : "Fil";

    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        backgroundColor: Styles.color161D30,
        isBack: true,
        centerTitle: "转账",
        actionName: "转账记录",
        onPressed: () {
          NavigatorUtil.push(
              context,
              RichRouter.transferRecord +
                  "?type=" +
                  transferType.toString() +
                  "&name=" +
                  title);
        },
        onBack: (){
          NavigatorUtil.popResult(context, "refresh");
        },
      ),
      body: ProviderWidget<TransferViewModel>(
        model: TransferViewModel(transferType),
        onModelReady: (model) {
          model.init(transferType);
        },
        builder: (ctx, model, child) {
          return Container(
            //margin: EdgeInsets.only(left: 34.w, right: 32.w),
            decoration: BoxDecoration(color: Styles.colorBackgroundColor),
            child: ListView(
              padding: EdgeInsets.only(left: 34.w, right: 32.w),
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
                                transferType == 0
                                    ? 'assets/images/rich/USDT.png'
                                    : 'assets/images/rich/filcoin.png',
                                width: 36.w,
                                height: 36.w),
                            Padding(
                              padding: EdgeInsets.only(left: 10.w),
                              child: Text(
                                title,
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
                              this.transferType =
                                  this.transferType == 0 ? 1 : 0;
                              title = this.title == "USDT" ? "Fil" : "USDT";
                              model.init(this.transferType);
                              numController.text = "";
                              passwordController.text = "";
                              otherController.text = "";
                              setState(() {});
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  "切换币种",
                                  style: Styles.theme(
                                      color: Styles.colorB1C6EA,
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10.w),
                                  child: Image.asset(
                                      'assets/images/rich/more.png',
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
                  height: 88.h,
                  margin: EdgeInsets.only(top: 20.h, bottom: 30.h),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Styles.colorF4F4F4, width: 1.w))),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: <Widget>[
                      Text("可转账的" + title + "：",
                          style: Styles.theme(
                              fontSize: 28.sp, color: Styles.colorWhite)),
                      Padding(
                        padding: EdgeInsets.only(left: 15.w),
                        child: Text(model.avail,
                            style: Styles.theme(
                                fontSize: 36.sp,
                                color: Styles.colorFFD454,
                                fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Text("对方账号",
                      style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w400,
                          color: Styles.colorWhite)),
                  height: 56.h,
                  margin: EdgeInsets.only(top: 48.h),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Styles.colorF4F4F4, width: 2.h))),
                  child: TextFormField(
                      focusNode: addrNode,
                      textAlign: TextAlign.start,
                      controller: otherController,
                      onChanged: (text) {
                        //onChanged(text);
                      },
                      decoration: InputDecoration(
                        hintText: "请输入对方账号",
                        hintStyle: Styles.theme(
                            color: Styles.color999999, fontSize: 32.sp),
                        border: InputBorder.none, //去掉下划线
                        //hintStyle: TextStyles.textGrayC14
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(top: 60.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("转账" + title + "数量",
                          style: TextStyle(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w400,
                              color: Styles.colorWhite)),
                      Row(
                        children: <Widget>[
                          Text("手续费" + model.fee + title,
                              style: TextStyle(
                                  fontSize: 28.sp, color: Styles.colorFFD454)),
                        ],
                      )
                    ],
                  ),
                  height: 56.h,
                ),
                Container(
                    height: 88.h,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Styles.color2B3448, width: 2.h))),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                            child: TextFormField(
                                focusNode: numNode,
                                textAlign: TextAlign.start,
                                controller: numController,
                                inputFormatters: [
                                  WhitelistingTextInputFormatter.digitsOnly
                                ],
                                onChanged: (text) {
                                  //onChanged(text);
                                },
                                decoration: InputDecoration(
                                  hintText: "请输入转账数量",
                                  hintStyle: Styles.theme(
                                      color: Styles.color999999,
                                      fontSize: 32.sp),
                                  border: InputBorder.none, //去掉下划线
                                  //hintStyle: TextStyles.textGrayC14
                                ))),
                        Container(
                          width: 180.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "|",
                                style: Styles.theme(
                                    fontWeight: FontWeight.w400,
                                    color: Styles.color5591EF,
                                    fontSize: 28.ssp),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    numController.text = model.avail;
                                  });
                                },
                                child: Text(
                                  "全部转账",
                                  style: Styles.theme(
                                      fontWeight: FontWeight.w400,
                                      color: Styles.colorB1C6EA,
                                      fontSize: 28.ssp),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )),
                Container(
                  margin: EdgeInsets.only(top: 30.h),
                  child: Text("资金密码",
                      style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w400,
                          color: Styles.colorWhite)),
                  height: 56.h,
                ),
                Container(
                  height: 88.h,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Styles.color2B3448, width: 2.h))),
                  child: TextFormField(
                      focusNode: passwordNode,
                      textAlign: TextAlign.start,
                      controller: passwordController,
                      obscureText: true,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      onChanged: (text) {
                        //onChanged(text);
                      },
                      decoration: InputDecoration(
                        hintText: "请输入资金密码",
                        hintStyle: Styles.theme(
                            color: Styles.color999999, fontSize: 32.sp),
                        border: InputBorder.none, //去掉下划线
                        //hintStyle: TextStyles.textGrayC14
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30.h),
                  child: Text("验证码",
                      style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w400,
                          color: Styles.colorWhite)),
                  height: 56.h,
                ),
                Container(
                    height: 88.h,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Styles.color2B3448, width: 2.h))),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                            child: TextFormField(
                                focusNode: vcodeNode,
                                textAlign: TextAlign.start,
                                controller: vcodeController,
                                inputFormatters: [
                                  WhitelistingTextInputFormatter.digitsOnly
                                ],
                                onChanged: (text) {
                                  //onChanged(text);
                                },
                                decoration: InputDecoration(
                                  hintText: "请输入验证码",
                                  hintStyle: Styles.theme(
                                      color: Styles.color999999,
                                      fontSize: 32.sp),
                                  border: InputBorder.none, //去掉下划线
                                  //hintStyle: TextStyles.textGrayC14
                                ))),
                        Container(
                          width: 180.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "|",
                                style: Styles.theme(
                                    fontWeight: FontWeight.w400,
                                    color: Styles.colorB1C6EA,
                                    fontSize: 28.ssp),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (_isClick) _getVCode(model);
                                },
                                child: Text(
                                  _isClick ? '获取验证码' : '$_currentSecond 秒',
                                  style: Styles.theme(
                                      fontWeight: FontWeight.w400,
                                      color: _isClick
                                          ? Styles.colorB1C6EA
                                          : Styles.color999999,
                                      fontSize: 28.ssp),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )),
                Container(
                  padding: EdgeInsets.only(top: 90.h),
                  child: CustomButton(
                    "立即转账",
                    width: 686.w,
                    height: 98.h,
                    radius: 49.w,
                    fontSize: 32.ssp,
                    busy: model.busy,
                    onPressed: () async {
                      if (otherController.text.isEmpty) {
                        ToastUtil.openToast("请输入对方账号");
                        return;
                      }
                      if (numController.text.isEmpty) {
                        ToastUtil.openToast("请输入转账数量");
                        return;
                      }
                      if (passwordController.text.isEmpty) {
                        ToastUtil.openToast("请输入资金密码");
                        return;
                      }
                      if (vcodeController.text.isEmpty) {
                        ToastUtil.openToast("请输入验证码");
                        return;
                      }
                      Alert.show(context,
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(bottom: 30.h),
                                  child: Text("温馨提示",
                                      style: TextStyle(
                                          fontSize: 32.sp,
                                          color: Colors.white)),
                                ),
                                Text(
                                  "确定向账号 " + otherController.text,
                                  style: Styles.theme(
                                      fontSize: 32.ssp,
                                      fontWeight: FontWeight.w400,
                                      color: Styles.colorWhite),
                                ),
                                Text(
                                  "转账 " + numController.text + title + " 吗？",
                                  style: Styles.theme(
                                      fontSize: 32.ssp,
                                      fontWeight: FontWeight.w400,
                                      color: Styles.colorWhite),
                                )
                              ],
                            ),
                          ),
                          isCancel: true, onOk: () async {
                        ResultData res = await model.transfer(
                            otherController.text,
                            numController.text,
                            passwordController.text,
                            vcodeController.text);
                        if (res.code == Constants.successCode) {
                          Alert.show(context, content: res.message, onOk: () {
                            otherController.text = "";
                            numController.text = "";
                            passwordController.text = "";
                            vcodeController.text = "";
                            model.init(transferType);
                          });
                        } else {
                          Alert.show(context,
                              content: res.message, isSuccess: false);
                        }
                      });
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 90.h, bottom: 90.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 20.h),
                        child: Text("温馨提示:", style: TextStyle(
          fontSize: 24.sp, color: Styles.color9A9A9A)),
                      ),
                      HtmlWidget(
                        model.note,
                        webView: true,
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

//  List<Widget> _buildNote(TransferViewModel model) {
//    List<Widget> list = new List();
//
//    list.add(
//      Text(
//        "温馨提示",
//        style: Styles.theme(color: Styles.color999999, fontSize: 24.sp),
//      ),
//    );
//    model.noteList.forEach((element) {
//      list.add(
//        Container(
//          margin: EdgeInsets.only(bottom: 5.h, top: 5.h),
//          child: Text(element,
//              style: Styles.theme(color: Styles.color999999, fontSize: 24.sp)),
//        ),
//      );
//    });
//    return list;
//  }
}
