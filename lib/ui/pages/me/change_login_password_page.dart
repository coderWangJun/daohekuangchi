import 'dart:async';

import 'package:dh/common/constants.dart';
import 'package:dh/http/result_data.dart';
import 'package:dh/provider/provider_widget.dart';
import 'package:dh/routers/fluro_navigator.dart';
import 'package:dh/routers/module/login_router.dart';
import 'package:dh/ui/widgets/custom_app_bar.dart';
import 'package:dh/ui/widgets/custom_button.dart';
import 'package:dh/view_model/collection_set_view_model.dart';
import 'package:flutter/material.dart';
import 'package:dh/utils/index.dart';

class ChangeLoginPasswordPage extends StatefulWidget {
  final String phone;

  const ChangeLoginPasswordPage({Key key, this.phone}) : super(key: key);

  @override
  _ChangeLoginPasswordPageState createState() =>
      _ChangeLoginPasswordPageState();
}

class _ChangeLoginPasswordPageState extends State<ChangeLoginPasswordPage> {
  TextEditingController _controller = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();
  FocusNode _focusNode = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  FocusNode _focusNode3 = FocusNode();
  FocusNode _focusNode4 = FocusNode();

  bool _isClick = true;

  /// 倒计时秒数
  final int _second = 60;

  /// 当前秒数
  int _currentSecond;
  StreamSubscription _subscription;

  Future _getVCode(CollectionSetViewModel model) async {
    ResultData res = await model.sendSms("1", widget.phone);
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff161D30),
      appBar: CustomAppBar(
        centerTitle: "重置登录密码",
        isBack: true,
        backgroundColor: Color(0xff161D30),
      ),
      body: SingleChildScrollView(
        child: Container(
            width: 750.w,
            padding: EdgeInsets.only(left: 32.w, right: 32.w),
            child: ProviderWidget<CollectionSetViewModel>(
              model: CollectionSetViewModel(),
              builder: (ctx, model, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 20.h, top: 30.h),
                            child: Text("当前登录密码",
                                style: TextStyle(
                                    fontSize: 28.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500)),
                          ),
                          Container(
                            width: 686.w,
                            padding: EdgeInsets.only(left: 20.w, right: 20.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.w),
                                border: Border.all(
                                    width: 1.h, color: Color(0xff2B3448))),
                            child: TextFormField(
                              controller: _controller,
                              focusNode: _focusNode,
                              textInputAction: TextInputAction.done,
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: "请输入当前登录密码",
                                  hintStyle: TextStyle(
                                      fontSize: 28.sp,
                                      color: Color(0xff999999)),
                                  border: InputBorder.none),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(bottom: 20.h, top: 30.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("新登录密码",
                                      style: TextStyle(
                                          fontSize: 28.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500)),
                                  Text("支持字母、数字，不可用空格，最少8位",
                                      style: TextStyle(
                                          fontSize: 24.sp,
                                          color: Color(0xffffffff)))
                                ],
                              )),
                          Container(
                            width: 686.w,
                            padding: EdgeInsets.only(left: 20.w, right: 20.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.w),
                                border: Border.all(
                                    width: 1.h, color: Color(0xff2B3448))),
                            child: TextFormField(
                              controller: _controller2,
                              focusNode: _focusNode2,
                              obscureText: true,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                  hintText: "请输入新登录密码",
                                  hintStyle: TextStyle(
                                      fontSize: 28.ssp,
                                      color: Color(0xff999999)),
                                  border: InputBorder.none),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(bottom: 20.h, top: 30.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("确认密码",
                                      style: TextStyle(
                                          fontSize: 28.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500)),
                                ],
                              )),
                          Container(
                            width: 686.w,
                            padding: EdgeInsets.only(left: 20.w, right: 20.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.w),
                                border: Border.all(
                                    width: 1.h, color: Color(0xff2B3448))),
                            child: TextFormField(
                              controller: _controller3,
                              focusNode: _focusNode3,
                              obscureText: true,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                  hintText: "请再次输入新登录密码",
                                  hintStyle: TextStyle(
                                      fontSize: 28.ssp,
                                      color: Color(0xff999999)),
                                  border: InputBorder.none),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 20.h, top: 30.h),
                            child: Text("短信验证码(${widget.phone})",
                                style: TextStyle(
                                    fontSize: 28.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500)),
                          ),
                          Container(
                              width: 686.w,
                              padding: EdgeInsets.only(left: 20.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.w),
                                  border: Border.all(
                                      width: 1.h, color: Color(0xff2B3448))),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: TextFormField(
                                      controller: _controller4,
                                      focusNode: _focusNode4,
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                          hintText: "请输入手机验证码",
                                          hintStyle: TextStyle(
                                              fontSize: 28.sp,
                                              color: Color(0xff999999)),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  Container(
                                    width: 196.w,
                                    decoration: BoxDecoration(
                                        color: Color(0xff498FEA),
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10.w),
                                            bottomRight:
                                                Radius.circular(10.w))),
                                    child: FlatButton(
                                      onPressed: () {
                                        if (_isClick) {
                                          _getVCode(model);
                                        }
                                      },
                                      child: Text(
                                        _isClick
                                            ? '获取验证码'
                                            : '$_currentSecond 秒',
                                        style: TextStyle(
                                            fontSize: 24.sp,
                                            color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ))
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 32.w, right: 32.w, top: 100.h, bottom: 20.h),
                      child: CustomButton(
                        "提交",
                        width: 686.w,
                        height: 98.h,
                        color: Color(0xff498FEA),
                        textColor: Colors.white,
                        radius: 49.w,
                        fontSize: 32.sp,
                        busy: model.busy,
                        onPressed: () async {
                          ResultModel resultModel = await model.changeLogin(
                            _controller.text.trim(),
                            _controller2.text.trim(),
                            _controller3.text.trim(),
                            _controller4.text.trim(),
                          );
                          if (resultModel.code == Constants.successCode) {
                            ToastUtil.openToast(resultModel.message);
                            NavigatorUtil.push(context,LoginRouter.login,replace: true);
                          } else {
                            ToastUtil.openToast(resultModel.message);
                          }
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "温馨提示：修改登录密码24小时内不可提现",
                        style: TextStyle(
                            fontSize: 24.sp, color: Color(0xff999999)),
                      ),
                    ),
                  ],
                );
              },
            )),
      ),
    );
  }
}
