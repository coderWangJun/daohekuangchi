import 'package:dh/common/constants.dart';
import 'package:dh/common/mine_apis.dart';
import 'package:dh/http/index.dart';
import 'package:dh/provider/view_state_model.dart';

class MineInviteViewModel extends ViewStateModel {
  MineInviteViewModel();

  String _invite_code = "";
  String _url = "";
  String get inviteCode => _invite_code;
  String get url => _url;

  Future<ResultData> initData() async {
    setBusy();
    ResultData resultData = await HttpClient.getInstance().post(MineApis.SHARED);
    if (resultData.code == Constants.successCode) {
      _invite_code = resultData.data["invite_code"];
      _url = resultData.data["url"];
    }
    setIdle();
    return resultData;
  }

}