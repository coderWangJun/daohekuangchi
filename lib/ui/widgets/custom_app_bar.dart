import 'package:dh/res/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dh/utils/index.dart';

// 自定义AppBar
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {Key key,
      this.backgroundColor: Styles.colorTheme,
      this.title: '',
      this.centerTitle: '',
      this.actionName: '',
      this.fontSize: 18,
      this.fontWeight: FontWeight.w600,
      this.color: Colors.white,
      this.backImg: 'assets/images/fanhui_icon.png',
      this.onPressed,
      this.onBack,
      this.iconColor: Colors.white,
      this.isBack: true,
      this.isLogo:false,
      this.logoImg,
        this.logoWidth,
      this.isRefresh: false})
      : super(key: key);

  final Color backgroundColor;
  final String title;
  final String centerTitle;
  final String backImg;
  final String actionName;
  final VoidCallback onPressed;
  final bool isBack;
  final bool isLogo;
  final String logoImg;
  final Color iconColor;
  final bool isRefresh;
  final double fontSize;
  final double logoWidth;
  final FontWeight fontWeight;
  final Color color;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    Color _backgroundColor;

    if (backgroundColor == null) {
      _backgroundColor = Styles.colorBackgroundColor;
    } else {
      _backgroundColor = backgroundColor;
    }

    SystemUiOverlayStyle _overlayStyle =
        ThemeData.estimateBrightnessForColor(_backgroundColor) ==
                Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark;

    var back = isBack
        ? IconButton(
            onPressed: () {
              FocusScope.of(context).unfocus();

              if (onBack != null) {
                onBack();
              } else {
                isRefresh
                    ? Navigator.of(context).pop(true)
                    : Navigator.maybePop(context);
              }
            },
            tooltip: '返回',
            padding: const EdgeInsets.all(10.0),
            icon: Image.asset(backImg,
                color: iconColor, width: 48.w, height: 48.w),
          )
        : const SizedBox.shrink();

    var action = actionName.isNotEmpty
        ? Positioned(
            right: 0.0,
            child: Theme(
              data: Theme.of(context).copyWith(
                  buttonTheme: ButtonThemeData(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                minWidth: 60.0,
              )),
              child: FlatButton(
                child: Text(
                  actionName,
                  key: const Key('actionName'),
                  style: Styles.theme(
                      fontSize: 32.ssp,
                      fontWeight: FontWeight.w400,
                      color: Styles.colorWhite),
                ),
                textColor: Styles.colorWhite,

                //highlightColor: Colors.transparent,
                onPressed: onPressed,
              ),
            ),
          )
        : const SizedBox.shrink();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _overlayStyle,
      child: Material(
        color: _backgroundColor,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[

              Semantics(
                image: true,
                namesRoute: true,
                header: true,
                child: Container(
                  alignment: centerTitle.isEmpty
                      ? Alignment.centerLeft
                      : Alignment.center,
                  width: double.infinity,
                  child:Text.rich(TextSpan(
                    children:<InlineSpan>[
                      WidgetSpan(
                        child: isLogo==true
                            ?
                        Container(
                          margin: EdgeInsets.only(right: 11.w),
                          child: Image.asset(logoImg,
                            width: logoWidth==null?48.w:logoWidth,
                            height: logoWidth==null?48.w:44.w,),
                        )
                            :Container(height:0.0,width:0.0)
                      ),
                      WidgetSpan(
                        child: Text(title.isEmpty ? centerTitle : title,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: fontSize,
                                fontWeight: this.fontWeight)),
                      )
                    ]

                  )),

                  margin: const EdgeInsets.symmetric(horizontal: 48.0),
                ),
              ),
              back,
              action,
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(48);
}
