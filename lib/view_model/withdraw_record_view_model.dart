import 'package:dh/common/apis.dart';
import 'package:dh/http/index.dart';
import 'package:dh/provider/view_state_refresh_list_model.dart';
import 'package:dh/entity/withdraw_item_entity.dart';

class WithdrawRecordViewModel extends ViewStateRefreshListModel {
  final int type;

  WithdrawRecordViewModel(this.type);

  int status = 0;

  int notsuc=0;
  int suc=0;
  @override
  Future<List> loadData({int pageNum}) async {
    setBusy();
    List<WithdrawItemEntity> _list = new List();

    ResultData resultData = await HttpClient.getInstance().post(Apis.WITHDRAW_RECORD,data: {
      'page':pageNum,
      'type':type==0?6:5
    });
    notsuc = resultData.data["notsuc"];
    suc = resultData.data["suc"];

    (resultData.data["data"] as List).forEach((element) {
      _list.add(WithdrawItemEntity.fromJson(element));
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
