import 'package:dh/common/mine_apis.dart';
import 'package:dh/entity/computing_entity.dart';
import 'package:dh/http/http_client.dart';
import 'package:dh/http/result_data.dart';
import 'package:dh/provider/view_state_model.dart';

class ComputingViewModel extends ViewStateModel {
  ComputingViewModel();

  ComputingEntity computingEntity =ComputingEntity.fromJson({});

  initData() async {
    setBusy();
    ResultData resultData = await HttpClient.getInstance().post(MineApis.COMMUNITY);
    computingEntity = new ComputingEntity.fromJson(resultData.data);

    setIdle();
  }

}
