import 'package:dh/common/apis.dart';
import 'package:dh/entity/address_item_entity.dart';
import 'package:dh/http/index.dart';
import 'package:dh/provider/view_state_refresh_list_model.dart';

class AddrViewModel extends ViewStateRefreshListModel {
//  //地址类型(0:usdt,1:fil)
  final int type;

  AddrViewModel(this.type);

  @override
  Future<List> loadData({int pageNum}) async {
    setBusy();
    ResultData resultData = await HttpClient.getInstance()
        .post(Apis.ADDRESS, data: {'type': addrType, 'page': pageNum});

    List<AddressItemEntity> _list = new List();
    (resultData.data["data"] as List).forEach((element) {
      _list.add(AddressItemEntity.fromJson(element));
    });

    setIdle();
    // TODO: implement loadData
    return _list;
  }

  int addrType = 0;

  //设置地址类型
  setAddrType(int t) {
    setBusy();
    this.addrType = t;
    setIdle();
  }

  int index = 0;

  //设置选中项
  void setSelected(int index) {
    setBusy();
    this.list.forEach((element) {
      element.checked = false;
    });
    this.list[index].checked = true;
    this.index = index;
    setIdle();
  }

  Future<ResultData> addAddress(int type, String name, String address) async {
    setBusy();
    ResultData resultData =
        await HttpClient.getInstance().post(Apis.ADD_ADDRESS, data: {
      "type": type,
      "title": name,
      "address": address,
    });

    setIdle();

    return resultData;
  }

  Future<ResultData> delAddress(String id) async {
    setBusy();
    ResultData resultData =
        await HttpClient.getInstance().post(Apis.DEL_ADDRESS, data: {
      "id": id,
    });

    setIdle();

    return resultData;
  }
}
