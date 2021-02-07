import 'dart:async';
import 'package:dh/common/constants.dart';
import 'package:dh/http/index.dart';
import 'package:dh/provider/provider_widget.dart';
import 'package:dh/res/styles.dart';
import 'package:dh/routers/fluro_navigator.dart';
import 'package:dh/ui/pages/main_page.dart';
import 'package:dh/ui/widgets/custom_app_bar.dart';
import 'package:dh/ui/widgets/custom_button.dart';
import 'package:dh/ui/widgets/custom_text.dart';
import 'package:dh/view_model/payment_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dh/utils/index.dart';
import 'package:flutter/services.dart';

class PaymentPage extends StatefulWidget {
  final String id;
  final String realNum;
  final String hashcash;
  final String payType;
  final String uSDTNum;

  const PaymentPage(
      this.id, this.realNum, this.hashcash, this.payType, this.uSDTNum,
      {Key key})
      : super(key: key);
  static final _passwordController = TextEditingController();
  static final _vcodeController = TextEditingController();

  @override
  _PaymentPageState createState() => _PaymentPageState(_passwordController,_vcodeController);
}

class _PaymentPageState extends State<PaymentPage> {
  final passwordController;
  final vcodeController;
  bool _isClick= false;
  bool _isTClick = true; //验证码防重复点击
  /// 倒计时秒数
  final int _second = 60;
  StreamSubscription _subscription;
  /// 当前秒数
  int _currentSecond;
  _PaymentPageState(this.passwordController, this.vcodeController);

