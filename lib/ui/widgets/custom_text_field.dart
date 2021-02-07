import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:dh/res/Styles.dart';
import 'package:dh/utils/index.dart';

import 'custom_load_image.dart';

/// 登录模块的输入框封装
class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {Key key,
      @required this.controller,
      this.maxLength: 16,
      this.minLength,
      this.autoFocus: false,
      this.keyboardType: TextInputType.text,
      this.hintText: '',
      this.focusNode,
      this.isInputPwd: false,
      this.getVCode,
      this.iconName,
      this.keyName})
      : super(key: key);

  final TextEditingController controller;
  final int maxLength;
  final int minLength;
  final bool autoFocus;
  final TextInputType keyboardType;
  final String hintText;
  final FocusNode focusNode;
  final bool isInputPwd;
  final Future<bool> Function() getVCode;
  final String iconName;

  /// 用于集成测试寻找widget
  final String keyName;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isShowPwd = false;
  bool _isShowDelete;
  bool _isClick = true;

  /// 倒计时秒数
  final int _second = 30;

  /// 当前秒数
  int _currentSecond;
  StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();

    /// 获取初始化值
    _isShowDelete = widget.controller.text.isEmpty;

    /// 监听输入改变
    widget.controller.addListener(() {
      setState(() {
        _isShowDelete = widget.controller.text.isEmpty;
      });
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    widget.controller?.removeListener(() {});
    widget.controller?.dispose();
    super.dispose();
  }

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
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    bool isDark = themeData.brightness == Brightness.dark;
    return Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(32)),
          child: Container(
            height: ScreenUtil().setHeight(105),
            child: TextField(
              focusNode: widget.focusNode,
              maxLength: widget.maxLength,
              obscureText: widget.isInputPwd ? !_isShowPwd : false,
              autofocus: widget.autoFocus,
              controller: widget.controller,
              textInputAction: TextInputAction.done,
              keyboardType: widget.keyboardType,
              // 数字、手机号限制格式为0到9(白名单)， 密码限制不包含汉字（黑名单）
              inputFormatters: (widget.keyboardType == TextInputType.number ||
                      widget.keyboardType == TextInputType.phone)
                  ? [WhitelistingTextInputFormatter(RegExp('[0-9]'))]
                  : [BlacklistingTextInputFormatter(RegExp('[\u4e00-\u9fa5]'))],
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                      color: Styles.colorGray,
                      fontSize: ScreenUtil().setSp(28),
                      fontWeight: FontWeight.w500),
                  counterText: '',
                  prefixIcon: Padding(
                      //padding: EdgeInsets.only(left: ScreenUtil().setWidth(32)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 0),
                      child: Image.asset(widget.iconName,
                          height: ScreenUtil().setHeight(35),
                          width: ScreenUtil().setWidth(44))),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: themeData.primaryColor, width: 0.8)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).dividerTheme.color,
                          width: 0.8))),
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _isShowDelete
                ? Styles.empty
                : Semantics(
                    label: '清空',
                    hint: '清空输入框',
                    child: GestureDetector(
                      child: LoadAssetImage(
                        'login/qyg_shop_icon_delete.png',
                        key: Key('${widget.keyName}_delete'),
                        width: 18.0,
                        height: 40.0,
                      ),
                      onTap: () => widget.controller.text = '',
                    ),
                  ),
            !widget.isInputPwd ? Styles.empty : Styles.hGap15,
            !widget.isInputPwd
                ? Styles.empty
                : Semantics(
                    label: '密码可见开关',
                    hint: '密码是否可见',
                    child: GestureDetector(
                      child: LoadAssetImage(
                        _isShowPwd
                            ? 'login/qyg_shop_icon_display.png'
                            : 'login/qyg_shop_icon_hide.png',
                        key: Key('${widget.keyName}_showPwd'),
                        width: 18.0,
                        height: 40.0,
                      ),
                      onTap: () {
                        setState(() {
                          _isShowPwd = !_isShowPwd;
                        });
                      },
                    ),
                  ),
            widget.getVCode == null ? Styles.empty : Styles.hGap15,
            widget.getVCode == null
                ? Styles.empty
                : Theme(
                    data: Theme.of(context).copyWith(
                      buttonTheme: ButtonThemeData(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 2),
                        height: ScreenUtil().setHeight(68),
                        minWidth: ScreenUtil().setWidth(180),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                    child: FlatButton(
                      onPressed: _isClick ? _getVCode : null,
                      textColor: Styles.colorThemeText,
                      color: Styles.colorTheme,
                      disabledTextColor:
                          isDark ? Styles.colorDark : Colors.white,
                      disabledColor: isDark
                          ? Styles.colorDark
                          : Styles.colorGray,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(ScreenUtil().setWidth(20)),
                          side: BorderSide(
                            color: _isClick
                                ? themeData.primaryColor
                                : Colors.transparent,
                            width: 0.8,
                          )),
                      child: Text(
                        _isClick ? '获取验证码' : '（$_currentSecond s）',
                        style: TextStyle(fontSize: 12.ssp),
                      ),
                    ),
                  )
          ],
        )
      ],
    );
  }
}
