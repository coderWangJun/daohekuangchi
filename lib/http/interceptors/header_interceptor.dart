import 'package:dio/dio.dart';

class HeaderInterceptor extends Interceptor {

  @override
  onRequest(RequestOptions options) async {
    options.connectTimeout = 1000 * 45;
    options.receiveTimeout = 1000 *45 ;
    options.sendTimeout = 1000 *45 ;
    return options;
  }
}