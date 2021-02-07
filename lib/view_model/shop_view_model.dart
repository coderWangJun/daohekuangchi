import 'package:dh/common/constants.dart';
import 'package:dh/common/gapis.dart';
import 'package:dh/entity/shop_entity.dart';
import 'package:dh/http/http_client.dart';
import 'package:dh/http/result_data.dart';
import 'package:dh/utils/index.dart';
import 'package:dh/utils/sp_util.dart';

import '../provider/view_state_refresh_list_model.dart';

class ShopViewModel extends ViewStateRefreshListModel {
  final int type;
  ShopViewModel(this.type);
  ShopEntity shopEntity = ShopEntity.fromJson({});


  @override
  Future<List> loadData({int pageNum}) async {
    setBusy();
    List _list = List();
    ResultData resultData = await HttpClient.getInstance().post(GApis.SHOPWEB,data: {
      "page":pageNum,"type":type
    });

    shopEntity = ShopEntity.fromJson(resultData.data);
    (shopEntity.sliList.data as List).forEach((element) {
      _list.add(element);
    });
    SpUtil.putString(Constants.PHONE, resultData.data['phone']);
    setIdle();
    return _list;
  }

}
