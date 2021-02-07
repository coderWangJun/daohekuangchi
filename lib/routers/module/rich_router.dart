import 'package:dh/ui/pages/rich/add_address_page.dart';
import 'package:dh/ui/pages/rich/address_page.dart';
import 'package:dh/ui/pages/rich/flow_page.dart';
import 'package:dh/ui/pages/rich/recharge_page.dart';
import 'package:dh/ui/pages/rich/recharge_record_page.dart';
import 'package:dh/ui/pages/rich/transfer_page.dart';
import 'package:dh/ui/pages/rich/transfer_record_page.dart';
import 'package:dh/ui/pages/rich/withdraw_page.dart';
import 'package:dh/ui/pages/rich/withdraw_record_page.dart';
import 'package:fluro/fluro.dart';
import 'package:dh/routers/router_init.dart';

class RichRouter implements IRouterProvider {
  static String withdraw = "/withdraw";
  static String withdrawRecord = "/withdrawRecord";
  static String recharge = "/recharge";
  static String rechargeRecord = "/rechargeRecord";
  static String transfer = "/transfer";
  static String transferRecord = "/transferRecord";
  static String flow = "/flow";
  static String address = "/address";
  static String addAddress = "/addAddress";

  @override
  void initRouter(Router router) {
    router.define(recharge, handler: Handler(handlerFunc: (_, params) {
      String token = params["token"]?.first ?? "";
      return RechargePage(
        token: token,
      );
    }));

    router.define(rechargeRecord, handler: Handler(handlerFunc: (_, params) {
      int type = int.parse(params["type"].first ?? "0");
      String name = (params["name"].first ?? "USDT");
      return RechargeRecordPage(
        type: type,
        name: name,
      );
    }));

    router.define(withdraw, handler: Handler(handlerFunc: (_, params) {
      int type = int.parse(params["type"].first ?? "0");
      return WithdrawPage(type: type,);
    }));
    router.define(withdrawRecord, handler: Handler(handlerFunc: (_, params) {
      int type = int.parse(params["type"].first ?? "0");
      String name = (params["name"].first ?? "USDT");
      return WithdrawRecordPage(
        type: type,
        name: name,
      );
    }));
    router.define(transfer, handler: Handler(handlerFunc: (_, params) {
      String other = "";
      if (params["other"] != null && params["other"].first.isNotEmpty) {
        other = params["other"].first ?? "";
      }

      int type = 0;
      if (params["type"] != null && params["type"].first.isNotEmpty) {
        type = int.parse(params["type"].first);
      }
      return TransferPage(
        other: other,
        transferType: type,
      );
    }));

    router.define(transferRecord, handler: Handler(handlerFunc: (_, params) {
      int type = int.parse(params["type"].first ?? "0");
      String name = (params["name"].first ?? "USDT");
      return TransferRecordPage(
        type: type,
        name: name,
      );
    }));

    router.define(flow, handler: Handler(handlerFunc: (_, params) {
      int type = int.parse(params["type"].first ?? "0");
      String name = (params["name"].first ?? "USDT");
      return FlowPage(
        type: type,
        name: name,
      );
    }));

    router.define(address, handler: Handler(handlerFunc: (_, params) {
      int type = int.parse(params["type"].first ?? "0");
      return AddressPage(
        type: type,
      );
    }));
    router.define(addAddress, handler: Handler(handlerFunc: (_, params) {
      int type = int.parse(params["type"].first ?? "0");
      return AddAddressPage(
        type: type,
      );
    }));
  }
}
