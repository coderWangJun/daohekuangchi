import 'package:dh/res/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dh/ui/widgets/custom_button.dart';
import 'package:dh/utils/index.dart';

class CustomDialog extends StatefulWidget {
  final String title; //弹窗标题
  final String content; //弹窗内容
  final String confirmContent; //按钮文本
  final Color confirmTextColor; //确定按钮文本颜色
  final bool isCancel; //是否有取消按钮，默认为true true：有 false：没有
  final bool isConfirm; //是否有确定按钮，默认为true true：有 false：没有
  final Color confirmColor; //确定按钮颜色
  final Color cancelColor; //取消按钮颜色
  final bool outsideDismiss; //点击弹窗外部，关闭弹窗，默认为true true：可以关闭 false：不可以关闭
  final Function confirmCallback; //点击确定按钮回调
  final Function cancelCallback; //点击取消按钮回调
  final Function dismissCallback; //弹窗关闭回调

  final double top;
  final double left;
  final double right;
  final double height;
  final double width;
  final String cancelText;
  final String confirmText;
  final double cancelTextWidth;
  final double cancelTextHeight;
  final double confirmTextWidth;
  final double confirmTextHeight;

  //图片高宽
  final double imgWidth;
  final double imgHeight;

  //文字距图片上下间距
  final double textPaddingTop;
  final double textPaddingBottom;

  //按钮与上面内容间距
  final double btnPaddingTop;
  final double btnPaddingBottom;

  final String image; //dialog添加图片
  final String imageHintText; //图片下方的文本提示

  final Widget child;

  //按钮个数
  final int btn;

  const CustomDialog(
      {Key key,
      this.title: "",
      this.content,
      this.confirmContent,
      this.confirmTextColor,
      this.isCancel = true,
      this.isConfirm = true,
      this.btn: 2,
      this.confirmColor,
      this.cancelColor,
      this.outsideDismiss = true,
      this.confirmCallback,
      this.cancelCallback,
      this.dismissCallback,
      this.image,
      this.imageHintText,
      this.width,
      this.height,
      this.top: 60,
      this.left: 120,
      this.right: 120,
      this.imgHeight: 300,
      this.imgWidth: 300,
      this.cancelTextWidth: 140,
      this.cancelTextHeight: 65,
      this.confirmTextWidth: 140,
      this.confirmTextHeight: 65,
      this.textPaddingTop: 40,
      this.textPaddingBottom: 0,
      this.btnPaddingTop: 60,
      this.btnPaddingBottom: 0,
      this.child,
      this.cancelText = "取消",
      this.confirmText = "确定"})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CustomDialogState();
  }
}

class _CustomDialogState extends State<CustomDialog> {
  _confirmDialog() {
    _dismissDialog();
    if (widget.confirmCallback != null) {
      widget.confirmCallback();
    }
  }

  _dismissDialog() {
    if (widget.dismissCallback != null) {
      widget.dismissCallback();
    } else {
      Navigator.of(context).pop();
    }
  }

