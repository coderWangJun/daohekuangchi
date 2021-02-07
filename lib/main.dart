import 'package:dh/common/constants.dart';
import 'package:dh/res/styles.dart';
import 'package:dh/ui/pages/splash_page.dart';
import 'package:dh/utils/cupertino_localization_delegate.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dh/routers/application.dart';
import 'package:dh/routers/routers.dart';
import 'package:dh/utils/index.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/material.dart' hide Router;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Constants.env = Env.PROD; //设定运行环境的环境变量
  runApp(MyApp());
  if (PlatformUtil.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  MyApp() {
    final router = Router();
    Routers.configureRoutes(router);
    Application.getRouter = router;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
        footerTriggerDistance: 80,
        dragSpeedRatio: 0.91,
        headerBuilder: () => ClassicHeader(
              idleText: "下拉刷新",
              releaseText: "释放刷新",
              refreshingText: "正在刷新...",
              completeText: "刷新完成",
              textStyle: Styles.theme(color: Styles.colorWhite, fontSize: 12),
            ),
        footerBuilder: () => ClassicFooter(
              noDataText: "没有更多数据了",
              loadingText: "正在加载...",
              failedText: "加载失败",
              idleText: "下拉刷新",
              canLoadingText: "上拉加载更多...",
              textStyle: Styles.theme(color: Styles.colorWhite, fontSize: 12),
            ),
        child: MaterialApp(
            navigatorKey: Routers.navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                textTheme: TextTheme(
                    subhead: TextStyle(
                        textBaseline: TextBaseline.alphabetic,
                        color: Styles.colorWhite,
                        fontSize: 14))),
            localizationsDelegates: [
              CupertinoLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('zh'),
            ],
            onGenerateRoute: Application.getRouter.generator,
            home: SplashPage()));
  }
}
