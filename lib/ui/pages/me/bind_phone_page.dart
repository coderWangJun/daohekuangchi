import 'dart:async';

import 'package:dh/common/constants.dart';
import 'package:dh/http/result_data.dart';
import 'package:dh/provider/provider_widget.dart';
import 'package:dh/routers/fluro_navigator.dart';
import 'package:dh/ui/widgets/custom_app_bar.dart';
import 'package:dh/ui/widgets/custom_button.dart';
import 'package:dh/view_model/collection_set_view_model.dart';
import 'package:flutter/material.dart';
import 'package:dh/utils/index.dart';
import 'package:flutter/services.dart';

class BindPhonePage extends StatefulWidget {
  final String phone;

  const BindPhonePage({Key key, this.phone}) : super(key: key);

  @override
  _BindPhonePageState createState() => _BindPhonePageState();
}

class _BindPhonePageState extends State<BindPhonePage> {
  TextEditingController _controller = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  FocusNode _focusNode = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  FocusNode _focusNode3 = FocusNode();

  bool _isClick = true;

  /// 倒计时秒数
  final int _second = 60;

  /// 当前秒数
  int _currentSecond;
  StreamSubscription _subscription;

  Future _getOldVCode(CollectionSetViewModel model) async {
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

  bool _isNewClick = true;

  /// 倒计时秒数
  final int _newSecond = 60;

  /// 当前秒数
  int _newCurrentSecond;
  StreamSubscription _newSubscription;

  Future _getNewVCode(CollectionSetViewModel model) async {
    if (_controller2.text.isEmpty) {
      ToastUtil.openToast("请输入新手机号");
      return;
    }
    ResultData res = await model.sendSms("1", _controller2.text.trim());
    if (res != null && res.code == Constants.successCode) {
      setState(() {
        _newCurrentSecond = _newSecond;
        _isNewClick = false;
      });
      _newSubscription = Stream.periodic(Duration(seconds: 1), (i) => i)
          .take(_second)
          .listen((i) {
        setState(() {
          _newCurrentSecond = _newSecond - i - 1;
          _isNewClick = _newCurrentSecond < 1;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff161D30),
      appBar: CustomAppBar(
        centerTitle: "修改手机号码",
        isBack: true,
        backgroundColor: Color(0xff161D30),
        onBack: () {
          NavigatorUtil.popResult(context, "refresh");
        },
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
                            child: Text("原手机验证码(${widget.phone})",
                                style: TextStyle(
                                    fontSize: 28.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500)),
                          ),
                          Container(
                              width: 686.w,
//                              height: 91.h,
                              padding: EdgeInsets.only(left: 20.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.w),
                                  border: Border.all(
                                      width: 1.h, color: Color(0xff2B3448))),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: TextFormField(
                                      controller: _controller,
                                      focusNode: _focusNode,
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                          hintText: "请输入验证码",
//                                          contentPadding: EdgeInsets.only(
//                                              bottom: 15.h, top: 15.h),
                                          hintStyle: TextStyle(
                                              fontSize: 28.sp,
                                              color: Color(0xff999999)),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  Container(
                                    width: 196.w,
//                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Color(0xff498FEA),
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10.w),
                                            bottomRight:
                                                Radius.circular(10.w))),
                                    child: FlatButton(
                                      onPressed: () {
                                        if (_isClick) {
                                          _getOldVCode(model);
                                        }
                                      },
                                      child: Text(
                                        _isClick
                                            ? '获取验证码'
                                            : '$_currentSecond 秒',
                                        style: TextStyle(
                                            fontSize: 24.sp,
                                            color: Color(0xffffffff)),
                                      ),
                                    ),
                                  )
                                ],
                              ))
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 20.h, top: 30.h),
                            child: Text("新手机号",
                                style: TextStyle(
                                    fontSize: 28.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500)),
                          ),
                          Container(
                              width: 686.w,
//                              height: 91.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.w),
                                  border: Border.all(
                                      width: 1.h, color: Color(0xff2B3448))),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: 110.w,
//                                    height: 91.h,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "+86",
                                      style: TextStyle(
                                          fontSize: 28.sp, color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    width: 2.w,
                                    height: 40.h,
                                    color: Color(0xfff4f4f4),
                                    margin: EdgeInsets.only(right: 20.w),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _controller2,
                                      focusNode: _focusNode2,
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                          hintText: "请输入新手机号",
                                          hintStyle: TextStyle(
                                              fontSize: 28.sp,
                                              color: Color(0xff999999)),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 20.h, top: 30.h),
                            child: Text("新手机验证码",
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
                                      controller: _controller3,
                                      focusNode: _focusNode3,
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                          hintText: "输入新手机短信验证码",
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
                                        if (_isNewClick) {
                                          _getNewVCode(model);
                                        }
                                      },
                                      child: Text(
                                        _isNewClick
                                            ? '获取验证码'
                                            : '$_newCurrentSecond 秒',
                                        style: TextStyle(
                                            fontSize: 24.sp,
                                            color: Color(0xffffffff)),
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
                        busy: model.busy,
                        fontSize: 32.sp,
                        onPressed: () async {
                          ResultModel resultModel = await model.bindPhone(
                            _controller.text.trim(),
                            _controller2.text.trim(),
                            _controller3.text.trim(),
                          );
                          if (resultModel.code == Constants.successCode) {
                            ToastUtil.openToast(resultModel.message);
                            NavigatorUtil.popResult(context, "refresh");
                          } else {
                            ToastUtil.openToast(resultModel.message);
                          }
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text("温馨提示：修改手机号码24小时内不可提现",
                          style: TextStyle(
                              fontSize: 26.sp, color: Color(0xff999999))),
                    )
                  ],
                );
              },
            )),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
