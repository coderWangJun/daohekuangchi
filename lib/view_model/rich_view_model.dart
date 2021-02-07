import 'package:dh/common/apis.dart';
import 'package:dh/http/index.dart';
import 'package:dh/provider/view_state_model.dart';
import 'package:dh/utils/index.dart';


class RichViewModel extends ViewStateModel {


  String filNum = "0.00";
  String usdtNum = "0.00";


  //总资产折合(USDT)
  String total = "0.00";

  //总资产折合(CNY)
  String totalCny="0.00";


  //可用
  String usdtAvailable = "0.00";

  //冻结余额
  String usdtFreeze = "0.00";

  //usdt cny
  String usdtCny="0.00";

  //可用
  String filAvailable = "0.00";

  //冻结余额
  String filFreeze = "0.00";

  String filCny="0.00";

  //用户名
  String username;

  //个人钱包地址
  String walletToken;

  Future<ResultData> initData() async {

    setBusy();
    ResultData resultData = await HttpClient.getInstance().post(
      Apis.RICH_HOME,
    );

    total= resultData.data["usdtNum"]??"0.00";
    totalCny = resultData.data["CNYNum"]??"0.00";

    username = resultData.data["username"];
    walletToken = resultData.data["wallet_token"];
    (resultData.data["module"] as List).forEach((element) {
      if (element["type"] == 5) {
        filAvailable = element["usable"];
        filFreeze = element["frozen"].toString();
        filCny=element["filcny"]??"0.00";
      }
      if (element["type"] == 6) {
        //可用
        usdtAvailable = element["usable"];
        //冻结余额
        usdtFreeze = element["frozen"].toString();
        usdtCny =element["filcny"]??"0.00";
      }
    });

    setIdle();
    return resultData;
  }
}
