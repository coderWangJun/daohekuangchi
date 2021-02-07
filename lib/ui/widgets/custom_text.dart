import 'package:dh/res/styles.dart';
import 'package:flutter/material.dart';
import 'package:dh/utils/index.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final softWrap;
  final fontWeight;
  final double width;
  final TextAlign textAlign;

  const CustomText(this.text,
      {Key key,
        this.fontSize: 28,
        this.width,
        this.color: Styles.colorThemeText,
        this.fontWeight: FontWeight.w400, this.textAlign: TextAlign.center,
      this.softWrap: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: this.width,
      alignment: Alignment.center,
      child: Text(text == null ? "" : text,
          softWrap: this.softWrap,
          textAlign: this.textAlign,
          style: Styles.theme(
              color: this.color,
              fontWeight: this.fontWeight,
              fontSize: this.fontSize.ssp)),
    );
  }
}