  Future _getVCode(PaymentViewModel model) async {
    ResultData res = await model.sendSms();
    if (res != null && res.code == Constants.successCode) {
      ToastUtil.openToast(res.message);
      setState(() {
        _currentSecond = _second;
        _isTClick = false;
      });
      _subscription = Stream.periodic(Duration(seconds: 1), (i) => i)
          .take(_second)
          .listen((i) {
        setState(() {
          _currentSecond = _second - i - 1;
          _isTClick = _currentSecond < 1;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<PaymentViewModel>(
        model: PaymentViewModel(), //此处引入新增的model
        onModelReady: (model) {
          //初始化页面数据
//          model.loadData();
        },
        builder: (ctx, model, child) {
          return Scaffold(
              appBar: CustomAppBar(
                centerTitle: "支付订单",
                color: Styles.colorFFFFFF,
                fontSize: 36.sp,
                iconColor: Styles.colorFFFFFF,
                backgroundColor: Styles.color498FEA,
              ),
              backgroundColor: Color(0xFF161D30),
              body: Builder(builder: (_) {
                return SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Styles.color498FEA,
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 84.h),
                                //color: Styles.color498FEA,
                                child: CustomText(
                                  '订单金额',
                                  fontSize: 28,
                                  color: Styles.colorFFFFFF,
                                ),
                              ),
                              Container(
                                padding:
                                    EdgeInsets.only(top: 34.h, bottom: 99.h),
                                child: CustomText(
                                  widget.hashcash + ' USDT',
                                  fontSize: 48,
                                  color: Styles.colorFFFFFF,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 112.h,
                          width: 750.w,
                          child: Stack(
                            overflow: Overflow.visible,
                            children: <Widget>[
                              Positioned(
                                left: 32.w,
                                top: -50.h,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.w)),
                                    color: Styles.color1E2638,
                                  ),
                                  width: 686.w,
                                  height: 112.h,
                                  padding: EdgeInsets.only(
                                      top: 42.h, bottom: 32.h, left: 40.w),
                                  alignment: Alignment.centerLeft,
                                  child:
                                      Text('可用余额:  ' + widget.uSDTNum + ' USDT',
                                          style: TextStyle(
                                            fontSize: 28.sp,
                                            color: Styles.color999999,
                                          )),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 37.h, left: 33.w),
                          alignment: Alignment.centerLeft,
                          child: CustomText(
                            '资金密码',
                            width: 112.w,
                            fontSize: 28,
                            color: Styles.colorFFFFFF,
                          ),
                          color: Styles.colorBackgroundColor,
                        ),
                        Container(
                          color: Styles.colorBackgroundColor,

                          margin: EdgeInsets.only(left: 32.w,right: 32.w,top: 37.h),
                          alignment: Alignment.centerLeft,
                          height: 88.h,
                          child: TextField(
                            controller: passwordController,
                            keyboardType: TextInputType.number,

                            decoration: InputDecoration(

                              contentPadding: EdgeInsets.only(left: 20.w),
                                focusedBorder: OutlineInputBorder(//选中样式
                                  borderSide: BorderSide(color: Styles.colorTheme,width: 2.w),
                                ),
                                enabledBorder: OutlineInputBorder(//未选中样式
                                  borderSide: BorderSide(color: Styles.colorB1C5E9),
                                ),
                                hintStyle: TextStyle(color: Styles.color999999,fontSize: 28.sp),
                                hintText: '请输入资金密码'),
                            obscureText: true, //隐藏内容
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 44.h, left: 33.w),
                          alignment: Alignment.centerLeft,
                          child: CustomText(
                            '短信验证码',
                            width: 140.w,
                            fontSize: 28,
                            color: Styles.colorFFFFFF,
                          ),
                          color: Styles.colorBackgroundColor,
                        ),

                        Container(
                            margin: EdgeInsets.only(left: 32.w,right: 32.w,top: 37.h),
                            height: 88.h,
                            width: 686.w,
                            child: Stack(
                              children: <Widget>[
                                Container(
                                    child: TextField(
                                      controller: vcodeController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(left: 20.w),
                                          focusedBorder: OutlineInputBorder(//选中样式
                                            borderSide: BorderSide(color: Styles.colorTheme,width: 2.w),
                                          ),
                                          enabledBorder: OutlineInputBorder(//未选中样式
                                            borderSide: BorderSide(color: Styles.colorB1C5E9),
                                          ),
                                          hintStyle: TextStyle(color: Styles.color999999,fontSize: 28.sp),
                                          hintText: '请输入手机验证码'),

                                    ),),
                                Positioned(
                                  right: 3.w,
                                  top: 3.h,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      top: 24.h,
                                      bottom: 24.h,
                                    ),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(

                                        borderRadius:
                                        BorderRadius.only(topRight: Radius.circular(4.w),bottomRight: Radius.circular(10.w)),
                                        color: Styles.color498FEA
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (_isTClick) _getVCode(model);
                                      },
                                      child: Text(
                                        _isTClick ? '获取验证码' : '$_currentSecond s',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Styles.colorFFFFFF,
                                            fontSize: 28.sp),
                                      ),
                                    ),
                                    width: 196.w,
                                  ),
                                )

                              ],
                            )),
                        Container(
                          padding: EdgeInsets.only(top: 98.h),
                          child: CustomButton(
                            _isClick==false?'确认付款':'提交中..',
                            width: 686.w,
                            height: 98.h,
                            fontSize: 32.sp,
                            busy: model.busy,
                            radius: 49.w,
                            color: _isClick==false?Styles.color498FEA:Styles.color2B3347,

                            onPressed: () async {
                              if(_isClick==false){
                                _isClick = true;
                                ResultData res = await model.goPayment(
                                    widget.id,
                                    widget.realNum,
                                    passwordController.text.toString().trim(),
                                    int.parse(widget.payType),
                                    vcodeController.text.toString().trim(),);
                                if (res.code == "0000") {
                                  passwordController.text = "";
                                  vcodeController.text = "";
                                  NavigatorUtil.pushW(context, MainPage(current: 2));
                                  _isClick = false;
                                }else{
                                  _isClick = false;
                                }
                              }

                            },
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }));
        });
  }
}
