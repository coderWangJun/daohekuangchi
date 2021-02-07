import 'package:dh/res/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dh/utils/index.dart';

abstract class Alert {
  static show(BuildContext context,
      {VoidCallback onOk,
      VoidCallback onCancel,
      Widget child,
      String title,
      double width,
      double height,
      double contentHeight,
      bool isPop: true,
      bool isBgPop: true,
      bool isSuccess: true,
      double padTop,
      String content,
      String cancelTitle,
      String actionTitle,
      Alignment alignment,
      bool isOk: true,
      Color bgColor: Colors.white,
      Color titleColor: Colors.white,
      Color contentColor: Colors.white,
      Color isCancelColor: Colors.white,
      Color isOkColor: Colors.white,
      bool isCancel: false}) {
    showDialog(
      builder: (context) {
        return AlertView(
          onOk: onOk,
          onCancel: onCancel,
          child: child,
          isBgPop: isBgPop,
          isPop: isPop,
          height: height,
          contentHeight: contentHeight,
          width: width,
          isSuccess: isSuccess,
          padTop: padTop,
          content: content,
          actionTitle: actionTitle,
          cancelTitle: cancelTitle,
          alignment: alignment,
          isCancel: isCancel,
          isOk: isOk,
        );
      },
      context: context,
    );
  }
}

class AlertView extends StatelessWidget {
  final VoidCallback onOk;
  final VoidCallback onCancel;
  final Widget child;
  final String title;
  final String actionTitle;
  final String cancelTitle;
  final Alignment alignment;
  final double width;
  final double height;
  final double contentHeight;
  final bool isPop;
  final bool isBgPop;
  final bool isOk;
  final bool isCancel;
  final String content;
  final bool isSuccess;
  final double padTop;

  const AlertView(
      {Key key,
      this.child,
      this.onOk,
      this.onCancel,
      this.title = '',
      this.height,
      this.contentHeight,
      this.width,
      this.isPop: true,
      this.isBgPop: true,
      this.isOk: true,
      this.isCancel: false,
      this.actionTitle,
      this.alignment,
      this.content,
      this.isSuccess: true,
      this.padTop,
      this.cancelTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double btn = isOk && isCancel ? 264.w : 560.w;
    double tw = width == null ? 560.w : width;
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          if (isBgPop) Navigator.pop(context);
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          alignment: alignment == null ? Alignment.center : alignment,
          child: Container(
            width: tw,
            height: height == null ? 332.h : height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.w)),
                color: Color(0xff20202A)),
            child: Column(
              children: <Widget>[
                Container(
                  height: contentHeight == null ? 240.h : contentHeight,
                  padding: EdgeInsets.only(top: padTop == null ? 40.h : padTop),
                  child: child == null
                      ? Container(
                          width: tw * 0.9,
                          alignment: Alignment.center,
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(bottom: 30.h),
                                child: Text("提示",
                                    style: TextStyle(
                                        fontSize: 32.sp, color: Colors.white)),
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      content,
                                      softWrap: true,
                                      textAlign: TextAlign.center,
                                      style: Styles.theme(
                                          fontSize: 32.ssp,
                                          fontWeight: FontWeight.w400,
                                          color: isSuccess
                                              ? Styles.colorFFFFFF
                                              : Styles.colorFFFFFF),
                                    ),
                                  ),
                                )
                              ),
                            ],
                          ))
                      : child,
                ),
                Container(
                  height: 92.h,
                  child: Row(
                    children: <Widget>[
                      Visibility(
                        visible: isCancel,
                        child: Expanded(
                            child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            if (onCancel != null) onCancel();
                          },
                          child: Container(
                            height: 92.h,
                            width: btn,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: Color(0xff343A4A)),
                            child: Text(
                              cancelTitle ?? '取消',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xffB2C6EA),
                                  fontSize: 32.ssp),
                            ),
                          ),
                        )),
                      ),
                      //Padding(padding: EdgeInsets.only(right: 10.w)),
                      Visibility(
                        visible: isOk,
                        child: Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (isPop) Navigator.pop(context);
                              if (onOk != null) onOk();
                            },
                            child: Container(
                              height: 92.h,
                              width: btn,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Color(0xff4A90EA),
                              ),
                              child: Text(
                                actionTitle ?? '确定',
                                style: TextStyle(
                                    color: Styles.colorFFFFFF,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 32.ssp),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
