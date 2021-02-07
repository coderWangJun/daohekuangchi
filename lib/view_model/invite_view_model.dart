import 'package:dh/common/constants.dart';
import 'package:dh/common/gapis.dart';
import 'package:dh/entity/invite_entity.dart';
import 'package:dh/http/http_client.dart';
import 'package:dh/http/result_data.dart';
import 'package:dh/provider/view_state_model.dart';

class InviteViewModel extends ViewStateModel {
  InviteViewModel();

  InviteEntity inviteEntity = InviteEntity.fromJson({});

  Future<ResultData> initData() async {
    setBusy();
    ResultData resultData = await HttpClient.getInstance().post(GApis.SHARED);
    if (resultData.code == Constants.successCode) {
      inviteEntity = InviteEntity.fromJson(resultData.data);
    }
    setIdle();
    return resultData;
  }
}
