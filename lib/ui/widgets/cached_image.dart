import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class CachedImage extends StatefulWidget {
  final String src;
  final double width;
  final double height;
  final BoxFit fit;
  final Widget defaultImg;
  final ImageWidgetBuilder imageBuilder;
  final VoidCallback onTap;
  final HitTestBehavior behavior;

  CachedImage.network(
    this.src, {
    this.width,
    this.height,
    this.fit,
    this.defaultImg,
    this.imageBuilder,
    this.onTap,
    this.behavior,
  });

  @override
  _CachedImageState createState() => _CachedImageState();
}

class _CachedImageState extends State<CachedImage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      behavior: widget.behavior,
      child: CachedNetworkImage(
        width: widget.width,
        height: widget.height,
        imageUrl: widget.src ?? '-',
        imageBuilder: widget.imageBuilder,
        placeholder: (context, url) => Container(
          child: widget?.defaultImg ??
              Image.asset(
                'assets/images/home/banner.png',
                fit: widget.fit == null ? BoxFit.cover : widget.fit,
              ),
        ),
        errorWidget: (context, url, error) => Container(
          child: widget?.defaultImg ??
              Image.asset(
                'assets/images/home/banner.png',
                fit: widget.fit == null ? BoxFit.cover : widget.fit,
              ),
        ),
        fit: widget.fit == null ? BoxFit.cover : widget.fit,
      ),
    );
  }
}
