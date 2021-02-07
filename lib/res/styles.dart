import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class Styles {
  static const colorTheme = Color(0xFF498FEA);
  static const colorBackgroundColor = Color(0xFF161D30);
  static const colorText = Color(0xFFFFFFFF);
  static const colorThemeText = Color(0xFF333333);
  static const colorGray = Color.fromRGBO(179, 179, 179, 1);
  static const colorDark = Color(0xFFB3B3B3);
  static const colorFFFFFF = Color(0xFFFFFFFF);

  static const colorRed = Color(0xFFEB3434);
  static const colorBlack = Color(0xFF333333);
  static const colorBlue = Color(0xFF2D63CA);
  static const colorWhite = Colors.white;
  static const color161E30 = Color(0xFF161E30);
  static const colorF8F8F8 = Color(0xFFF8F8F8);
  static const color999999 = Color(0xFF999999);
  static const color333333 = Color(0xFF333333);
  static const color343434 = Color(0xFF343434);
  static const colorF9F9F9 = Color(0xFFF9F9F9);
  static const color207EF1 = Color(0xFF207EF1);
  static const color4C94F1 = Color(0xFF4C94F1);
  static const color5591EF = Color(0xff5591EF);
  static const colorEF5555 = Color(0xffEF5555);
  static const color498FEA = Color(0xff498FEA);

  static const colorC7A169 = Color(0xFFC7A169);
  static const color17BAC3 = Color(0xFF17BAC3);
  static const colorF4F4F4 = Color(0xFFF4F4F4);
  static const colorECECEC = Color(0xFFECECEC);
  static const colorFF9D4D = Color(0xFFFF9D4D);
  static const color44C2C9 = Color(0xFF44C2C9);

  static const colorFA9645 = Color(0xFFFA9645);
  static const color265E8D = Color(0xFF265E8D);
  static const color022D3E = Color(0xFF022D3E);
  static const color4BBF84 = Color(0xFF4BBF84);
  static const color666666 = Color(0xFF666666);
  static const color58CD92 = Color(0xFF58CD92);
  static const colorCCCCCC = Color(0xFFCCCCCC);
  static const colorC9C9C9 = Color(0xFFC9C9C9);
  static const color27B4CD = Color(0xFF27B4CD);
  static const colorE5E5E5 = Color(0xFFE5E5E5);

  static const colorADADAD = Color(0xFFADADAD);

  static const colorFFF8D1 = Color(0xFFFFF8D1);
  static const color3A86E8 = Color(0xFF3A86E8);
  static const color4885DE = Color(0xFF4885DE);
  static const colorF6F6F6 = Color(0xFFF6F6F6);
  static const colorF3F3F3 = Color(0xFFF3F3F3);
  static const colorE84546 = Color(0xFFE84546);
  static const colorAAAAAA = Color(0xFFAAAAAA);
  static const color9A9A9A = Color(0xFF9A9A9A);
  static const color1D2537 = Color(0xFF1D2537);
  static const colorF75A5A = Color(0xFFF75A5A);
  static const colorB1C5E9 = Color(0xFFB1C5E9);
  static const colorA5A5A5 = Color(0xFFA5A5A5);
  static const colorFF5F59 = Color(0xFFFF5F59);
  static const color2B3347 = Color(0xFF2B3347);
  static const color4D98F6 = Color(0xFF4D98F6);
  static const color21293C = Color(0xFF21293C);
  static const color60D487 = Color(0xFF60D487);


  //道和APP
  static const color161D30 = Color(0xFf161D30);
  static const color73AAFF = Color(0xFf73AAFF);
  static const color98C1FF = Color(0xFF98C1FF);
  static const color1E2638 = Color(0xFF1E2638);
  static const color1E2538 = Color(0xFF1E2538);
  static const colorB2C6EA = Color(0xFFB2C6EA);
  static const color4A90EA = Color(0xFF4A90EA);
  static const color2B3448 = Color(0xFF2B3448);
  static const color2C3448= Color(0xFF2C3448);
  static const colorB1C6EA = Color(0xFFB1C6EA);
  static const colorFFD454 = Color(0xFFFFD454);
  static const colorFF6F6F = Color(0xFFFF6F6F);
  static const color4A8AEB = Color(0xFF4A8AEB);
  static const colorE1E1E1 = Color(0xFFE1E1E1);
  static const color0D1220 = Color(0xFF0D1220);
  static const color00C6BE = Color(0xFF00C6BE);
  static theme(
      {double fontSize,
      Color color,
      FontWeight fontWeight: FontWeight.w400,
      double height,
      TextBaseline textBaseline: TextBaseline.alphabetic}) {
    return TextStyle(
        fontFamily: 'PingFangSC',
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        height: height,
        textBaseline: textBaseline);
  }

  static appBar({String title}) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        title,
        style: theme(fontSize: 18, color: colorTheme),
      ),
    );
  }

  static themeAppBar(
    BuildContext context, {
    String title = '',
    String actionTitle,
    TextStyle actionStyle,
    bool hideBack = false,
    final VoidCallback action,
  }) {
    return AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          title,
          style: Styles.theme(fontSize: 18, color: colorTheme),
        ),
        leading: Offstage(
          offstage: hideBack,
          child: IconButton(
            icon: Image.asset(
              'assets/image/mine/nav_back.png',
              width: 29,
              height: 15,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        actions: <Widget>[
          MaterialButton(
            child: Text(
              actionTitle ?? '',
              style: actionStyle ??
                  TextStyle(
                      fontSize: 12,
                      color: Styles.colorBlue,
                      fontWeight: FontWeight.normal),
            ),
            onPressed: action,
          )
        ]);
  }

  static const double font_sp10 = 10.0;
  static const double font_sp12 = 12.0;
  static const double font_sp14 = 14.0;
  static const double font_sp15 = 15.0;
  static const double font_sp16 = 16.0;
  static const double font_sp18 = 18.0;
  static const double font_sp20 = 20.0;

  static const double gap_dp4 = 4;
  static const double gap_dp5 = 5;
  static const double gap_dp8 = 8;
  static const double gap_dp10 = 10;
  static const double gap_dp12 = 12;
  static const double gap_dp15 = 15;
  static const double gap_dp16 = 16;
  static const double gap_dp24 = 24;
  static const double gap_dp32 = 32;
  static const double gap_dp50 = 50;

  /// 水平间隔
  static const Widget hGap4 = const SizedBox(width: gap_dp4);
  static const Widget hGap5 = const SizedBox(width: gap_dp5);
  static const Widget hGap8 = const SizedBox(width: gap_dp8);
  static const Widget hGap10 = const SizedBox(width: gap_dp10);
  static const Widget hGap12 = const SizedBox(width: gap_dp12);
  static const Widget hGap15 = const SizedBox(width: gap_dp15);
  static const Widget hGap16 = const SizedBox(width: gap_dp16);
  static const Widget hGap32 = const SizedBox(width: gap_dp32);
  static const Widget hGap30 = const SizedBox(width: 30);

  /// 垂直间隔
  static const Widget vGap4 = const SizedBox(height: gap_dp4);
  static const Widget vGap5 = const SizedBox(height: gap_dp5);
  static const Widget vGap8 = const SizedBox(height: gap_dp8);
  static const Widget vGap10 = const SizedBox(height: gap_dp10);
  static const Widget vGap12 = const SizedBox(height: gap_dp12);
  static const Widget vGap15 = const SizedBox(height: gap_dp15);
  static const Widget vGap16 = const SizedBox(height: gap_dp16);
  static const Widget vGap24 = const SizedBox(height: gap_dp24);
  static const Widget vGap32 = const SizedBox(height: gap_dp32);
  static const Widget vGap50 = const SizedBox(height: gap_dp50);

  static const Widget empty = const SizedBox.shrink();
}
