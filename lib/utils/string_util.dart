import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:dh/common/constants.dart';

class StringUtil {
  static String getSign(Map parameter) {
    var appSign = Constants.APP_SIGN;
    List<String> allKeys = [];
    parameter.forEach((key, value) {
      if (value is MultipartFile) {
      } else {
        allKeys.add(key + "=" + value.toString());
      }
    });

    allKeys.sort((obj1, obj2) {
      return obj1.compareTo(obj2);
    });

    String pairsString = allKeys.join("&");
    String sign = pairsString + appSign;
    String signString = generateMd5(sign);
    return signString;
  }

  /// md5加密
  static String generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);

    var md5String = hex.encode(digest.bytes).toUpperCase();
    return md5String;
  }
}
