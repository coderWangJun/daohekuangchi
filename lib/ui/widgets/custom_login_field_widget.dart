import 'dart:async';
import 'dart:math';

import 'package:dh/res/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dh/utils/index.dart';
import 'package:hb_check_code/hb_check_code.dart';

typedef imgCodeCallBack = void Function(String imgCode);

/// 登录页面表单字段框封装类
// ignore: must_be_immutable
class CustomLoginTextField extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool obscureText;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final ValueChanged<String> onFieldSubmitted;
  final String iconName;
  final TextInputType textInputType;
  final TextInputType keyboardType;
  final bool isSuffixIcon;
  final Future<bool> Function() getVCode;
  final imgCodeCallBack getImageCode;
  final int imgCodeLength;
  String imgCode;
  final bool clear;
  final Widget prefix;
  final TextStyle hintStyle;
  final bool readonly;

  CustomLoginTextField(
      {this.label,
      this.icon,
      this.iconName,
      this.controller,
      this.obscureText: false,
      this.validator,
      this.focusNode,
      this.keyboardType: TextInputType.text,
      this.textInputAction,
      this.onFieldSubmitted,
      this.isSuffixIcon: true,
      this.getVCode,
      this.getImageCode,
      this.imgCodeLength: 4,
      this.imgCode,
      this.clear: true,
      this.prefix,
      this.readonly: false,
      this.hintStyle,
      this.textInputType: TextInputType.text});

  @override
  _CustomLoginTextFieldState createState() => _CustomLoginTextFieldState();
}

class _CustomLoginTextFieldState extends State<CustomLoginTextField> {
  TextEditingController controller;
  String iconName;

  //图形验证码
  String code = "";

  /// 默认遮挡密码
  ValueNotifier<bool> obscureNotifier;

  bool _isClick = true;

  /// 倒计时秒数
  final int _second = 30;

  /// 当前秒数
  int _currentSecond;
  StreamSubscription _subscription;

  @override
  void initState() {
    controller = widget.controller ?? TextEditingController();
    obscureNotifier = ValueNotifier(widget.obscureText);
    super.initState();
  }

