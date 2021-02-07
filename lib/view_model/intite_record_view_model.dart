import 'package:dh/common/gapis.dart';
import 'package:dh/entity/home_entity.dart';
import 'package:dh/entity/invite_entity.dart';
import 'package:dh/entity/shared_records_entity.dart';
import 'package:dh/http/http_client.dart';
import 'package:dh/http/result_data.dart';
import 'package:dh/utils/logger_util.dart';
import '../provider/view_state_refresh_list_model.dart';

class InviteRecordViewModel extends ViewStateRefreshListModel {

  InviteRecordViewModel();

  String modelType = "1";

  setType(String t) {
    Future.delayed(Duration(milliseconds: 100), () {
      setBusy();
      this.modelType = t;
      setIdle();
    });
  }

  InviteEntity inviteEntity = InviteEntity.fromJson({});
  String teamNum = "";
  String inviteNum = "";
  String referNum = "";
  String totalAmount = "";

//  List<Data> inviteRecord=[];

  @override
  Future<List> loadData({int pageNum}) async {
    setBusy();
    List<SharedRecordsEntity> _list  = List();
    ResultData resultData = await HttpClient.getInstance().post(
        GApis.SHARAWARD, data: {"page": pageNum,"type": modelType});
    teamNum = resultData.data["teamNum"].toString();
    inviteNum = resultData.data["inviteNum"].toString();
    referNum = resultData.data["referNum"].toString();
    totalAmount = resultData.data["Totalamount"].toString();
    (resultData.data["record"]["data"] as List).forEach((element) {
      _list.add(SharedRecordsEntity.fromJson(element));
    });
    setIdle();
    return _list;
  }
}