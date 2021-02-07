import 'package:dh/routers/module/home_router.dart';
import 'package:dh/routers/module/rich_router.dart';
import 'package:dh/ui/pages/home/post_detail_page.dart';
import 'package:dh/ui/pages/home/post_page.dart';
import 'package:dh/ui/widgets/web_view_page.dart';
import 'package:fluro/fluro.dart';
import 'package:dh/routers/module/login_router.dart';
import 'package:dh/routers/router_init.dart';
import 'package:dh/ui/pages/main_page.dart';

import 'module/me_router.dart';
import 'module/shop_router.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/cupertino.dart' hide Router;

class Routers {
  //全局路由
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  static List<IRouterProvider> _listRouter = [];
  static String main = '/main';

  static String web = "/web";

  static String post = "/post";
  static String postDetail = "/postDetail";

  static void configureRoutes(Router router) {
    router.define(main,
        handler: Handler(
            handlerFunc:
                (BuildContext context, Map<String, List<String>> params) =>
                    MainPage()));

    router.define(web, handler: Handler(handlerFunc: (_, params) {
      var title = params["title"].first;
      var url = params["url"].first;
      return WebViewPage(
        title: title,
        url: url,
      );
    }));
    //公告列表
    router.define(post,
        handler: Handler(handlerFunc: (_, params) => PostPage()));

    //公告详情
    router.define(postDetail, handler: Handler(handlerFunc: (_, params) {
      var id = params["id"].first;
      return PostDetailPage(id);
    }));
    _listRouter.clear();
    _listRouter.add(LoginRouter());
    _listRouter.add(HomeRouter());
    _listRouter.add(ShopRouter());
    _listRouter.add(RichRouter());
    _listRouter.add(MeRouter());
    _listRouter.forEach((routerProvider) {
      routerProvider.initRouter(router);
    });
  }
}
