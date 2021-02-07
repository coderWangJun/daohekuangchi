import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dh/common/constants.dart';
import 'package:dh/http/result_data.dart';
import 'package:dh/routers/routers.dart';
import 'package:dh/utils/index.dart';

import 'http_error.dart';
import 'interceptors/header_interceptor.dart';
import 'interceptors/logger_interceptor.dart';

class HttpClient {
  static const String GET = "GET";
  static const String POST = "POST";
  Map<String, CancelToken> _cancelToken = new Map<String, CancelToken>();

  Dio dio;
  HttpError _httpError;
  ResultData _resultData;

  /// 私有构造函数
  HttpClient._internal() {
    dio = new Dio();
    dio.options.baseUrl = Constants.apiHost;
    dio.interceptors.add(new HeaderInterceptor());
    dio.interceptors.add(new LoggerInterceptor());
    //dio.interceptors.add(new TokenInterceptor());
  }

  /// 保存单例对象
  static HttpClient _client = new HttpClient._internal();

  factory HttpClient() => _client;

  static HttpClient getInstance() {
    return _client;
  }

  //GET请求
  get(String path,
      {Map<String, dynamic> data,
      Function onSuccess,
      Function onError,
      String tag}) async {
    return _request(path, GET, onSuccess, onError, data: data);
  }

  //POST请求
  post(String path,
      {Map<String, dynamic> data, Function onSuccess, Function onError}) async {
    return _request(path, POST, onSuccess, onError, data: data);
  }

  upload(String path,
      {Map<String, dynamic> data, Function onSuccess, Function onError}) async {
    ConnectivityResult connectivityResult =
    await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      _httpError = HttpError(HttpError.NETWORK_ERROR, "网络异常，请稍后重试！");
      if (onError != null) {
        onError(_httpError);
      }
      LogUtil.v("请求网络异常，请稍后重试！");
      return;
    }
    int timestamp = new DateTime.now().millisecondsSinceEpoch;
    var other = {'lang': 1, "timestamp": (timestamp / 1000).toStringAsFixed(0)};
    String token = SpUtil.getString(Constants.TOKEN_KEY);
    if (token.isNotEmpty) {
      data.addAll({"appToken": token});
    }
    data.addAll(other);

    String sign = StringUtil.getSign(data);
    data.addAll({"sign": sign});
    FormData tempData = new FormData.fromMap(data);
    Response response;
    try {
      response = await dio.request(path,
          data: tempData, options: Options(method: POST));
      if (response.statusCode == 200 && response.data != null) {
        var responseBody = json.decode(response.data);
        _resultData = ResultData.fromJson(responseBody);
        if (onSuccess != null) {
          onSuccess(_resultData);
        } else {
          return _resultData;
        }
      }
    } on DioError catch (e, s) {
      _httpError = HttpError.dioError(e);
      LogUtil.v("请求出错：$e\n$s");
      if (onError != null && e.type != DioErrorType.CANCEL) {
        onError(_httpError);
      } else {
        //_resultData = new ResultData(_httpError.code, _httpError.message, null);
        return _resultData;
      }
    } catch (e, s) {
      LogUtil.v("未知异常出错：$e\n$s");
      _httpError = HttpError(HttpError.UNKNOWN, "网络异常，请稍后重试！");
      if (onError != null) {
        onError(_httpError);
      } else {
        //_resultData = new ResultData(_httpError.code, _httpError.message, null);
        return _resultData;
      }
    }
  }
  _request(String path, String method, Function onSuccess, Function onError,
      {Map<String, dynamic> data, String tag}) async {
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      _httpError = HttpError(HttpError.NETWORK_ERROR, "网络异常，请稍后重试！");
      if (onError != null) {
        onError(_httpError);
      }
      _resultData = new ResultData(_httpError.code.toString(), _httpError.message, null);
      return _resultData;
      //LogUtil.v("请求网络异常，请稍后重试！");
      //return;
    }
    data = data ?? {};
    //FormData tempData;
    method = method ?? GET;
    int timestamp = new DateTime.now().millisecondsSinceEpoch;
    var other = {"timestamp": (timestamp / 1000).toStringAsFixed(0)};
    String token = SpUtil.getString(Constants.TOKEN_KEY);
    if (token.isNotEmpty) {
      data.addAll({"appToken": token});
    }
    data.addAll(other);

    String sign = StringUtil.getSign(data);
    data.addAll({"sign": sign});
    if (method == GET) {
      data.forEach((key, value) {
        if (path.indexOf(key) != -1) {
          path = path.replaceAll(":$key", value.toString());
        }
      });
    }
//    else if (method == POST) {
//      tempData = new FormData.fromMap(data);
//    }
    Response response;
    try {
      CancelToken cancelToken;
      if (tag != null) {
        cancelToken =
            _cancelToken[tag] == null ? new CancelToken() : _cancelToken[tag];
        _cancelToken[tag] = cancelToken;
      }

      response = await dio.request(path,
          data: json.encode(data),
          options: Options(method: method),
          cancelToken: cancelToken);
      if (response.statusCode == 200 && response.data != null) {
//        var responseBody;
//        if(response.data is String){
//          var responseBody =json.encode(response.data);
//
//        }else{
//          var responseBody =json.decode(response.data);
//        }

        var responseBody =json.decode(response.data);

        _resultData = ResultData.fromJson(responseBody);
        if (_resultData.code == "1111") {
          ToastUtil.openToast(_resultData.message);
          Routers.navigatorKey.currentState
              .pushNamedAndRemoveUntil("/login", ModalRoute.withName("/"));
        } else {
          if (onSuccess != null) {
            onSuccess(_resultData);
          } else {
            return _resultData;
          }
        }
      }
    } on DioError catch (e, s) {
      _httpError = HttpError.dioError(e);
      LogUtil.v("请求出错：$e\n$s");
      if (onError != null && e.type != DioErrorType.CANCEL) {
        onError(_httpError);
      } else {
        _resultData = new ResultData(_httpError.code.toString(), _httpError.message, null);
        return _resultData;
      }
    } catch (e, s) {
      LogUtil.v("未知异常出错：$e\n$s");
      _httpError = HttpError(HttpError.UNKNOWN, "网络异常，请稍后重试！");
      if (onError != null) {
        onError(_httpError);
      } else {
        _resultData = new ResultData(_httpError.code.toString(), _httpError.message, null);
        return _resultData;
      }
    }
  }
}
