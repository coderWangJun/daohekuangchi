import 'package:dh/common/apis.dart';
import 'package:dh/http/index.dart';
import 'package:dh/provider/view_state_model.dart';

class WithdrawViewModel extends ViewStateModel {
  int withdrawType = 0;

  String avail = "0.0000";
  String fee = "0.0";
  String address = "";
  DrawInfo drawInfo = DrawInfo.fromJson({});

  setWithdrawType(int type) {
    setBusy();
    this.withdrawType = type;
    setIdle();
  }

  String note = "";

  List<String> _noteList=new List();

  List<String> get noteList=>_noteList;

  Future<ResultData> withdraw(String address, String num, String password,
      String vcode, String google) async {
    setBusy();
    ResultData resultData =
        await HttpClient.getInstance().post(Apis.WITHDRAW, data: {
      "amount": num,
      "type": withdrawType == 0 ? 6 : 5,
      "addressid": address,
      "password": password,
      "code": vcode
    });

    setIdle();
    return resultData;
  }

  String phone = "";

  //发送验证码
  Future<ResultData> sendSms(String type, String telephone) async {
    ResultData resultData = await HttpClient.getInstance()
        .post(Apis.SEND, data: {'phone': telephone, 'type': type});

    return resultData;
  }

  initData(int withdrawType) async {
    setBusy();

    ResultData resultData =
        await HttpClient.getInstance().post(Apis.WITHDRAW_HOME);

    drawInfo = DrawInfo.fromJson(resultData.data["drawinfo"]);
    fee = drawInfo.drawRatio;
    if (withdrawType == 0) {
      avail = resultData.data["money"]["6"];
    } else {
      avail = resultData.data["money"]["5"];
    }
    phone = resultData.data["phone"];
//    _noteList.clear();
//    (resultData.data["note"] as List).forEach((element) {
//      _noteList.add(element);
//    });
    note = resultData.data["note"];

    setIdle();
  }
}

class DrawInfo {
  String withdrawOff;
  String drawLimit;
  String drawRatio;

  DrawInfo.fromJson(Map<String, dynamic> json) {
    withdrawOff = json['withdrawOff'] ?? "";
    drawLimit = json['draw_limit'] ?? "";
    drawRatio = json['draw_ratio'] ?? "";
  }
}
