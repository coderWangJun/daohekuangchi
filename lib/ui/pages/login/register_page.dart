import 'package:dh/common/constants.dart';
import 'package:dh/http/result_data.dart';
import 'package:dh/provider/provider_widget.dart';
import 'package:dh/res/styles.dart';
import 'package:dh/routers/fluro_navigator.dart';
import 'package:dh/routers/module/me_router.dart';
import 'package:dh/ui/widgets/custom_app_bar.dart';
import 'package:dh/ui/widgets/custom_button.dart';
import 'package:dh/utils/index.dart';
import 'package:dh/view_model/login_view_model.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController vcodeController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  TextEditingController tradeController = TextEditingController();
  TextEditingController confirmTradeController = TextEditingController();
  TextEditingController yqCodeController = TextEditingController();

  FocusNode nameNode = FocusNode();
  FocusNode phoneNode = FocusNode();
  FocusNode vcodeNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode confirmPasswordNode = FocusNode();
  FocusNode tradeNode = FocusNode();
  FocusNode confirmTradeNode = FocusNode();
  FocusNode yqCodeNode = FocusNode();

  bool _value = false;

  @override
  void dispose() {
    // TODO: implement dispose
    nameController?.dispose();
    phoneController?.dispose();
    vcodeController?.dispose();
    passwordController?.dispose();
    confirmPasswordController?.dispose();
    tradeController?.dispose();
    confirmTradeController?.dispose();
    yqCodeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.colorBackgroundColor,
      appBar: CustomAppBar(
        centerTitle: "注册",
        isBack: true,
        backgroundColor: Styles.colorBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Container(
            width: 750.w,
            padding: EdgeInsets.only(left: 32.w, right: 32.w),
            child: ProviderWidget<LoginViewModel>(
              model: LoginViewModel(),
              builder: (ctx, model, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 128.h,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "注册",
                        style: Styles.theme(
                            fontSize: 40.sp,
                            color: Styles.colorWhite,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 20.h, top: 20.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("用户名",
                                    style: TextStyle(
                                        fontSize: 28.sp,
                                        color: Styles.colorWhite,
                                        fontWeight: FontWeight.w400)),
                                Text("请使用字母，或者字母+数字，最少6位",
                                    style: Styles.theme(
                                        fontSize: 24.sp,
                                        color: Styles.colorWhite)),
                              ],
                            ),
                          ),
                          Container(
                            width: 686.w,
                            //height: 90.h,
                            padding: EdgeInsets.only(left: 20.w, right: 20.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.w),
                                border: Border.all(
                                    width: 1.h, color: Styles.colorB2C6EA)),
                            child: TextFormField(
                              controller: nameController,
                              focusNode: nameNode,
                              decoration: InputDecoration(
                                  hintText: "请输入用户名",
                                  contentPadding:
                                      EdgeInsets.only(bottom: 15.h, top: 15.h),
                                  hintStyle: TextStyle(
                                      fontSize: 28.ssp,
                                      color: Styles.color9A9A9A),
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
                            margin: EdgeInsets.only(bottom: 20.h, top: 20.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("手机号",
                                    style: TextStyle(
                                        fontSize: 28.sp,
                                        color: Styles.colorWhite,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ),
                          Container(
                            width: 686.w,
                            //height: 90.h,
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: 20.w, right: 20.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.w),
                                border: Border.all(
                                    width: 1.h, color: Styles.colorB2C6EA)),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        child: Text("+86",
                                            style: TextStyle(
                                                fontSize: 28.sp,
                                                color: Styles.colorWhite,
                                                fontWeight: FontWeight.w400)),
                                        padding: EdgeInsets.only(right: 10.w),
                                      ),
                                      Image.asset(
                                        "assets/images/common/3jiao.png",
                                        width: 14.w,
                                        height: 10.h,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 15.w),
                                        child: Text(
                                          "|",
                                          style: Styles.theme(
                                              color: Styles.colorWhite),
                                        ),
                                      )
                                    ],
                                  ),
                                  margin: EdgeInsets.only(right: 20.w),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: phoneController,
                                    focusNode: phoneNode,
                                    decoration: InputDecoration(
                                        hintText: "请输入手机号",
                                        hintStyle: TextStyle(
                                            fontSize: 28.ssp,
                                            color: Styles.color9A9A9A),
                                        border: InputBorder.none),
                                  ),
                                )
                              ],
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
                            margin: EdgeInsets.only(bottom: 20.h, top: 20.h),
                            child: Text("短信验证码",
                                style: TextStyle(
                                    fontSize: 28.sp,
                                    color: Styles.colorWhite,
                                    fontWeight: FontWeight.w400)),
                          ),
                          Container(
                              width: 686.w,
                              //height: 91.h,
                              padding: EdgeInsets.only(left: 20.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.w),
                                  border: Border.all(
                                      width: 1.h, color: Styles.colorB2C6EA)),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: TextFormField(
                                      controller: vcodeController,
                                      focusNode: vcodeNode,
                                      decoration: InputDecoration(
                                          hintText: "请输入手机验证码",
                                          contentPadding: EdgeInsets.only(
                                              bottom: 15.h, top: 15.h),
                                          hintStyle: TextStyle(
                                              fontSize: 28.sp,
                                              color: Styles.color9A9A9A),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  Container(
                                    width: 196.w,
                                    //height: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Styles.color4A90EA,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10.w),
                                            bottomRight:
                                                Radius.circular(10.w))),
                                    child: FlatButton(
                                      onPressed: model.isClick
                                          ? () {
                                              if (phoneController
                                                  .text.isEmpty) {
                                                ToastUtil.openToast("请输入手机号");
                                                return;
                                              }
                                              model.sendCode(
                                                  "1", phoneController.text);
                                            }
                                          : null,
                                      child: Text(
                                        model.btnTxt,
                                        style: TextStyle(
                                            fontSize: 24.sp,
                                            color: model.isClick
                                                ? Styles.colorWhite
                                                : Styles.colorWhite),
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
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("登录密码",
                                      style: TextStyle(
                                          fontSize: 28.sp,
                                          color: Styles.colorWhite,
                                          fontWeight: FontWeight.w400)),
                                  Text("支持字母+数字，不可用空格，最少8位",
                                      style: TextStyle(
                                          fontSize: 28.sp,
                                          color: Styles.colorWhite,
                                          fontWeight: FontWeight.w400))
                                ],
                              )),
                          Container(
                            width: 686.w,
                            // height: 90.h,
                            padding: EdgeInsets.only(left: 20.w, right: 20.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.w),
                                border: Border.all(
                                    width: 1.h, color: Styles.colorB2C6EA)),
                            child: TextFormField(
                              controller: passwordController,
                              focusNode: passwordNode,
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: "请输入8位登录密码",
                                  contentPadding:
                                      EdgeInsets.only(bottom: 15.h, top: 15.h),
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
                            child: Text("确认密码",
                                style: TextStyle(
                                    fontSize: 28.sp,
                                    color: Styles.colorWhite,
                                    fontWeight: FontWeight.w400)),
                          ),
                          Container(
                            width: 686.w,
                            // height: 90.h,
                            padding: EdgeInsets.only(left: 20.w, right: 20.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.w),
                                border: Border.all(
                                    width: 1.h, color: Styles.colorB2C6EA)),
                            child: TextFormField(
                              controller: confirmPasswordController,
                              focusNode: confirmPasswordNode,
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: "再次输入新登录密码",
                                  contentPadding:
                                      EdgeInsets.only(bottom: 15.h, top: 15.h),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("资金密码",
                                    style: TextStyle(
                                        fontSize: 28.sp,
                                        color: Styles.colorWhite,
                                        fontWeight: FontWeight.w400)),
                                Text("仅支持数字，6位数",
                                    style: TextStyle(
                                        fontSize: 28.sp,
                                        color: Styles.colorWhite,
                                        fontWeight: FontWeight.w400))
                              ],
                            ),
                          ),
                          Container(
                            width: 686.w,
                            //height: 90.h,
                            padding: EdgeInsets.only(left: 20.w, right: 20.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.w),
                                border: Border.all(
                                    width: 1.h, color: Styles.colorB2C6EA)),
                            child: TextFormField(
                              controller: tradeController,
                              focusNode: tradeNode,
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: "请输入6位数字资金密码",
                                  contentPadding:
                                      EdgeInsets.only(bottom: 15.h, top: 15.h),
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
                            child: Text("确认密码",
                                style: TextStyle(
                                    fontSize: 28.sp,
                                    color: Styles.colorWhite,
                                    fontWeight: FontWeight.w400)),
                          ),
                          Container(
                            width: 686.w,
                            //height: 90.h,
                            padding: EdgeInsets.only(left: 20.w, right: 20.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.w),
                                border: Border.all(
                                    width: 1.h, color: Styles.colorB2C6EA)),
                            child: TextFormField(
                              controller: confirmTradeController,
                              focusNode: confirmTradeNode,
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: "再次输入资金密码",
                                  contentPadding:
                                      EdgeInsets.only(bottom: 15.h, top: 15.h),
                                  hintStyle: TextStyle(
                                      fontSize: 28.ssp,
                                      color: Styles.color9A9A9A),
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
                            child: Text("推荐码（必填）",
                                style: TextStyle(
                                    fontSize: 28.sp,
                                    color: Styles.colorWhite,
                                    fontWeight: FontWeight.w400)),
                          ),
                          Container(
                            width: 686.w,
                            // height: 90.h,
                            padding: EdgeInsets.only(left: 20.w, right: 20.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.w),
                                border: Border.all(
                                    width: 1.h, color: Color(0xffd5d5d5))),
                            child: TextFormField(
                              controller: yqCodeController,
                              focusNode: yqCodeNode,
                              style: TextStyle(color: Styles.colorWhite),
                              decoration: InputDecoration(
                                  hintText: "请输入推荐码",
                                  contentPadding:
                                      EdgeInsets.only(bottom: 15.h, top: 15.h),
                                  hintStyle: TextStyle(
                                      fontSize: 28.ssp,
                                      color: Styles.color9A9A9A),
                                  border: InputBorder.none),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 750.w,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(top: 25.h),
                      child: Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              setState(() {
                                _value = !_value;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 16.w),
                              width: 32.w,
                              height: 32.w,
                              child: _value
                                  ? Image.asset(
                                      "assets/images/common/choose.png",
                                      width: 32.w,
                                    )
                                  : Image.asset(
                                      "assets/images/common/un_choose.png",
                                      width: 32.w,
                                      color: Colors.white,
                                    ),
                            ),
                          ),
                          Text(
                            '我已经阅读并同意',
                            style: TextStyle(
                                fontSize: 28.sp,
                                color: Styles.colorB1C6EA,
                                fontWeight: FontWeight.w400),
                          ),
                          InkWell(
                            onTap: () {
                              NavigatorUtil.push(
                                  context, MeRouter.userLegal + "?type=2");
                            },
                            child: Text(
                              "《用户协议》",
                              style: TextStyle(
                                  color: Styles.color73AAFF,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 28.sp,
                                  decoration: TextDecoration.none),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 32.w, right: 32.w, top: 100.h, bottom: 36.h),
                      child: CustomButton(
                        "注册",
                        width: 686.w,
                        height: 88.h,
                        color: Styles.color4A90EA,
                        textColor: Colors.white,
                        radius: 44.w,
                        fontSize: 32.sp,
                        busy: model.busy,
                        onPressed: () async {
                          if (nameController.text.isEmpty) {
                            ToastUtil.openToast("请输入用户名!");
                            return;
                          }
                          if (phoneController.text.isEmpty) {
                            ToastUtil.openToast("请输入手机号!");
                            return;
                          }
                          if (vcodeController.text.isEmpty) {
                            ToastUtil.openToast("请输入手机验证码!");
                            return;
                          }
                          if (passwordController.text.isEmpty) {
                            ToastUtil.openToast("请设置登录密码!");
                            return;
                          }

                          if (confirmPasswordController.text.isEmpty) {
                            ToastUtil.openToast("再次输入登录密码!");
                            return;
                          }
                          if (tradeController.text.isEmpty) {
                            ToastUtil.openToast("请设置资金密码!");
                            return;
                          }

                          if (confirmTradeController.text.isEmpty) {
                            ToastUtil.openToast("再次输入资金密码!");
                            return;
                          }
                          if (yqCodeController.text.isEmpty) {
                            ToastUtil.openToast("请输入推荐码!");
                            return;
                          }
                          if (!_value) {
                            ToastUtil.openToast("请先同意用户协议!");
                            return;
                          }
                          ResultModel resultModel = await model.register(
                            nameController.text.trim(),
                            phoneController.text.trim(),
                            passwordController.text.trim(),
                            confirmPasswordController.text.trim(),
                            tradeController.text.trim(),
                            confirmTradeController.text.trim(),
                            yqCodeController.text.trim(),
                            vcodeController.text.trim(),
                          );
                          if (resultModel.code == Constants.successCode) {
                            ToastUtil.openToast(resultModel.message);
                            NavigatorUtil.pop(context);
                          } else {
                            ToastUtil.openToast(resultModel.message);
                          }
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        NavigatorUtil.push(context, MeRouter.appDownload);
                      },
                      child: Container(
                        height: 60.h,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(bottom: 30.h),
                        child: Text(
                          "已注册用户点击这里下载APP",
                          style: Styles.theme(
                              color: Styles.colorFFD454, fontSize: 28.sp),
                        ),
                      ),
                    )
                  ],
                );
              },
            )),
      ),
    );
  }
}
