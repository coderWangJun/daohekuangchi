import 'package:dh/common/mine_apis.dart';
import 'package:dh/http/index.dart';
import 'package:dh/provider/view_state_model.dart';

class RechargeViewModel extends ViewStateModel {
  String note = "";

  //获取地址
  initData() async {
    setBusy();
    ResultData resultData = await HttpClient.getInstance().post(MineApis.RECHARGE);
    note = resultData.data["note"];
    setIdle();
  }
}
