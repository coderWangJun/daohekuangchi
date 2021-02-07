import 'dart:async';

import 'package:dh/common/constants.dart';
import 'package:dh/http/result_data.dart';
import 'package:dh/provider/view_state_model.dart';
import 'package:dh/utils/index.dart';
import 'package:dh/common/apis.dart';
import 'package:dh/http/index.dart';

class LoginViewModel extends ViewStateModel {
  LoginViewModel();

  //登录状态(0:初始状态,1:登录中,2:登录完成)
  int state = 0;

  bool isClick = true;

  String btnTxt = "获取验证码";

  int second = 60;

  int currentSecond;

  StreamSubscription _subscription;

  Future<ResultData> sendCode(String type,String phone) async {
    ResultData res = await sendSms(type, phone);
    if (res.code == Constants.successCode) {
      currentSecond = second;
      isClick = false;
      notifyListeners();
      _subscription = Stream.periodic(Duration(seconds: 1), (i) => i)
          .take(second)
          .listen((i) {
        currentSecond = second - i - 1;
        btnTxt = "$currentSecond s";
        isClick = currentSecond < 1;
        if (currentSecond < 1) {
          btnTxt = "获取验证码";
        }
        notifyListeners();
      });
    }
  }

  Future<ResultData> sign() async {
    setBusy();
    ResultData resultData = await HttpClient.getInstance().post(Apis.SIGN);
    setIdle();
    return resultData;
  }

  //获取记住密码信息
  Map<String, dynamic> getLoginInfo() {
    return SpUtil.getDynamic(Constants.LOGIN_INFO);
  }

  //登录
  Future<ResultModel> login(String username, String password) async {
    setBusy();
    ResultModel resultModel = new ResultModel(Constants.successCode, "登录成功");

    if (username.isEmpty) {
      resultModel.code = "9999";
      resultModel.message = "用户名不能为空!";
      setIdle();
      return resultModel;
    }
    if (password.isEmpty) {
      resultModel.code = "9999";
      resultModel.message = "密码不能为空!";
      setIdle();
      return resultModel;
    }
    ResultData resultData = await HttpClient.getInstance()
        .post(Apis.LOGIN, data: {'username': username, 'password': password});

    if (resultData.code == Constants.successCode) {
      SpUtil.putString(Constants.TOKEN_KEY, resultData.data["appToken"]);
      SpUtil.putString(Constants.USER_NAME, username);
      SpUtil.putString(Constants.PASSWORD, password);
    }
    resultModel.code = resultData.code;
    resultModel.message = resultData.message;
    setIdle();
    return resultModel;
  }

  //发送验证码
  Future<ResultData> sendSms(String type, String telephone) async {
    ResultData resultData = await HttpClient.getInstance()
        .post(Apis.SEND, data: {'phone': telephone, 'type': type});

    return resultData;
  }

  //忘记密码验证手机号
  Future<ResultModel> checkCode(String phone, String code) async {
    ResultModel resultModel = new ResultModel("9999", "验证失败");
    if (phone.isEmpty) {
      ToastUtil.openToast("手机号不能为空!");
      setIdle();
    }
    if (code.isEmpty) {
      ToastUtil.openToast("验证码不能为空!");
      setIdle();
    }
    ResultData resultData =
        await HttpClient.getInstance().post(Apis.CHECK_CODE, data: {
      'phone': phone,
      'code': code,
    });
    resultModel.code = resultData.code;
    resultModel.message = resultData.message;
    setIdle();
    return resultModel;
  }

  //修改密码
  Future<ResultModel> modifyPassword(String username, String password,
      String confirmPassword, String code) async {
    ResultModel resultModel = new ResultModel("9999", "修改失败");
    if (username.isEmpty) {
      resultModel.code = "9999";
      resultModel.message = "请输入用户名!";
      setIdle();
      return resultModel;
    }
    if (password.isEmpty) {
      resultModel.code = "9999";
      resultModel.message = "请输入8位登录密码!";
      setIdle();
      return resultModel;
    }
    if (confirmPassword.isEmpty) {
      resultModel.code = "9999";
      resultModel.message = "再次输入新登录密码!";
      setIdle();
      return resultModel;
    }
    if (code.isEmpty) {
      resultModel.code = "9999";
      resultModel.message = "请输入验证码!";
      setIdle();
      return resultModel;
    }
    ResultData resultData =
        await HttpClient.getInstance().post(Apis.MODIFY_PASSWORD, data: {
      'username': username,
      'code': code,
      "newpassword": password,
      "repassword": confirmPassword,
    });
    resultModel.code = resultData.code;
    resultModel.message = resultData.message;
    setIdle();
    return resultModel;
  }

  //注册帐号
  Future<ResultModel> register(
      String username,
      String phone,
      String sign_pass,
      String resign_pass,
      String pay_pass,
      String repay_pass,
      String referee_code,
      String code) async {
    setBusy();
    ResultModel resultModel = new ResultModel(Constants.successCode, "注册成功");
    if (username.isEmpty) {
      resultModel.code = "9999";
      resultModel.message = "用户名不能为空!";
      setIdle();
      return resultModel;
    }
    if (sign_pass.isEmpty) {
      resultModel.code = "9999";
      resultModel.message = "密码不能为空!";
      setIdle();
      return resultModel;
    }

    if (pay_pass.isEmpty) {
      resultModel.code = "9999";
      resultModel.message = "请输入6位资金密码!";
      setIdle();
      return resultModel;
    }
    if (code.isEmpty) {
      resultModel.code = "9999";
      resultModel.message = "验证码不能为空!";
      setIdle();
      return resultModel;
    }
    if (referee_code.isEmpty) {
      resultModel.code = "9999";
      resultModel.message = "推荐码不能为空!";
      setIdle();
      return resultModel;
    }

    ResultData resultData =
        await HttpClient.getInstance().post(Apis.REG, data: {
      'username': username,
      'phone': phone,
      'sign_pass': sign_pass,
      'resign_pass': resign_pass,
      'pay_pass': pay_pass,
      'repay_pass': repay_pass,
      'referee_code': referee_code,
      'code': code,
    });
    resultModel.code = resultData.code;
    resultModel.message = resultData.message;
    setIdle();
    return resultModel;
  }
}
