import 'package:dh/res/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double height;
  final double width;
  final Color color;
  final Color textColor;
  final double radius;
  final double fontSize;
  final VoidCallback onPressed;
  final bool busy;

  CustomButton(this.text,
      {this.height: 30,
      Key key,
      this.width: 80,
      this.radius: 10,
      this.fontSize: 14,
      this.color: Styles.colorTheme,
      this.textColor: Colors.white,
      this.busy:false,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap:(){
        if(!busy)
          onPressed();
      },

      child: Container(
        width: width ?? 195,
        height: height ?? 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: busy ? Styles.color333333 : this.color,
          borderRadius: BorderRadius.circular(this.radius),
        ),
        child: Text(
          text,
          style: Styles.theme(
              fontSize: this.fontSize,
              fontWeight: FontWeight.w400,
              color: textColor),
        ),
      ),
    );
  }
}
