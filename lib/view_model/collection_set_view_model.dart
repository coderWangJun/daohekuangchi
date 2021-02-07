import 'dart:async';

import 'package:dh/entity/auth_entity.dart';
import 'package:dio/dio.dart';
import 'package:dh/common/apis.dart';
import 'package:dh/common/constants.dart';
import 'package:dh/common/mine_apis.dart';
import 'package:dh/http/result_data.dart';
import 'package:dh/provider/view_state_model.dart';
import 'package:dh/utils/platform_util.dart';
import 'package:dh/http/index.dart';
import 'package:http_parser/http_parser.dart';

class CollectionSetViewModel extends ViewStateModel {
  CollectionSetViewModel();

  AuthEntity authEntity = new AuthEntity();

  Future<ResultData> sendEmailCode(String username, String email) async {
    ResultData resultData = await HttpClient.getInstance().post(
        MineApis.SEND_EMAIL,
        data: {'email': email, 'username': username});
    return resultData;
  }

  //发送验证码
  Future<ResultData> sendSms(String type, String telephone) async {
    ResultData resultData = await HttpClient.getInstance()
        .post(Apis.SEND, data: {'phone': telephone, 'type': type});

    return resultData;
  }

  String type = "0";

  setType(String t) {
    setBusy();
    type = t;
    setIdle();
  }

  authDetails() async {
    if (type == "0") return;
    setBusy();
    ResultData resultData = await HttpClient.getInstance().post(
        MineApis.AUTH_DETAILS, data: {
      "type": type
    });
    if (resultData.code == Constants.successCode)
      authEntity = new AuthEntity.fromJson(resultData.data);
    else
      authEntity = new AuthEntity.fromJson({});
    setIdle
    (
    );
  }

  //实名认证
  Future<ResultModel> certification(String name, String idCard, File image,
      File image2) async {
    setBusy();
    ResultModel resultModel = ResultModel(Constants.successCode, "提交成功");

    String posimage = "";
    String othesimage = "";

    if (name.isEmpty) {
      resultModel.code = "9999";
      resultModel.message = "请输入真实姓名";
      setIdle();
      return resultModel;
    }

    if (idCard.isEmpty) {
      resultModel.code = "9999";
      resultModel.message = "请输入身份证号";
      setIdle();
      return resultModel;
    }

    if (image == null) {
      resultModel.code = "9999";
      resultModel.message = "请上传身份证正面";
      setIdle();
      return resultModel;
    } else {
      String path = image.path;
      var name = path.substring(path.lastIndexOf("/") + 1, path.length);
      var picture = await MultipartFile.fromFile(path,
          filename: name, contentType: MediaType('image', 'jpeg'));
      ResultData resultData = await HttpClient.getInstance()
          .upload(Apis.UPLOAD_IMG, data: {'file': picture});
      if (resultData.code == Constants.successCode) {
        posimage = resultData.data['src'];
      }
    }

    if (image2 == null) {
      resultModel.code = "9999";
      resultModel.message = "请上传身份证反面";
      setIdle();
      return resultModel;
    } else {
      String path = image2.path;
      var name = path.substring(path.lastIndexOf("/") + 1, path.length);
      var picture = await MultipartFile.fromFile(path,
          filename: name, contentType: MediaType('image', 'jpeg'));
      ResultData resultData = await HttpClient.getInstance()
          .upload(Apis.UPLOAD_IMG, data: {'file': picture});
      if (resultData.code == Constants.successCode) {
        othesimage = resultData.data['src'];
      }
    }

    ResultData resultData =
    await HttpClient.getInstance().post(MineApis.AUTH, data: {
      "truename": name,
      "idcard": idCard,
      "posimage": posimage,
      "othesimage": othesimage,
    });

    resultModel.code = resultData.code;
    resultModel.message = resultData.message;

    setIdle();
    return resultModel;
  }

