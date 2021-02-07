import 'package:dh/ui/pages/home/invite_page.dart';
import 'package:dh/ui/pages/home/invite_record_page.dart';
import 'package:dh/ui/pages/home/payment_page.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart' hide Router;

import '../router_init.dart';

class HomeRouter implements IRouterProvider {
  static String invite="/invite";
  static String inviteRecord="/inviteRecord";
  static String payment="/payment";

  @override
  void initRouter(Router router) {
//    router.define(exchangeOil, handler: Handler(handlerFunc: (_, params) {}));
    router.define(invite,
        handler: Handler(handlerFunc: (_, params) => InvitePage()));
    router.define(inviteRecord,
        handler: Handler(handlerFunc: (_, params) => InviteRecordPage()));
    router.define(payment,
        handler: Handler(handlerFunc: (_, params) {
          var id = params["id"].first;
          var realNum = params["realNum"].first;
          var hashcash = params["hashcash"].first;
          var payType = params["payType"].first;
          var uSDTNum = params["uSDTNum"].first;
          return PaymentPage(id,realNum,hashcash,payType,uSDTNum);
        }
        )
    );
//    router.define(joinInvest,
//        handler: Handler(handlerFunc: (_, params){
//          var id = params["id"].first;
//          var money = params["money"].first;
//          var name = params["name"].first;
//          return InvestPage(id:id,money: money,name:name);
//        }));
  }
}
