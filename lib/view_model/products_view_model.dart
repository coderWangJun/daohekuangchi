import 'package:dh/common/mine_apis.dart';
import 'package:dh/http/index.dart';
import 'package:dh/provider/view_state_refresh_list_model.dart';
import 'package:dh/entity/products_entity.dart';

class ProductsViewModel extends ViewStateRefreshListModel {

  ProductsViewModel();

  String _myAmount = "";
  String _profit = "";

  String get myAmount => _myAmount;

  String get profit => _profit;

  @override
  Future<List> loadData({int pageNum}) async {
    setBusy();
    List<ProductsEntity> _list = List();
    if (modelType == "2") {
      _list.clear();
      _list = [];
      setIdle();
      return _list;
    } else {
      ResultData resultData =
      await HttpClient.getInstance().post(MineApis.MY_ORDERS, data: {
        "type": modelType,
        "page": pageNum,
      });
      _myAmount = resultData.data["cashnum"];
      _profit = "0.00";
      (resultData.data["list"]["data"] as List).forEach((element) {
        _list.add(ProductsEntity.fromJson(element));
      });
      setIdle();
      return _list;
    }
  }

  String modelType = "1";

  setType(String t) {
    Future.delayed(Duration(milliseconds: 100), () {
      setBusy();
      this.modelType = t;
      setIdle();
    });
  }
}
