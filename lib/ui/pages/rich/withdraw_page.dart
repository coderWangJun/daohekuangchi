import 'dart:async';

import 'package:dh/common/constants.dart';
import 'package:dh/entity/address_item_entity.dart';
import 'package:dh/http/index.dart';
import 'package:dh/provider/provider_widget.dart';
import 'package:dh/res/styles.dart';
import 'package:dh/routers/fluro_navigator.dart';
import 'package:dh/routers/module/rich_router.dart';
import 'package:dh/ui/widgets/alert.dart';
import 'package:dh/ui/widgets/custom_app_bar.dart';
import 'package:dh/ui/widgets/custom_button.dart';
import 'package:dh/ui/widgets/custom_load_image.dart';
import 'package:dh/view_model/withdraw_view_model.dart';
import 'package:flutter/material.dart';
import 'package:dh/utils/index.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class WithdrawPage extends StatefulWidget {
  final int type;

  const WithdrawPage({Key key, this.type}) : super(key: key);

  @override
  _WithdrawPageState createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  TextEditingController addrController = TextEditingController();
  TextEditingController numController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController vcodeController = TextEditingController();
  TextEditingController googleController = TextEditingController();
  FocusNode numNode = FocusNode();
  FocusNode addrNode = FocusNode();
  FocusNode vcodeNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode googleNode = FocusNode();

