import 'package:dh/common/apis.dart';
import 'package:dh/common/constants.dart';
import 'package:dh/common/gapis.dart';
import 'package:dh/entity/invite_entity.dart';
import 'package:dh/http/http_client.dart';
import 'package:dh/http/result_data.dart';
import 'package:dh/utils/logger_util.dart';
import 'package:dh/utils/sp_util.dart';
import 'package:dh/utils/toast_util.dart';
import '../provider/view_state_refresh_list_model.dart';

class PaymentViewModel extends ViewStateRefreshListModel {
  PaymentViewModel();
  InviteEntity inviteEntity = InviteEntity.fromJson({});
  @override
  Future<List> loadData({int pageNum}) async {
    setBusy();
    ResultData resultData = await HttpClient.getInstance().post(GApis.SHARED);
    LogUtil.v(resultData);
    inviteEntity = InviteEntity.fromJson(resultData.data);
    setIdle();
  }


  //立即支付
  Future<ResultData> goPayment(String id,String inveshu,String password,int payType,String vcode) async {
    setBusy();
    //payType  //成功后返回指定页面 1为首页进入，2运算力，3矿机
    ResultData resultData = await HttpClient.getInstance().post(GApis.SHOPPING,data: {
      "id":id,//矿机id
      "inveshu":inveshu,//实际数量
      "password":password,//交易密码
      "code":vcode
    });
    LogUtil.v(resultData);
    ToastUtil.openToast(resultData.message);
    setIdle();
    return resultData;
  }

  String phone = SpUtil.getString(Constants.PHONE);


  //发送验证码
  Future<ResultData> sendSms() async {
    print(phone);
    ResultData resultData = await HttpClient.getInstance()
        .post(Apis.SEND, data: {'phone': phone,'type':1});

    return resultData;
  }
}
