import 'package:dh/common/gapis.dart';
import 'package:dh/common/mine_apis.dart';
import 'package:dh/entity/notice_details_entity.dart';
import 'package:dh/entity/notice_list_entity.dart';
import 'package:dh/http/index.dart';
import 'package:dh/provider/view_state_refresh_list_model.dart';

class HelpCenterListViewModel extends ViewStateRefreshListModel {
  final String type;
  HelpCenterListViewModel({this.type});

  NoticeDetailsEntity noticeDetailsEntity = new NoticeDetailsEntity.fromJson({});

  @override
  Future<List> loadData({int pageNum}) async {
    setBusy();
    List<NoticeListEntity> _list = List();
    ResultData resultData = await HttpClient.getInstance().post(GApis.NOTICE,data: {
      "page": pageNum,
      "type": type
    });

    (resultData.data["data"] as List).forEach((element) {
      _list.add(NoticeListEntity.fromJson(element));
    });

    setIdle();
    return _list;
  }

  initDetails(String id) async {
    setBusy();
    ResultData resultData = await HttpClient.getInstance().post(MineApis.HELP_DETAILS,data: {
      "id": id
    });

    noticeDetailsEntity = new NoticeDetailsEntity.fromJson(resultData.data);

    setIdle();
  }

}
