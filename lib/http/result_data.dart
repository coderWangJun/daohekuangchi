//网络请求返回结果类
class ResultData {
  String code;
  dynamic data;

  String message;
  var headers;

  ResultData(this.code, this.message, this.data, {this.headers});

  ResultData.fromJson(Map<String, dynamic> json) {
    data = json["data"]??"";
    code = json["code"];
    message = json["message"];
  }

  @override
  String toString() {
    return code.toString() + ":" + message;
  }
}

//网络请求返回结果类
class ResultModel {
  String code;
  String message;
  ResultModel(this.code,this.message);

  @override
  String toString() {
    return code.toString() + ":" + message;
  }
}
