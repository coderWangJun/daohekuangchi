import 'package:dh/ui/pages/login/forget_password_page.dart';
import 'package:fluro/fluro.dart';
import 'package:dh/routers/router_init.dart';
import 'package:dh/ui/pages/login/login_page.dart';
import 'package:dh/ui/pages/login/register_page.dart';

class LoginRouter implements IRouterProvider {
  static String login = "/login";
  static String register = "/register";
  static String forgetPassword = "forgetPassword";

  @override
  void initRouter(Router router) {
    router.define(login,
        handler: Handler(handlerFunc: (_, params) => LoginPage()));
    router.define(forgetPassword,
            handler: Handler(handlerFunc: (_, params) => ForgetPasswordPage()));
    router.define(register,
        handler: Handler(handlerFunc: (_, params) => RegisterPage()));
  }
}
