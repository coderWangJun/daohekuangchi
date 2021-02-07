import 'package:dh/ui/pages/me/about_page.dart';
import 'package:dh/ui/pages/me/app_download_page.dart';
import 'package:dh/ui/pages/me/computing_power_management_page.dart';
import 'package:dh/ui/pages/me/contact_customer_service_page.dart';
import 'package:dh/ui/pages/me/help_center_page.dart';
import 'package:dh/ui/pages/me/help_details_page.dart';
import 'package:dh/ui/pages/me/income_details_page.dart';
import 'package:dh/ui/pages/me/invite_page.dart';
import 'package:dh/ui/pages/me/account_center_page.dart';
import 'package:dh/ui/pages/me/bind_email_page.dart';
import 'package:dh/ui/pages/me/bind_phone_page.dart';
import 'package:dh/ui/pages/me/certification_page.dart';
import 'package:dh/ui/pages/me/change_login_password_page.dart';
import 'package:dh/ui/pages/me/change_pay_password_page.dart';
import 'package:dh/ui/pages/me/personal_center_page.dart';
import 'package:dh/ui/pages/me/system_set_page.dart';
import 'package:dh/ui/pages/me/user_agree_legal_page.dart';
import 'package:fluro/fluro.dart';
import 'package:dh/routers/router_init.dart';
import 'package:dh/ui/pages/me/my_products_page.dart';



class MeRouter implements IRouterProvider {
  static String products = "/products";
  static String accountCenter = "/accountCenter";
  static String certification = "/certification";
  static String changeLogin = "/changeLogin";
  static String changePay = "/changePay";
  static String bindPhone = "/bindPhone";
  static String bindEmail = "/bindEmail";
  static String mineInvite = "/mineInvite";
  static String service = "/service";
  static String helper = "/helper";
  static String about = "/about";
  static String personalCenter = "/personalCenter";
  static String computingPower = "/computingPower";
  static String incomeDetails = "/incomeDetails";
  static String helpDetails = "/helpDetails";
  static String system = "/system";
  static String userLegal = "/userLegal";
  static String appDownload = "/appDownload";

  @override
  void initRouter(Router router) {
    router.define(products,
        handler: Handler(handlerFunc: (_, params) => MyProductsPage()));
    router.define(accountCenter,
        handler: Handler(handlerFunc: (_, params) => AccountCenterPage()));
    router.define(certification,
        handler: Handler(handlerFunc: (_, params) {
          var status = params["status"].first;
          return CertificationPage(status: status,);
        }));
    router.define(changeLogin,
        handler: Handler(handlerFunc: (_, params) {
          var phone = params["phone"].first;
          return ChangeLoginPasswordPage(phone: phone,);
        }));
    router.define(changePay,
        handler: Handler(handlerFunc: (_, params) {
          var phone = params["phone"].first;
          return ChangePayPasswordPage(phone: phone,);
        }));
    router.define(bindPhone,
        handler: Handler(handlerFunc: (_, params) {
          var phone = params["phone"].first;
          return BindPhonePage(phone: phone,);
        }));
    router.define(bindEmail,
        handler: Handler(handlerFunc: (_, params) {
          var phone = params["phone"].first;
          var username = params["username"].first;
          return BindEmailPage(phone: phone,username: username,);
        }));
    router.define(mineInvite,
        handler: Handler(handlerFunc: (_, params) => InvitePage()));
    router.define(service,
        handler: Handler(handlerFunc: (_, params) => ContactCustomerServicePage()));
    router.define(helper,
        handler: Handler(handlerFunc: (_, params) {
          var index = params["index"] == null ? "0" : params["index"].first;
          return HelpCenterPage(index: int.parse(index),);
        }));
    router.define(about,
        handler: Handler(handlerFunc: (_, params) => AboutPage()));
    router.define(personalCenter,
        handler: Handler(handlerFunc: (_, params) => PersonalCenterPage()));
    router.define(computingPower,
        handler: Handler(handlerFunc: (_, params) => ComputingPowerManagementPage()));
    router.define(incomeDetails,
        handler: Handler(handlerFunc: (_, params) {
          var type = params["type"].first;
          return IncomeDetailsPage(type: type,);
        }));
    router.define(helpDetails,
        handler: Handler(handlerFunc: (_, params) {
          var type = params["type"].first;
          var id = params["id"].first;
          return HelpDetailsPage(type: type,id: id,);
        }));
    router.define(system,
        handler: Handler(handlerFunc: (_, params) => SystemSetPage()));
    router.define(userLegal,
        handler: Handler(handlerFunc: (_, params) {
          var type = params["type"].first;
          return UserAgreeLegalPage(type: type);
        }));
    router.define(appDownload,
        handler: Handler(handlerFunc: (_, params) => AppDownloadPage()));
  }
}
