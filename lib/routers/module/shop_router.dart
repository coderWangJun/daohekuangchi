import 'package:dh/ui/pages/shop/my_computing_page.dart';
import 'package:dh/ui/pages/shop/my_ltc_page.dart';
import 'package:dh/ui/pages/shop/shop_detail_page.dart';
import 'package:fluro/fluro.dart';

import '../router_init.dart';

class ShopRouter implements IRouterProvider {
  static String myComputing = "/myComputing";
  static String myLtc = "/myLtc";
  static String shopDetail = "/shopDetail";

  @override
  void initRouter(Router router) {
    router.define(myComputing,
        handler: Handler(handlerFunc: (_, params) => MyComputingPage()));
    router.define(myLtc,
        handler: Handler(handlerFunc: (_, params) => MyLtcPage()));
    router.define(shopDetail,
        handler: Handler(handlerFunc: (_, params){
          var id = params["id"].first;
          var uSDT = params["uSDT"].first;
          var currentType = params["currentType"].first;
          var type = params["type"].first;
          return ShopDetailPage(id: id,uSDT: uSDT,currentType: int.parse(currentType),type: type,);
        }));
//    router.define(joinInvest,
//        handler: Handler(handlerFunc: (_, params){
//          var id = params["id"].first;
//          var money = params["money"].first;
//          var name = params["name"].first;
//          return InvestPage(id:id,money: money,name:name);
//        }));
  }
}
