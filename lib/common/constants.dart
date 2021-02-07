
enum Env {
  PROD,
  DEV,
}


class Constants {

  static Env env;

  static const String successCode = "0000";

  /// api host
  static const API_HOST_DEV = 'http://road.dhtxcapital.com/';
  static const API_HOST_PROD = 'http://road.dhtxcapital.com/';

  //用户TOKEN
  static const String TOKEN_KEY = "token";

  static const String APP_ID = "";

  static const String APP_SECRET = "";

  static const String APP_SIGN = "AN32ebCOsd21LI082RQKsRF8s9LFIidB";

  //主题
  static const String THEME = "theme";

  //暗黑模式
  static const String DARK_MODE = "dart_mode";

  //登录信息
  static const String LOGIN_INFO = "login_info";

  //字体
  static const String FONT = "font";

  //用户名
  static const String USER_NAME= "user_name";

  //用户绑定的手机号
  static const String PHONE= "phone";

  //密码
  static const String PASSWORD= "password";
  static const int PAGE_SIZE=10;

  static String get apiHost {
    if (env == Env.PROD) {
      return API_HOST_PROD;
    } else {
      return API_HOST_DEV;
    }
  }

  //是否调试模式
  static  bool get isDebug {
    if (env == Env.PROD) {
      return false;
    } else {
      return true;
    }
  }

}