  //修改登录密码
  Future<ResultModel> changeLogin(String old, String newPwd, String rePwd,
      String code) async {
    setBusy();
    ResultModel resultModel = ResultModel(Constants.successCode, "提交成功");
    if (old.isEmpty) {
      resultModel.code = "9999";
      resultModel.message = "请输入当前登录密码";
      setIdle();
      return resultModel;
    }

    if (newPwd.isEmpty) {
      resultModel.code = "9999";
      resultModel.message = "请输入新登录密码";
      setIdle();
      return resultModel;
    }
    if (rePwd.isEmpty) {
      resultModel.code = "9999";
      resultModel.message = "请再次输入新登录密码";
      setIdle();
      return resultModel;
    }

    if (newPwd != rePwd) {
      resultModel.code = "9999";
      resultModel.message = "两次密码不一致，请重新输入";
      setIdle();
      return resultModel;
    }

    if (code.isEmpty) {
      resultModel.code = "9999";
      resultModel.message = "请输入验证码";
      setIdle();
      return resultModel;
    }
    ResultData resultData = await HttpClient.getInstance()
        .post(MineApis.CHANGE_LOGIN, data: {
      "usedpassword": old,
      "newpassword": newPwd,
      "repassword": rePwd,
      "code": code
    });
    resultModel.code = resultData.code;
    resultModel.message = resultData.message;
    setIdle();
    return resultModel;
  }

  //修改资金密码
  Future<ResultModel> changePay(String newPwd, String rePwd,
      String phoneCode) async {
    setBusy();
    ResultModel resultModel = ResultModel(Constants.successCode, "提交成功");
    if (newPwd.isEmpty) {
      resultModel.code = "9999";
      resultModel.message = "请输入新资金密码";
      setIdle();
      return resultModel;
    }
    if (rePwd.isEmpty) {
      resultModel.code = "9999";
      resultModel.message = "请再次输入新资金密码";
      setIdle();
      return resultModel;
    }

    if (newPwd != rePwd) {
      resultModel.code = "9999";
      resultModel.message = "两次密码不一致，请重新输入";
      setIdle();
      return resultModel;
    }

    if (phoneCode.isEmpty) {
      resultModel.code = "9999";
      resultModel.message = "请输入手机验证码";
      setIdle();
      return resultModel;
    }

    ResultData resultData =
    await HttpClient.getInstance().post(MineApis.CHANGE_PAY, data: {
      "newpassword": newPwd,
      "repassword": rePwd,
      "code": phoneCode
    });
    resultModel.code = resultData.code;
    resultModel.message = resultData.message;

    setIdle();
    return resultModel;
  }

  //绑定手机
  Future<ResultModel> bindPhone(String oldCode, String newPhone,
      String newCode) async {
    setBusy();
    ResultModel resultModel = ResultModel(Constants.successCode, "提交成功");
    if (oldCode.isEmpty) {
      resultModel.code = "9999";
      resultModel.message = "请输入验证码";
      setIdle();
      return resultModel;
    }
    if (newPhone.isEmpty) {
      resultModel.code = "9999";
      resultModel.message = "请输入新手机号";
      setIdle();
      return resultModel;
    }

    if (newCode.isEmpty) {
      resultModel.code = "9999";
      resultModel.message = "请输入新手机验证码";
      setIdle();
      return resultModel;
    }

    ResultData resultData =
    await HttpClient.getInstance().post(MineApis.BINDPHONE, data: {
      "oldcode": oldCode,
      "newphone": newPhone,
      "newcode": newCode
    });
    resultModel.code = resultData.code;
    resultModel.message = resultData.message;
    setIdle();
    return resultModel;
  }

  //绑定邮箱
  Future<ResultModel> bindEmail(String phoneCode, String emailNum,
      String emailCode) async {
    setBusy();
    ResultModel resultModel = ResultModel(Constants.successCode, "提交成功");
    if (phoneCode.isEmpty) {
      resultModel.code = "9999";
      resultModel.message = "请输入验证码";
      setIdle();
      return resultModel;
    }
    if (emailNum.isEmpty) {
      resultModel.code = "9999";
      resultModel.message = "请输入邮箱号";
      setIdle();
      return resultModel;
    }

    if (emailCode.isEmpty) {
      resultModel.code = "9999";
      resultModel.message = "请输入邮箱验证码";
      setIdle();
      return resultModel;
    }

    ResultData resultData =
    await HttpClient.getInstance().post(MineApis.BIND_EMAIL, data: {
      'phoneCode': phoneCode,
      'emailname': emailNum,
      "emailCode": emailCode,
    });
    resultModel.code = resultData.code;
    resultModel.message = resultData.message;
    setIdle();
    return resultModel;
  }
}
