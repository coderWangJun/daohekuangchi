import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
  static openToast(String msg,
      {int fadeTime = 1,
      var gravity = ToastGravity.CENTER,
      //var bgColor = Colors.pink,
      var textColor = Colors.white,
      var fontSize = 14.0}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: gravity,
        timeInSecForIos: fadeTime,
        //backgroundColor: bgColor,
        textColor: textColor,
        fontSize: fontSize);
  }
}
