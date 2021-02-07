import 'package:dh/common/gapis.dart';
import 'package:dh/entity/shop_detail_entity.dart';
import 'package:dh/http/http_client.dart';
import 'package:dh/http/result_data.dart';
import 'package:dh/utils/logger_util.dart';
import 'package:dh/utils/toast_util.dart';
import '../provider/view_state_refresh_list_model.dart';

class ShopDetailViewModel extends ViewStateRefreshListModel {
  final String id;
  ShopDetailViewModel(this.id);
  ShopDetailEntity shopDetailEntity = ShopDetailEntity.fromJson({});
  @override
  Future<List> loadData({int pageNum}) async {
    setBusy();
    ResultData resultData = await HttpClient.getInstance().post(GApis.SHOPDETAIL,data: {
      "id":id
    });
    shopDetailEntity = ShopDetailEntity.fromJson(resultData.data);
    setIdle();
  }


  //立即支付
  Future<ResultData> goPayment(String id,String inveshu,String password,int payType) async {
    setBusy();
    //payType  //成功后返回指定页面 1为首页进入，2运算力，3矿机
    ResultData resultData = await HttpClient.getInstance().post(GApis.SHOPPING,data: {
      "id":id,//矿机id
      "inveshu":inveshu,//实际数量
      "password":password,//交易密码
    });
    LogUtil.v(resultData);
    ToastUtil.openToast(resultData.message);
    setIdle();
    return resultData;
  }
}
