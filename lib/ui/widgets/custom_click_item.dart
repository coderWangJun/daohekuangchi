import 'package:dh/res/styles.dart';
import 'package:flutter/material.dart';
import 'package:dh/ui/widgets/custom_load_image.dart';
import 'package:dh/ui/widgets/custom_text.dart';
import 'package:dh/utils/index.dart';

class CustomClickItem extends StatelessWidget {
  const CustomClickItem(
      {Key key,
      this.onTap,
      @required this.title,
      this.content: '',
      this.textAlign: TextAlign.start,
      this.image: "",
      this.contentStyle,
      this.maxLines: 1})
      : super(key: key);

  final GestureTapCallback onTap;
  final String title;
  final String content;
  final TextAlign textAlign;
  final int maxLines;
  final String image;
  final TextStyle contentStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 24.w,right: 24.w),
        constraints: BoxConstraints(minHeight: 110.h),
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border(
          bottom: Divider.createBorderSide(context, width: 0.6),
        )),
        child: Row(
          crossAxisAlignment: maxLines == 1
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: <Widget>[
            Visibility(
              visible: this.image.isNotEmpty,
              child: LoadAssetImage(this.image,
                  height: 44.h,
                  width: 44.h),
            ),
            Padding(
                padding: EdgeInsets.only(left: 25.w),
                child: CustomText(
                  title,
                  fontSize: 32,
                  color: Styles.colorThemeText,
                )),
            //const Spacer(),
            Expanded(
              flex: 4,
              child: Container(
                padding:  EdgeInsets.only(right: 24.w),
                child: Text(
                  content,
                  maxLines: maxLines,
                  textAlign: maxLines == 1 ? TextAlign.right : textAlign,
                  overflow: TextOverflow.ellipsis,
                  style: contentStyle == null
                      ? TextStyle(
                          color: Styles.colorThemeText,
                          fontWeight: FontWeight.w500,
                          fontSize: 28.sp)
                      : contentStyle,
                ),
              ),
            ),
            Opacity(
              opacity: onTap == null ? 0 : 1,
              child: Padding(
                padding: EdgeInsets.only(top: maxLines == 1 ? 0.0 : 2.0),
                child: LoadAssetImage('qianjin_icon.png',
                    height: 40.h,
                    width: 40.h),
              ),
            )
          ],
        ),
      ),
    );
  }
}
