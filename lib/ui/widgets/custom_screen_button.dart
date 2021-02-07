import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dh/utils/index.dart';
import '../../res/styles.dart';

class ScreenButton extends StatefulWidget {
  ScreenButton({Key key, this.title, this.isSelected=false, this.itemWidth = 70.0,this.onTab}): super(key: key);

  final String title;
  final bool isSelected;
  final double itemWidth;
  final VoidCallback onTab;

  @override
  _ScreenButtonState createState() => _ScreenButtonState();
}

class _ScreenButtonState extends State<ScreenButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
//      margin: new EdgeInsets.only(right: 5.0),
      child: GestureDetector(
        onTap: widget.onTab,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
          decoration: BoxDecoration(
            border: Border.all(color: widget.isSelected ? Colors.blue : Color.fromRGBO(7, 141, 226,1)),
            borderRadius: BorderRadius.circular(5.w),
            color: widget.isSelected ? Styles.colorTheme : Colors.white,
          ),
          height: 32.0,
          width: widget.itemWidth,
          child: Text(
            widget.title,
            style: TextStyle(
              fontSize: 28.sp,
              color: widget.isSelected ? Colors.white : Color.fromRGBO(51, 51, 51, 1),
            ),
          ),
        ),
      ),
    );
  }
}

//Container(
//
//child: Wrap(
//direction: Axis.horizontal, // 排列方向，默认水平方向排列
//alignment: WrapAlignment.start, // 子控件在主轴上的对齐方式
//runAlignment: WrapAlignment.start, // 子控件在交叉轴上的对齐方式
//crossAxisAlignment: WrapCrossAlignment.start, // 交叉轴上子控件的对齐方式
//textDirection: TextDirection.ltr, // 水平方向上子控件的起始位置
//verticalDirection: VerticalDirection.down, // 垂直方向上子控件的起始位置
//spacing: 10.w, // 主轴上子控件中间的间距
//runSpacing: 10.h, // 交叉轴上子控件之间的间距
//children: <Widget>[
//ScreenButton(
//title: "不限",
//isSelected: true,
//itemWidth:200.w
//),
//ScreenButton(
//title: "1月以下",
//itemWidth: 90.0,
//),
//ScreenButton(
//title: "1月",
//
//),
//ScreenButton(
//title: "2月",
//
//),
//ScreenButton(
//title: "3月",
//
//),
//ScreenButton(
//title: "6月",
//
//),
//ScreenButton(
//title: "12月",
//isSelected: true,
//),
//],
//),
//),