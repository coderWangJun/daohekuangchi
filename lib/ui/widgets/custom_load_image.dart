import 'package:flutter/cupertino.dart';
import 'package:dh/utils/image_util.dart';

class CustomLoadImage extends StatelessWidget {
  const CustomLoadImage(this.image,
      {Key key,
      this.width,
      this.height,
      this.fit: BoxFit.cover,
      this.format: 'png',
      this.holderImg: 'none'})
      : super(key: key);

  final String image;
  final double width;
  final double height;
  final BoxFit fit;
  final String format;
  final String holderImg;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

/// 加载本地资源图片
class LoadAssetImage extends StatelessWidget {
  const LoadAssetImage(this.image,
      {Key key,
      this.width,
      this.height,
      this.fit,
      this.format: 'png',
      this.color})
      : super(key: key);

  final String image;
  final double width;
  final double height;
  final BoxFit fit;
  final String format;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImageUtil.wrapAssets(image),
      height: height,
      width: width,
      fit: fit,
      color: color,

      /// 忽略图片语义
      excludeFromSemantics: true,
    );
  }
}

//加载网络资料图片
class LoadNetworkImage extends StatelessWidget {
  const LoadNetworkImage(this.image,
      {Key key,
      this.width,
      this.height,
      this.fit,
      this.format: 'png',
      this.color})
      : super(key: key);

  final String image;
  final double width;
  final double height;
  final BoxFit fit;
  final String format;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      image,
      height: height,
      width: width,
      fit: fit,
      color: color,
      excludeFromSemantics: true,
    );
  }
}
