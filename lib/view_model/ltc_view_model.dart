import 'package:dh/common/gapis.dart';
import 'package:dh/entity/ltc_entity.dart';
import 'package:dh/http/index.dart';
import 'package:dh/provider/view_state_refresh_list_model.dart';
import 'package:dh/utils/index.dart';

class LtcViewModel extends ViewStateRefreshListModel {
  final int type;

  LtcViewModel(this.type);

  int status = 0;
  LtcEntity ltcEntity = LtcEntity.fromJson({});
  @override
  Future<List> loadData({int pageNum}) async {
    setBusy();
    ResultData resultData = await HttpClient.getInstance().post(
        GApis.MILLHASH,
        data: {'page': pageNum, "type": type});
    LogUtil.v(resultData);
    ltcEntity = LtcEntity.fromJson(resultData.data);
    setIdle();
    return ltcEntity.computingList.data;
  }

}
