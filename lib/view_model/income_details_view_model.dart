import 'package:dh/common/mine_apis.dart';
import 'package:dh/entity/income_details_entity.dart';
import 'package:dh/http/index.dart';
import 'package:dh/provider/view_state_refresh_list_model.dart';

class IncomeDetailsViewModel extends ViewStateRefreshListModel {
  final String type;

  IncomeDetailsViewModel(this.type);

  @override
  Future<List> loadData({int pageNum}) async {
    setBusy();
    List<IncomeDetailsEntity> _list = List();
    ResultData resultData = await HttpClient.getInstance().post(MineApis.INCOME_DETAILS,data: {
      "page": pageNum,
      "type": type
    });

    (resultData.data["data"] as List).forEach((element) {
      _list.add(new IncomeDetailsEntity.fromJson(element));
    });
    setIdle();
    return _list;
  }
}
