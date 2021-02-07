import 'dart:async';

import 'package:dh/res/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dh/ui/widgets/custom_text.dart';
import 'package:dh/utils/index.dart';

/// 封装输入框
class CustomInputFieldItem extends StatefulWidget {
  const CustomInputFieldItem(
      {Key key,
      this.controller,
      this.title,
      this.keyboardType: TextInputType.text,
      this.hintText: '',
      this.hintColor,
      this.focusNode,
      this.onTap,
      this.readOnly: false,
      this.isPassword: false,
      this.onChanged,
      this.bgColor,
      this.width: 75,
      this.outWidth: 600,
      this.borderRadius,
      this.border,
      this.getVCode,
      this.textStyle,
      this.inputType: "text"})
      : super(key: key);

  final TextEditingController controller;
  final String title;
  final String hintText;
  final TextInputType keyboardType;
  final FocusNode focusNode;
  final Color hintColor;
  final GestureTapCallback onTap;
  final Function onChanged;
  final bool readOnly;
  final bool isPassword;
  final Color bgColor;
  final Future<bool> Function() getVCode;
  final TextStyle textStyle;
  final Radius borderRadius;

  //输入类型
  final String inputType;
  final double width;
  final double outWidth;
  final Color border;

  @override
  _CustomInputFieldItemState createState() {
    // TODO: implement createState
    return _CustomInputFieldItemState();
  }
}

class _CustomInputFieldItemState extends State<CustomInputFieldItem> {
  bool _isClick = true;

  /// 倒计时秒数
  final int _second = 30;

  /// 当前秒数
  int _currentSecond;
  StreamSubscription _subscription;

  Future _getVCode() async {
    bool isSuccess = await widget.getVCode();
    if (isSuccess != null && isSuccess) {
      setState(() {
        _currentSecond = _second;
        _isClick = false;
      });
      _subscription = Stream.periodic(Duration(seconds: 1), (i) => i)
          .take(_second)
          .listen((i) {
        setState(() {
          _currentSecond = _second - i - 1;
          _isClick = _currentSecond < 1;
        });
      });
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    widget.controller?.removeListener(() {});
    widget.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        height: 80.h,
        width: widget.outWidth,
        margin: EdgeInsets.only(bottom: 30.h),
        decoration: BoxDecoration(
          color: widget.bgColor == null
              ? Color.fromRGBO(247, 245, 246, 1)
              : widget.bgColor,
          border: Border.all(
              color: widget.border == null
                  ? Color.fromRGBO(247, 245, 246, 1)
                  : widget.border,
              width: 1),
          borderRadius: BorderRadius.all(widget.borderRadius == null
              ? Radius.circular(20.h)
              : widget.borderRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            widget.title != null
                ? Container(
                    padding: EdgeInsets.only(left: 20.w),
                    width: widget.width,
                    child: CustomText(
                      widget.title,
                      fontSize: 28,
                      color: Styles.colorThemeText,
                    ),
                  )
                : Container(
                    padding: EdgeInsets.only(left: 20.w),
                    height: 0.h,
                    width: 30.w,
                  ),
            Visibility(
              visible: widget.inputType == "text",
              child: Expanded(
                child: Semantics(
                  label: widget.hintText.isEmpty
                      ? '请输入$widget.title'
                      : widget.hintText,
                  child: TextField(
                      style: widget.textStyle,
                      focusNode: widget.focusNode,
                      readOnly: widget.readOnly,
                      textAlign: TextAlign.start,
                      keyboardType: widget.keyboardType,
                      obscureText: widget.isPassword,
                      inputFormatters: _getInputFormatters(),
                      controller: widget.controller,
                      onChanged: (text) {
                        widget.onChanged(text);
                      },
                      decoration: InputDecoration(
                        hintText: widget.hintText,
                        hintStyle: Styles.theme(
                            textBaseline: TextBaseline.alphabetic,
                            color: widget.hintColor != null
                                ? widget.hintColor
                                : Color.fromRGBO(199, 199, 199, 1),
                            fontSize: 28.ssp),
                        border: InputBorder.none, //去掉下划线
                        //hintStyle: TextStyles.textGrayC14
                      )),
                ),
              ),
            ),
            Visibility(
              visible: widget.inputType == "Dropdown",
              child: Container(
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(190)),
                child: Row(
                  children: <Widget>[
                    CustomText(widget.hintText, color: Styles.colorGray),
                    Padding(
                      padding: EdgeInsets.only(top: 2.0, left: 5.0),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                      ), //默认是黑色,
                    )
                  ],
                ),
              ),
            ),
            widget.getVCode == null
                ? Styles.empty
                : Container(
                    child: MaterialButton(
                    onPressed: _isClick ? _getVCode : null,
                    child: CustomText(
                      _isClick ? '获取验证码' : '$_currentSecond s',
                      color: Styles.colorTheme,
                      fontSize: 26,
                    ),
                  )),
//            widget.inputType == "Dropdown" ? Styles.hGap4 : Styles.hGap16
          ],
        ),
      ),
    );
  }

  _getInputFormatters() {
    if (widget.keyboardType == TextInputType.numberWithOptions(decimal: true)) {
      return [];
    }
    if (widget.keyboardType == TextInputType.number) {
      return [WhitelistingTextInputFormatter(RegExp('[0-9.]'))];
    } else if (widget.keyboardType == TextInputType.phone) {
      return [WhitelistingTextInputFormatter(RegExp('[0-9]'))];
    }
    return null;
  }
}
