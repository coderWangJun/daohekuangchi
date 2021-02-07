import 'package:dh/res/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dh/utils/index.dart';

abstract class PopAlert {
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
        bool isCancel: false}) {
    showDialog(
      builder: (context) {
        return PopAlertView(
          onOk: onOk,
          onCancel: onCancel,
          child: child,
          isBgPop:isBgPop,
          isPop: isPop,
          height: height,
          contentHeight:contentHeight,
          width: width,
          isSuccess: isSuccess,
          padTop:padTop,
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

class PopAlertView extends StatefulWidget {
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

  const PopAlertView(
      {Key key,
        this.child,
        this.onOk,
        this.onCancel,
        this.title = '',
        this.height,
        this.contentHeight,
        this.width,
        this.isPop: true,
        this.isBgPop:true,
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
  _PopAlertViewState createState() => _PopAlertViewState();
}

class _PopAlertViewState extends State<PopAlertView> {
  @override
  Widget build(BuildContext context) {
    double btn = widget.isOk && widget.isCancel ? 264.w : 538.w;
    double tw = widget.width == null ? 538.w : widget.width;
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          if (widget.isBgPop) Navigator.pop(context);
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          alignment: widget.alignment == null?Alignment.center:widget.alignment,
          child: Container(
            width: tw,
            height: widget.height == null ? 300.h : widget.height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.w)),
                color: Styles.color161D30),
            child: Column(
              children: <Widget>[
                Container(
                  height: widget.contentHeight==null? 188.h :widget.contentHeight,
                  padding: EdgeInsets.only(top: widget.padTop==null?80.h:widget.padTop),
                  child: widget.child == null
                      ? Container(
                    width: tw * 0.9,
                    alignment: Alignment.center,
                    child: Text(
                      widget.content,
                      softWrap: true,
                      style: Styles.theme(
                          fontSize: 32.ssp,
                          fontWeight: FontWeight.w500,
                          color: widget.isSuccess
                              ? Styles.color5591EF
                              : Styles.colorFA9645),
                    ),
                  )
                      : widget.child,
                ),
                widget.onOk != null?
                Container(
                  margin: EdgeInsets.only(top: 20.h),
                  height: 92.h,
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: Styles.colorE5E5E5, width: 1.h))),
                  child: Row(
                    children: <Widget>[
                      Visibility(
                        visible: widget.isCancel,
                        child: Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                if (widget.onCancel != null) widget.onCancel();
                              },
                              child: Container(
                                height: 92.h,
                                width: btn,
                                alignment: Alignment.center,
                                child: Text(
                                  widget.cancelTitle ?? '取消',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Styles.color666666,
                                      fontSize: 32.ssp),
                                ),
                              ),
                            )),
                      ),
                      //Padding(padding: EdgeInsets.only(right: 10.w)),
                      Visibility(
                        visible: widget.isOk,
                        child: Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (widget.isPop) Navigator.pop(context);
                              if (widget.onOk != null) widget.onOk();
                            },
                            child: Container(
                              height: 92.h,
                              width: btn,
                              alignment: Alignment.center,
                              child: Text(
                                widget.actionTitle ?? '确定',
                                style: TextStyle(
                                    color: Styles.color666666,
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
                    :Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