  _cancelDialog() {
    if (widget.cancelCallback != null) {
      widget.cancelCallback();
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    Container container = new Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(widget.top)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Visibility(
            child: Container(
              child: Text(widget.title,
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(36),
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(26, 26, 26, 1))),
            ),
            visible: widget.title.isNotEmpty,
          ),
          Styles.vGap8,
          Expanded(
              child: Center(
                child: Text(widget.content == null ? '' : widget.content,
                    style: TextStyle(fontSize: 14.0)),
              ),
              flex: 1),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(widget.left),
                right: ScreenUtil().setWidth(widget.right),
                bottom: ScreenUtil().setHeight(45)),
            child: Row(
              mainAxisAlignment: widget.btn == 2
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                widget.isCancel
                    ? new Container(
                        width: ScreenUtil().setWidth(widget.cancelTextWidth),
                        height: ScreenUtil().setHeight(widget.cancelTextHeight),
                        decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.all(
                                new Radius.circular(ScreenUtil().setWidth(20))),
                            color: Color.fromRGBO(230, 246, 241, 1)),
                        child: CupertinoButton(
                          padding: EdgeInsets.all(0),
                          child: Text(
                            this.widget.cancelText,
                            style: TextStyle(
                                color: Color.fromRGBO(3, 161, 116, 1),
                                fontSize: ScreenUtil().setSp(28)),
                          ),
                          onPressed: _cancelDialog,
                        ))
                    : Text(" "),
                widget.isConfirm
                    ? Container(
//                        width: ScreenUtil().setWidth(widget.confirmTextWidth),
//                        height:
//                            ScreenUtil().setHeight(widget.confirmTextHeight),
                        decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.all(
                                new Radius.circular(ScreenUtil().setWidth(20))),
                            color: widget.confirmColor),
                        child: CupertinoButton(
                          padding: EdgeInsets.all(0),
                          child: Text(
                            this.widget.confirmText,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(28)),
                          ),
                          onPressed: _confirmDialog,
                        ))
                    : Text("")
              ],
            ),
          )
        ],
      ),
    );
    Container imgContainer = new Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(widget.top)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
              image: AssetImage(widget.image == null ? '' : widget.image),
              width: ScreenUtil().setWidth(widget.imgWidth),
              height: ScreenUtil().setHeight(widget.imgHeight)),
          Padding(
            padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(widget.textPaddingTop),
                left: ScreenUtil().setWidth(12),
                bottom: ScreenUtil().setHeight(widget.textPaddingBottom)),
            child: Text(
                widget.imageHintText == null ? "" : widget.imageHintText,
                softWrap: true,
                maxLines: 3,
                style: TextStyle(fontSize: ScreenUtil().setSp(36))),
          ),
          (widget.isConfirm || widget.isCancel)
              ? Container(
                  padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(widget.btnPaddingTop),
                      bottom: ScreenUtil().setHeight(widget.btnPaddingBottom)),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: widget.btn==2
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      widget.isCancel
                          ? new Container(
                              width:
                                  ScreenUtil().setWidth(widget.cancelTextWidth),
                              height: ScreenUtil()
                                  .setHeight(widget.cancelTextHeight),
                              decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(
                                          ScreenUtil().setWidth(20))),
                                  color: Color.fromRGBO(230, 246, 241, 1)),
                              child: CupertinoButton(
                                child: Text(
                                  this.widget.cancelText,
                                  style: TextStyle(
                                      color: Color.fromRGBO(3, 161, 116, 1),
                                      fontSize: ScreenUtil().setSp(28)),
                                ),
                                onPressed: _cancelDialog,
                              ))
                          : Text(" "),
                      widget.isConfirm
                          ? Container(
                              decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(
                                          ScreenUtil().setWidth(20))),
                                  color: widget.confirmColor),
                              child: CustomButton(widget.confirmText,
	                              width: ScreenUtil().setWidth(widget.confirmTextWidth),
	                              height: ScreenUtil().setHeight(widget.confirmTextHeight),
	                              onPressed: _confirmDialog,
                              ))
                          : Text("")
                    ],
                  ),
                )
              : Text("")
        ],
      ),
    );

    Container childContainer = new Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: ScreenUtil().setHeight(widget.top)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Visibility(
              child: Container(
                child: Text(widget.title,
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(36),
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(26, 26, 26, 1))),
              ),
              visible: widget.title.isNotEmpty,
            ),
            Expanded(child: widget.child, flex: 2),
            (widget.isConfirm || widget.isCancel)
                ? Container(
                    padding: EdgeInsets.only(
                        top: ScreenUtil().setHeight(widget.btnPaddingTop),
                        bottom:
                            ScreenUtil().setHeight(widget.btnPaddingBottom)),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: (widget.isConfirm && widget.isCancel)
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        widget.isCancel
                            ? new Container(
                                width: ScreenUtil()
                                    .setWidth(widget.cancelTextWidth),
                                height: ScreenUtil()
                                    .setHeight(widget.cancelTextHeight),
                                decoration: new BoxDecoration(
                                    borderRadius: new BorderRadius.all(
                                        new Radius.circular(
                                            ScreenUtil().setWidth(20))),
                                    color: Color.fromRGBO(230, 246, 241, 1)),
                                child: CupertinoButton(
                                  child: Text(
                                    this.widget.cancelText,
                                    style: TextStyle(
                                        color: Color.fromRGBO(3, 161, 116, 1),
                                        fontSize: ScreenUtil().setSp(28)),
                                  ),
                                  onPressed: _cancelDialog,
                                ))
                            : Text(" "),
                        widget.isConfirm
                            ? Container(
                                width: ScreenUtil()
                                    .setWidth(widget.confirmTextWidth),
                                height: ScreenUtil()
                                    .setHeight(widget.confirmTextHeight),
                                decoration: new BoxDecoration(
                                    borderRadius: new BorderRadius.all(
                                        new Radius.circular(
                                            ScreenUtil().setWidth(20))),
                                    color: widget.confirmColor),
                                child: CupertinoButton(
                                  child: Text(
                                    this.widget.confirmText,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ScreenUtil().setSp(28)),
                                  ),
                                  onPressed: _confirmDialog,
                                ))
                            : Text("")
                      ],
                    ),
                  )
                : Text("")
          ],
        ));
    return WillPopScope(
        child: GestureDetector(
          onTap: () {
            widget.outsideDismiss ? _dismissDialog() : null;
          },
          child: Material(
            type: MaterialType.transparency,
            child: Center(
              child: Container(
                width: this.widget.width,
                height: this.widget.height,
                alignment: Alignment.center,
                child: widget.child == null
                    ? (widget.image == null ? container : imgContainer)
                    : childContainer,
                decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setSp(20))),
              ),
            ),
          ),
        ),
        onWillPop: () async {
          return widget.outsideDismiss;
        });
  }
}
