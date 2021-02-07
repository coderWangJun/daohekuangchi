import 'package:dh/common/mine_apis.dart';
import 'package:dh/entity/community_list_entity.dart';
import 'package:dh/http/index.dart';
import 'package:dh/provider/view_state_refresh_list_model.dart';

class CommunityViewModel extends ViewStateRefreshListModel {
  CommunityViewModel();

  String myCompu = "";
  String myTeamCompu = "";
  String myrecom = "";
  String myteam = "";

  @override
  Future<List> loadData({int pageNum}) async {
    setBusy();
    List<CommunityListEntity> _list = List();
    ResultData resultData = await HttpClient.getInstance().post(MineApis.COMMUNITY,data: {
      "page": pageNum
    });
    myCompu = resultData.data["myCompu"].toString();
    myTeamCompu = resultData.data["myTeamCompu"].toString();
    myrecom = resultData.data["myrecom"].toString();
    myteam = resultData.data["myteam"].toString();
    (resultData.data["list"] as List).forEach((element) {
      _list.add(new CommunityListEntity.fromJson(element));
    });
    setIdle();
    return _list;
  }
}