  @override
  void dispose() {
    obscureNotifier.dispose();
    // 默认没有传入controller,需要内部释放
    if (widget.controller == null) {
      controller.dispose();
    }
    _subscription?.cancel();
    widget.controller?.removeListener(() {});
    //widget.controller?.dispose();
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
    return new Container(
        height: 100.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(150.w)),
            border: Border.all(color: Styles.color498FEA, width: 1)),
        child: Row(
          children: <Widget>[
            Visibility(
              visible: widget.prefix != null,
              child: widget.prefix == null ? Container() : widget.prefix,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                  left: 20.w,
                  right: 20.w,
                ),
                child: ValueListenableBuilder(
                    valueListenable: obscureNotifier,
                    builder: (context, value, child) => TextFormField(
                        readOnly: widget.readonly,
                        controller: controller,
                        obscureText: value,
                        validator: (text) {
                          var validator = widget.validator ?? (_) => null;
                          return text.trim().length > 0
                              ? validator(text)
                              : "输入框不能为空";
                        },
                        textAlignVertical: TextAlignVertical.bottom,
                        style: TextStyle(color: Styles.colorWhite,fontSize: 30.ssp),
                        focusNode: widget.focusNode,
                        textInputAction: widget.textInputAction,
                        onFieldSubmitted: widget.onFieldSubmitted,
                        keyboardType: widget.keyboardType,
                        inputFormatters: (widget.keyboardType ==
                                    TextInputType.number ||
                                widget.keyboardType == TextInputType.phone)
                            ? [WhitelistingTextInputFormatter(RegExp('[0-9]'))]
                            : [
                                BlacklistingTextInputFormatter(
                                    RegExp('[\u4e00-\u9fa5]'))
                              ],
                        textCapitalization: TextCapitalization.characters,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: widget.label,
                          //contentPadding: EdgeInsets.only(top: 5.h,bottom: 0.h),
                          hintStyle: widget.hintStyle == null
                              ? TextStyle(
                                  textBaseline: TextBaseline.alphabetic,
                                  fontSize: 28.ssp,
                                  color: Styles.colorWhite,
                                  fontWeight: FontWeight.w400)
                              : widget.hintStyle,
                          suffixIcon: widget.isSuffixIcon
                              ? LoginTextFieldSuffixIcon(
                                  clear: widget.clear,
                                  controller: controller,
                                  obscureText: widget.obscureText,
                                  obscureNotifier: obscureNotifier,
                                )
                              : null,
                        ))),
              ),
            ),
            widget.getVCode == null
                ? Styles.empty
                : Theme(
                    data: Theme.of(context).copyWith(
                      buttonTheme: ButtonThemeData(
                        height: 64.h,
                        minWidth: 196.w,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                    child: FlatButton(
                      onPressed: _isClick ? _getVCode : null,
                      textColor: Styles.color4885DE,
                      //color: Styles.colorTheme,
                      disabledTextColor:
                          isDark ? Styles.colorDark : Colors.white,
                      disabledColor:
                          isDark ? Styles.colorDark : Styles.colorGray,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.w),
                          side: BorderSide(
                            color: _isClick
                                ? Styles.color4885DE
                                : Colors.transparent,
                            width: 0.8,
                          )),
                      child: Text(
                        _isClick ? '获取验证码' : '（$_currentSecond s）',
                        style: Styles.theme(
                            fontSize: 28.ssp,
                            color: Styles.color4885DE,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
            //获取图形验证码
            widget.getImageCode == null
                ? Styles.empty
                : Theme(
                    data: Theme.of(context).copyWith(
                      buttonTheme: ButtonThemeData(
//                      height: 64.h,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                    child: FlatButton(
                      onPressed: () {
                        //点击重新生成
                        widget.imgCode = "";
                        setState(() {
                          for (var i = 0; i < widget.imgCodeLength; i++) {
                            widget.imgCode =
                                widget.imgCode + Random().nextInt(9).toString();
                          }
                          widget.getImageCode(widget.imgCode);
                        });
                      },
                      textColor: Styles.color4885DE,
                      color: Color.fromRGBO(102, 102, 102, 1),
                      disabledTextColor:
                          isDark ? Styles.colorDark : Colors.white,
                      disabledColor:
                          isDark ? Styles.colorDark : Styles.colorGray,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.w),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: HBCheckCode(
                          code: widget.imgCode,
                          dotCount: 12,
                          width: 160.w,
                          height: 64.h,
                        ),
                      ),
                    ),
                  ),
          ],
        ));
  }
}

class LoginTextFieldSuffixIcon extends StatelessWidget {
  final TextEditingController controller;

  final ValueNotifier<bool> obscureNotifier;

  final bool obscureText;
  final bool clear;

  LoginTextFieldSuffixIcon(
      {this.controller, this.obscureNotifier, this.obscureText, this.clear});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Offstage(
          offstage: !obscureText,
          child: InkWell(
            onTap: () {
              //print(obscureNotifier.value);
              obscureNotifier.value = !obscureNotifier.value;
            },
            child: ValueListenableBuilder(
              valueListenable: obscureNotifier,
              builder: (context, value, child) => obscureNotifier.value
                  ? Image.asset(
                      "assets/images/common/show.png",
                      width: 56.w,
                      height: 56.w,
                    )
                  : Image.asset(
                      "assets/images/common/hide.png",
                      width: 56.w,
                      height: 56.w,
                    ),
            ),
          ),
        ),
        Visibility(
          visible: this.clear,
          child: LoginTextFieldClearIcon(controller),
        )
      ],
    );
  }
}

class LoginTextFieldClearIcon extends StatefulWidget {
  final TextEditingController controller;

  LoginTextFieldClearIcon(this.controller);

  @override
  _LoginTextFieldClearIconState createState() =>
      _LoginTextFieldClearIconState();
}

class _LoginTextFieldClearIconState extends State<LoginTextFieldClearIcon> {
  ValueNotifier<bool> notifier;

  @override
  void initState() {
    notifier = ValueNotifier(widget.controller.text.isEmpty);
    widget.controller.addListener(() {
      if (mounted) notifier.value = widget.controller.text.isEmpty;
    });
    super.initState();
  }

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: notifier,
      builder: (context, bool value, child) {
        return Offstage(
          offstage: value,
          child: child,
        );
      },
      child: InkWell(
          onTap: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              widget.controller.clear();
            });
          },
          child: Icon(CupertinoIcons.clear, size: 30, color: Colors.grey)),
    );
  }
}
