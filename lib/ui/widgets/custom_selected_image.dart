import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dh/utils/index.dart';

class CustomSelectedImage extends StatelessWidget {
  const CustomSelectedImage(
      {Key key,
      this.size: 80.0,
      this.onTap,
      this.image,
      this.networkImgUrl: "",
      this.clip: true,
      this.defaultImgUrl: "assets/images/mine/update.png"})
      : super(key: key);

  final double size;
  final GestureTapCallback onTap;
  final File image;
  final networkImgUrl;
  final defaultImgUrl;

  //是否头像
  final bool clip;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '选择图片',
      hint: '跳转相册选择图片',
      child: InkWell(
        borderRadius: BorderRadius.circular(16.0),
        onTap: onTap,
        child: image != null
            ? Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  // 图片圆角展示
                  borderRadius: BorderRadius.circular(10.w),
                  image: DecorationImage(
                      image: FileImage(image),
                      fit: BoxFit.cover,
                      // colorFilter: image == null
                      //     ? ColorFilter.mode(
                      //         ThemeUtil.getDarkColor(
                      //             context, Styles.dark_unselected_item_color),
                      //         BlendMode.srcIn)
                      //     : null)
                  ),
                ),
              )
            : networkImgUrl != ""
                ? Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      // 图片圆角展示
                      borderRadius: BorderRadius.circular(10.w),
                      image: DecorationImage(
                          image: FadeInImage.assetNetwork(
                                  placeholder: "assets/images/mine/add_b.png",
                                  image: networkImgUrl)
                              .image,
                          fit: BoxFit.cover,
                          // colorFilter: image == null
                          //     ? ColorFilter.mode(
                          //         ThemeUtil.getDarkColor(context,
                          //             Styles.dark_unselected_item_color),
                          //         BlendMode.srcIn)
                          //     : null),
                      )
                    ),
                  )
                : Container(
                    width: size,
                    height: size,
                    child: this.clip
                        ? new ClipOval(
                            child: new Image.asset(defaultImgUrl),
                          )
                        : new Image.asset(defaultImgUrl,),
                  ),
      ),
    );
  }
}
