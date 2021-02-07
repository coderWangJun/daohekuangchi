import 'package:dh/common/constants.dart';
import 'package:dh/http/index.dart';
import 'package:dh/provider/provider_widget.dart';
import 'package:dh/res/styles.dart';
import 'package:dh/routers/fluro_navigator.dart';
import 'package:dh/routers/module/login_router.dart';
import 'package:dh/routers/routers.dart';
import 'package:dh/ui/widgets/button_progress_indicator.dart';
import 'package:dh/ui/widgets/custom_button.dart';
import 'package:dh/ui/widgets/custom_login_field_widget.dart';
import 'package:dh/view_model/login_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dh/utils/index.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State {
  //焦点
  FocusNode _focusNodeUserName = new FocusNode();
  FocusNode _focusNodePassword = new FocusNode();

  bool forget = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // 外层添加一个手势，用于点击空白部分，回收键盘
        body: new GestureDetector(
          onTap: () {
            _focusNodePassword.unfocus();
            _focusNodeUserName.unfocus();
          },
          child: ProviderWidget<LoginViewModel>(
              model: LoginViewModel(),
              builder: (context, model, child) {
                return new Stack(
                  children: <Widget>[
                    LoginForm(),
                  ],
                );
              }),
        ),
        resizeToAvoidBottomPadding: false);
  }
}

class LoginForm extends StatefulWidget {
  //焦点
  static final _usernameController = TextEditingController();
  static final _passwordController = TextEditingController();

  @override
  _LoginFormState createState() =>
      _LoginFormState(_usernameController, _passwordController);
}

class _LoginFormState extends State<LoginForm> {
  final nameController;
  final passwordController;
  bool forget = false;
  FocusNode _focusNodeUserName = new FocusNode();
  FocusNode _focusNodePassWord = new FocusNode();

  _LoginFormState(this.nameController, this.passwordController);

  @override
  void initState() {
    super.initState();

    String username = SpUtil.getString(Constants.USER_NAME);
    if (username.isNotEmpty) nameController.text = username;
    String password = SpUtil.getString(Constants.PASSWORD);
  }

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<LoginViewModel>(context);
    //忘记密码  立即注册
    Widget bottomArea = new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("没有账号",
              style: Styles.theme(
                color: Styles.color666666,
                fontSize: 28.ssp,
              )),
          FlatButton(
            child: Text(
              "立即注册",
              style: Styles.theme(
                color: Styles.color73AAFF,
                fontSize: 28.ssp,
              ),
            ),
            onPressed: () {
              NavigatorUtil.push(context, LoginRouter.register);
            },
          )
        ],
      ),
    );

    Widget loginButton = model.busy
        ? ButtonProgressIndicator()
        : CustomButton(
            "登录",
            width: 623.w,
            height: 88.h,
            radius: 88.w,
            fontSize: 34.ssp,
            color: Styles.colorTheme,
            busy: model.busy,
            onPressed: () async {
              ResultModel resultModel = await model.login(
                  nameController.text.toString().trim(),
                  passwordController.text.toString().trim());
              if (resultModel.code == Constants.successCode) {
                passwordController.text = "";
                NavigatorUtil.push(context, Routers.main, replace: true);
              } else {
                ToastUtil.openToast(resultModel.message.toString());
              }
            },
          );
    return new Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(color: Styles.colorBackgroundColor),
        child: new Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 280.h),
              child: Image.asset(
                "assets/images/app_logo.png",
                width: 91,
                height: 120,
              ),
            ),
            Container(
              width: 686.w,
              padding: EdgeInsets.only(left: 32.w, right: 32.w, top: 100.h),
              child: CustomLoginTextField(
                prefix: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 32.w),
                  child: Image.asset(
                    "assets/images/common/person.png",
                    width: 52.w,
                    height: 52.w,
                  ),
                ),
                label: "请输入您的用户名",
                obscureText: false,
                clear: false,
                focusNode: _focusNodeUserName,
                controller: nameController,
                textInputType: TextInputType.text,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (text) {
                  FocusScope.of(context).requestFocus(_focusNodePassWord);
                },
              ),
            ),
            Container(
              width: 686.w,
              padding: EdgeInsets.only(left: 32.w, right: 32.w, top: 40.h),
              child: CustomLoginTextField(
                prefix: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 32.w),
                  child: Image.asset(
                    "assets/images/common/key.png",
                    width: 52.w,
                    height: 52.w,
                  ),
                ),
                label: "请输入登录密码",
                obscureText: true,
                clear: false,
                controller: passwordController,
                textInputType: TextInputType.text,
//                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (text) {
                  FocusScope.of(context).requestFocus(_focusNodePassWord);
                },
              ),
            ),
            new Container(
              padding: EdgeInsets.only(right: 40.w),
              alignment: Alignment.topRight,
              child: FlatButton(
                child: Text(
                  "忘记密码?",
                  style: Styles.theme(
                    color: Styles.color73AAFF,
                    fontSize: 28.ssp,
                  ),
                ),
                onPressed: () {
                  NavigatorUtil.push(context, LoginRouter.forgetPassword);
                },
              ),
            ),
            new Container(
              padding: EdgeInsets.only(top: 55.h, bottom: 30.h),
              child: loginButton,
            ),
            bottomArea,
          ],
        ));
  }
}
