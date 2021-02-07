import 'package:dio/dio.dart';
import 'package:dh/common/constants.dart';

class LoggerInterceptor extends Interceptor {
  @override
  onRequest(RequestOptions options) async {
    if (Constants.isDebug) {
      print('request baseUrl: ${options.baseUrl}');
      print('request url: ${options.path}');
      print('request header: ${options.headers.toString()}');
      if (options.data != null) {
        print('request params: ${options.data.toString()}');
      }
      print('\r\n');
    }
    return options;
  }

  @override
  onResponse(Response response) async {
    if (Constants.isDebug) {
      if (response != null) {
        print('response: ${response.toString()}');
        print('\r\n');
      }
    }
    return response;
  }

  @override
  onError(DioError error) async {
    if (Constants.isDebug) {
      print('request error: ${error.toString()}');
      print('request error info: ${error.response?.toString() ?? ""}');
    }
    return error;
  }
}
