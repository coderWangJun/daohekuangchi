import 'package:dh/common/constants.dart';
import 'package:dh/http/result_data.dart';
import 'package:dh/provider/provider_widget.dart';
import 'package:dh/res/styles.dart';
import 'package:dh/routers/fluro_navigator.dart';
import 'package:dh/ui/widgets/custom_app_bar.dart';
import 'package:dh/ui/widgets/custom_button.dart';
import 'package:dh/utils/index.dart';
import 'package:dh/view_model/login_view_model.dart';
import 'package:flutter/material.dart';

class ForgetPasswordPage extends StatefulWidget {
  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController vcodeController = TextEditingController();
  FocusNode nameNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode confirmPasswordNode = FocusNode();
  FocusNode vcodeNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    nameController?.dispose();
    vcodeController?.dispose();
    passwordController?.dispose();
    confirmPasswordController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.colorBackgroundColor,
      appBar: CustomAppBar(
        centerTitle: "忘记密码",
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 20.h, top: 30.h),
                            child: Text("用户名",
                                style: TextStyle(
                                    fontSize: 28.sp,
                                    color: Styles.colorWhite,
                                    fontWeight: FontWeight.w400)),
                          ),
                          Container(
                            width: 686.w,
                            height: 90.h,
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
                            margin: EdgeInsets.only(bottom: 20.h, top: 30.h),
                            child: Text("短信验证码",
                                style: TextStyle(
                                    fontSize: 28.sp,
                                    color: Styles.colorWhite,
                                    fontWeight: FontWeight.w500)),
                          ),
                          Container(
                              width: 686.w,
                              height: 91.h,
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
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Styles.color4A90EA,
                                        border: Border.all(
                                            width: 1.w,
                                            color: model.isClick
                                                ? Color(0xff4885DE)
                                                : Styles.color4A90EA),
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10.w),
                                            bottomRight:
                                                Radius.circular(10.w))),
                                    child: FlatButton(
                                      onPressed: model.isClick
                                          ? () {
                                              if (nameController.text.isEmpty) {
                                                ToastUtil.openToast("请输入用户名");
                                                return;
                                              }
                                              model.sendCode(
                                                  "2", nameController.text);
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
                                  Text("新登录密码",
                                      style: TextStyle(
                                        fontSize: 28.sp,
                                        color: Styles.colorWhite,
                                      )),
                                  Text("支持字母、数字，不可用空格，最少8位",
                                      style: TextStyle(
                                        fontSize: 28.sp,
                                        color: Styles.colorWhite,
                                      )),
                                ],
                              )),
                          Container(
                            width: 686.w,
                            height: 90.h,
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
                                  hintText: "请输入新登录密码",
                                  contentPadding:
                                      EdgeInsets.only(bottom: 20.h, top: 15.h),
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
                            child: Text("确认密码",
                                style: TextStyle(
                                    fontSize: 28.sp,
                                    color: Styles.colorWhite,
                                    fontWeight: FontWeight.w500)),
                          ),
                          Container(
                            width: 686.w,
                            height: 90.h,
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
                                      EdgeInsets.only(bottom: 20.h, top: 15.h),
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
                      margin: EdgeInsets.only(
                          left: 32.w, right: 32.w, top: 100.h, bottom: 100.h),
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
                          ResultModel resultModel = await model.modifyPassword(
                              nameController.text.trim(),
                              passwordController.text.trim(),
                              confirmPasswordController.text.trim(),
                              vcodeController.text.trim());
                          if (resultModel.code == Constants.successCode) {
                            ToastUtil.openToast(resultModel.message);
                            NavigatorUtil.pop(context);
                          } else {
                            ToastUtil.openToast(resultModel.message);
                          }
                        },
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
