import 'package:dh/common/mine_apis.dart';
import 'package:dh/http/index.dart';
import 'package:dh/provider/view_state_model.dart';

class AccountCenterViewModel extends ViewStateModel {
  AccountCenterViewModel();

  int is_real = 0;
  String email = "";
  int google = 0;
  String phone = "";
  String username = "";

  initData() async {
    setBusy();
    ResultData resultData = await HttpClient.getInstance().post(MineApis.ACCOUNT);
    is_real = resultData.data["is_real"];
    email = resultData.data["email"];
    google = resultData.data["google"];
    phone = resultData.data["phone"];
    username = resultData.data["username"];
    setIdle();
  }
}