//提币类型
  int withdrawType = 0;

  String title = "USDT";

  bool _isClick = true;

  /// 倒计时秒数
  final int _second = 60;

  /// 当前秒数
  int _currentSecond;
  String addressId = "-1";
  StreamSubscription _subscription;

  Future _getVCode(WithdrawViewModel model) async {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.type != null) {
      withdrawType = widget.type;
      title = withdrawType == 0 ? "USDT" : "Fil";
      setState(() {

      });
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        backgroundColor: Styles.color161D30,
        isBack: true,
        centerTitle: "提币",
        actionName: "提取记录",
        onBack: (){
            NavigatorUtil.popResult(
                context, "refresh");
        },
        onPressed: () {
          NavigatorUtil.push(
              context,
              RichRouter.withdrawRecord +
                  "?type=" +
                  withdrawType.toString() +
                  "&name=" +
                  title);

        },
      ),
      body: ProviderWidget<WithdrawViewModel>(
        model: WithdrawViewModel(),
        onModelReady: (model) {
          model.initData(widget.type);
        },
        builder: (ctx, model, child) {
          return Container(
            decoration: BoxDecoration(color: Styles.colorBackgroundColor),
            child: ListView(
              padding: EdgeInsets.only(left: 34.w, right: 32.w),
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: Styles.color2B3448, width: 1.h),
                          top: BorderSide(
                              color: Styles.color2B3448, width: 1.h))),
                  height: 88.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 342.w,
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                                withdrawType == 0
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
                              this.withdrawType =
                                  this.withdrawType == 0 ? 1 : 0;
                              title = this.title == "USDT" ? "Fil" : "USDT";
                              model.initData(this.withdrawType);
                              numController.text = "";
                              passwordController.text = "";
                              addrController.text = "";
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
                  height: 88.h,
                  margin: EdgeInsets.only(top: 20.h, bottom: 30.h),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Styles.color2B3448, width: 1.w))),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: <Widget>[
                      Text("可提数量：",
                          style: Styles.theme(
                              fontSize: 28.sp, color: Styles.colorWhite)),
                      Padding(
                        padding: EdgeInsets.only(left: 15.w),
                        child: Text(model.avail,
                            style: Styles.theme(
                                fontWeight: FontWeight.bold,
                                fontSize: 36.sp,
                                color: Styles.colorFFD454)),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 48.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(title + "钱包地址",
                          style: TextStyle(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w400,
                              color: Styles.colorWhite)),
                      GestureDetector(
                        onTap: () {
                          NavigatorUtil.pushResult(
                              context,
                              RichRouter.address +
                                  "?type=" +
                                  withdrawType.toString(), (res) {
                            LogUtil.v(res);
                            AddressItemEntity t = (res as AddressItemEntity);
                            if (t.id == null) {
                              addrController.text = "";
                              addressId = "0";
                            } else {
                              addrController.text = t.address;
                              addressId = t.id;
                            }

                            setState(() {});
                          });
                        },
                        child: Row(
                          children: <Widget>[
                            Text("地址簿",
                                style: TextStyle(
                                    fontSize: 28.sp,
                                    color: Styles.colorB1C6EA)),
                            Padding(
                              padding: EdgeInsets.only(left: 15.w),
                              child: LoadAssetImage(
                                'rich/more_s.png',
                                width: 14.w,
                                height: 24.h,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  height: 56.h,
                ),
                Container(
                  padding: EdgeInsets.only(top: 0),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Styles.color2B3448, width: 2.h))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                            focusNode: addrNode,
                            textAlign: TextAlign.start,
                            controller: addrController,
                            onChanged: (text) {
                              //onChanged(text);
                            },
                            decoration: InputDecoration(
                              hintText: "请输入或粘贴钱包地址",
                              hintStyle: Styles.theme(
                                  color: Styles.color999999, fontSize: 32.sp),
                              border: InputBorder.none, //去掉下划线
                              //hintStyle: TextStyles.textGrayC14
                            )),
                      ),
//                      Container(
//                    width: 180.w,
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: <Widget>[
//                        Text(
//                          "|",
//                          style: Styles.theme(
//                              fontWeight: FontWeight.w400,
//                              color: Styles.color5591EF,
//                              fontSize: 28.ssp),
//                        ),
//                        GestureDetector(
//                          onTap: () async {
//                            ClipboardData data = await Clipboard.getData(
//                                Clipboard.kTextPlain);
//                            addrController.text = data.text;
//                          },
//                          child: Text(
//                            "粘贴钱包地址",
//                            style: Styles.theme(
//                                fontWeight: FontWeight.w400,
//                                color: Styles.color5591EF,
//                                fontSize: 28.ssp),
//                          ),
//                        )
//                      ],
//                    ),
//                  )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("提币数量",
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
                                  hintText: "请输入提取数量",
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
                                  "全部提取",
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
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      obscureText: true,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("手机验证码",
                          style: TextStyle(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w400,
                              color: Styles.colorWhite)),
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
                                  hintText: "请输入手机验证码",
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
                                  if (_isClick) _getVCode(model);
                                },
                                child: Text(
                                  _isClick ? '获取验证码' : '$_currentSecond s',
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
//                Container(
//                  margin: EdgeInsets.only(top: 30.h),
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: <Widget>[
//                      Text("谷歌验证码",
//                          style: TextStyle(
//                              fontSize: 28.sp,
//                              fontWeight: FontWeight.w500,
//                              color: Styles.colorBlack)),
//                    ],
//                  ),
//                  height: 40.h,
//                ),
//                Container(
//                    height: 88.h,
//                    decoration: BoxDecoration(
//                        border: Border(
//                            bottom: BorderSide(
//                                color: Styles.color2B3448, width: 2.h))),
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: <Widget>[
//                        Expanded(
//                          child: TextFormField(
//                              focusNode: googleNode,
//                              textAlign: TextAlign.start,
//                              controller: googleController,
//                              inputFormatters: [
//                                WhitelistingTextInputFormatter.digitsOnly
//                              ],
//                              onChanged: (text) {
//                                //onChanged(text);
//                              },
//                              decoration: InputDecoration(
//                                hintText: "请输入谷歌验证码",
//                                hintStyle: Styles.theme(
//                                    color: Styles.color999999, fontSize: 32.sp),
//                                border: InputBorder.none, //去掉下划线
//                                //hintStyle: TextStyles.textGrayC14
//                              )),
//                        ),
//                        Container(
//                          width: 180.w,
//                          child: Row(
//                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                            children: <Widget>[
//                              Text(
//                                "|",
//                                style: Styles.theme(
//                                    fontWeight: FontWeight.w400,
//                                    color: Styles.color5591EF,
//                                    fontSize: 28.ssp),
//                              ),
//                              GestureDetector(
//                                onTap: () async {
//                                  ClipboardData data = await Clipboard.getData(
//                                      Clipboard.kTextPlain);
//                                  googleController.text = data.text;
//                                },
//                                child: Text(
//                                  "粘贴验证码",
//                                  style: Styles.theme(
//                                      fontWeight: FontWeight.w400,
//                                      color: Styles.color5591EF,
//                                      fontSize: 28.ssp),
//                                ),
//                              )
//                            ],
//                          ),
//                        )
//                      ],
//                    )),
                Container(
                  padding: EdgeInsets.only(top: 90.h),
                  child: CustomButton(
                    "立即提取",
                    width: 686.w,
                    height: 98.h,
                    radius: 49.w,
                    fontSize: 32.ssp,
                    busy: model.busy,
                    onPressed: () async {
                      if (addrController.text.isEmpty) {
                        ToastUtil.openToast("钱包地址不能为空!");
                        return;
                      }
                      if (numController.text.isEmpty) {
                        ToastUtil.openToast("请输入提取数量!");
                        return;
                      }
                      if (passwordController.text.isEmpty) {
                        ToastUtil.openToast("请输入资金密码!");
                        return;
                      }
                      if (vcodeController.text.isEmpty) {
                        ToastUtil.openToast("请输入手机验证码!");
                        return;
                      }

                      ResultData res = await model.withdraw(
                          addrController.text,
                          numController.text,
                          passwordController.text,
                          vcodeController.text,
                          googleController.text);
                      if (res.code == Constants.successCode) {
                        Alert.show(context, content: res.message, onOk: () {
                          numController.text = "";
                          passwordController.text = "";
                          addrController.text = "";
                          vcodeController.text = "";
                          googleController.text = "";
                          model.initData(withdrawType);
                        });
                      } else {
                        Alert.show(context, content: res.message, onOk: () {});
                      }
                    },
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
                          child: Text("温馨提示:",  style: TextStyle(
                              fontSize: 24.sp, color: Styles.color9A9A9A) ),
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

//  List<Widget> _buildNote(WithdrawViewModel model) {
//    List<Widget> list = new List();
//
//    list.add(
//      Text(
//        "温馨提示",
//        style: Styles.theme(color: Styles.color999999, fontSize: 24.sp),
//      ),
//    );
//    int index = 1;
//    model.noteList.forEach((element) {
//      list.add(
//        Container(
//          margin: EdgeInsets.only(bottom: 5.h, top: 5.h),
//          child: Text(index.toString() + element,
//              style: Styles.theme(color: Styles.color999999, fontSize: 24.sp)),
//        ),
//      );
//      index++;
//    });
//    return list;
//  }
}
