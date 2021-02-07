import 'package:dh/common/mine_apis.dart';
import 'package:dh/http/index.dart';
import 'package:dh/provider/view_state_model.dart';

class MeViewModel extends ViewStateModel {
  MeViewModel();

  String userid = "";
  String username = "";
  String hash_wa = "";
  String level = "";
  String phone = "";
  String isReal = "";
  String icon = "";


  initData() async {
    setBusy();
    ResultData resultData = await HttpClient.getInstance().post(MineApis.MINE);
    userid = resultData.data["userid"].toString();
    username = resultData.data["username"];
    hash_wa = resultData.data["hash_wa"].toString();
    level = resultData.data["level"];
    phone = resultData.data["phone"];
    isReal = resultData.data["is_real"].toString();
    icon = resultData.data["icon"];
    setIdle();
  }
  
  Future<ResultData> logout() async {
    setBusy();
    ResultData resultData = await HttpClient.getInstance().post(MineApis.LOGOUT);
    setIdle();
    return resultData;
  }
}