import 'package:dio/dio.dart';
import 'package:dh/common/constants.dart';
import 'package:dh/utils/index.dart';

class TokenInterceptor extends Interceptor {
  String _token;

  @override
  onRequest(RequestOptions options) async {
    clearAuthorization();
    if (_token == null) {
      var authorizationCode = getAuthorization();
      if (authorizationCode != null) {
        _token = authorizationCode;
      }
    }
    if (_token.isNotEmpty)
      options.headers['Authorization'] = 'Bearer ' + _token;
    return options;
  }

  @override
  onResponse(Response response) async {
//		try {
//			var responseJSON = response.data;
//			if (response.statusCode == 201 && responseJSON['token'] != null) {
//				_token = 'token ' + responseJSON['token'];
//				await LocalStorage.set(LocalStorageKeys.TOKEN_KEY, _token);
//			}
//		} catch (e) {
//			print(e);
//		}
    return response;
  }

  getAuthorization() {
    String token = SpUtil.getString(Constants.TOKEN_KEY);
    if (token == null) {
    } else {
      this._token = token;
      return token;
    }
  }

  clearAuthorization() {
    this._token = null;
    //SPUtils.remove(Constants.TOKEN_KEY);
  }
}
