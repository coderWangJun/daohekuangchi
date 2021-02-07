import 'package:dh/common/apis.dart';
import 'package:dh/entity/flow_item_entity.dart';
import 'package:dh/http/index.dart';
import 'package:dh/provider/view_state_refresh_list_model.dart';

class FlowViewModel extends ViewStateRefreshListModel {
  //0:USDT,1:Fil
  final int type;

  FlowViewModel(this.type);

  String usable = "0.00";
  String freeze = "0.00";
  String cny = "0.00";

  @override
  Future<List> loadData({int pageNum}) async {
    setBusy();
    List<FlowItemEntity> _list = new List();

    ResultData resultData = await HttpClient.getInstance().post(
        Apis.FLOW_RECORD,
        data: {'type': type == 0 ? 2 : 1, 'page': pageNum});
    usable = resultData.data["data"]["compose"]["usable"];
    freeze = resultData.data["data"]["compose"]["frozen"];
    cny = resultData.data["data"]["compose"]["convert"];

    (resultData.data["data"]["list"] as List).forEach((element) {
      _list.add(FlowItemEntity.fromJson(element));
    });

    setIdle();
    return _list;
  }
}
