import 'package:dh/common/apis.dart';
import 'package:dh/common/constants.dart';
import 'package:dh/entity/transfer_item_entity.dart';
import 'package:dh/http/index.dart';
import 'package:dh/provider/view_state_refresh_list_model.dart';

class TransferViewModel extends ViewStateRefreshListModel {
  //转账类型 0：USDT，1：FIL
  final int type;

  TransferViewModel(this.type);

  String phone;
  List<String> _noteList = new List();

  List<String> get noteList => _noteList;

  String note = "";

  Future<ResultData> init(int type) async {
    setBusy();
    ResultData resultData = await HttpClient.getInstance()
        .post(Apis.TRANSFER_HOME, data: {'type': type == 0 ? 6 : 5});

    avail = resultData.data["money"];
    fee = resultData.data["ratio"];
    phone = resultData.data["phone"];
    note = resultData.data["note"];
//    _noteList.clear();
//    (resultData.data["note"] as List).forEach((element) {
//      _noteList.add(element);
//    });
    setIdle();
    // TODO: implement initData
  }

  //发送验证码
  Future<ResultData> sendSms(String type, String telephone) async {
    ResultData resultData = await HttpClient.getInstance()
        .post(Apis.SEND, data: {'phone': telephone, 'type': type});

    return resultData;
  }

  @override
  Future<List> loadData({int pageNum}) async {
    setBusy();
    List<TransferItemEntity> _list = new List();

    ResultData resultData =
        await HttpClient.getInstance().post(Apis.TRANSFER_RECORD, data: {
      'page': pageNum,
      "type": type == 0 ? 6 : 5,
    });
    (resultData.data["data"] as List).forEach((element) {
      _list.add(TransferItemEntity.fromJson(element));
    });

    setIdle();
    return _list;
  }

  //0：到账中，1：已成功
  int status = 0;

  setStatus(int s) {
    setBusy();
    this.status = s;
    setIdle();
  }

  String avail = "0.00";
  String fee = "0.0";
  String address = "";

  Future<ResultData> transfer(
      String address, String num, String password, String vCode) async {
    setBusy();
    ResultData resultData =
        await HttpClient.getInstance().post(Apis.TRANSFER, data: {
      'amount': num,
      "othphone": address,
      "password": password,
      "type": type == 0 ? 6 : 5,
      "code": vCode
    });
    setIdle();
    return resultData;
  }
}
