import 'package:dh/res/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dh/ui/widgets/custom_text.dart';
import 'package:dh/utils/index.dart';

/// 封装输入框
class CustomTextFieldItem extends StatelessWidget {
  const CustomTextFieldItem(
      {Key key,
      this.controller,
      @required this.title,
      this.keyboardType: TextInputType.text,
      this.hintText: '',
      this.hintColor,
      this.focusNode,
      this.onTap,
      this.readOnly: false,
      this.isPassword: false,
      this.onChanged,
      this.bgColor: Colors.white,
      this.width: 90,
      this.getVCode,
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

  //输入类型
  final String inputType;
  final double width;
  final Future<bool> Function() getVCode;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 120.h,
        padding: EdgeInsets.only(left: 24.w),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: this.width,
                  child: CustomText(
                    title,
                    fontSize: 30,
                    color: Styles.colorThemeText,
                  ),
                ),
                Visibility(
                  visible: inputType == "text",
                  child: Expanded(
                    child: Semantics(
                      label: hintText.isEmpty ? '请输入$title' : hintText,
                      child: TextField(
                          focusNode: focusNode,
                          readOnly: readOnly,
                          textAlign: TextAlign.start,
                          keyboardType: keyboardType,
                          obscureText: isPassword,
                          inputFormatters: _getInputFormatters(),
                          controller: controller,
                          onChanged: (text) {
                            onChanged(text);
                          },
                          decoration: InputDecoration(
                            hintText: hintText,
                            hintStyle: TextStyle(
                                color: hintColor != null
                                    ? hintColor
                                    : Color.fromRGBO(176, 176, 176, 1),
                                fontSize: ScreenUtil().setSp(28)),
                            border: InputBorder.none, //去掉下划线
                            //hintStyle: TextStyles.textGrayC14
                          )),
                    ),
                  ),
                ),
                Visibility(
                  visible: inputType == "Dropdown",
                  child: Container(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(190)),
                    child: Row(
                      children: <Widget>[
                        CustomText(hintText, color: Styles.colorGray),
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
                inputType == "Dropdown" ? Styles.hGap4 : Styles.hGap16
              ],
            ),
            Container(
              height: 1.h,
              width: 726.w,
              color: Color.fromRGBO(199, 199, 199, 1),
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
        ),
      ),
    );
  }

  _getInputFormatters() {
    if (keyboardType == TextInputType.numberWithOptions(decimal: true)) {
      return [];
    }
    if (keyboardType == TextInputType.number ||
        keyboardType == TextInputType.phone) {
      return [WhitelistingTextInputFormatter.digitsOnly];
    }
    return null;
  }
}
