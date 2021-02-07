import 'package:dh/common/apis.dart';
import 'package:dh/entity/recharge_item_entity.dart';
import 'package:dh/http/index.dart';
import 'package:dh/provider/view_state_refresh_list_model.dart';

class RechargeRecordViewModel extends ViewStateRefreshListModel {
  final int type;

  RechargeRecordViewModel(this.type);

  int status = 0;

  @override
  Future<List> loadData({int pageNum}) async {
    setBusy();
    List<RechargeItemEntity> _list = new List();

    ResultData resultData = await HttpClient.getInstance().post(
        Apis.RECHARGE_RECORD,
        data: {'page': pageNum, "type": type == 0 ? 6 : 5});
    (resultData.data["data"] as List).forEach((element) {
      _list.add(RechargeItemEntity.fromJson(element));
    });

    setIdle();
    return _list;
  }

  setStatus(int s) {
    setBusy();
    this.status = s;
    setIdle();
  }
}
