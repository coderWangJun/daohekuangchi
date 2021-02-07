import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CustomBanner extends StatelessWidget {
  final List<String> banners;

  const CustomBanner({Key key, this.banners}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Swiper(
      loop: false,
      autoplay: true,
      autoplayDelay: 8000,
      pagination: SwiperPagination(),
      itemCount: banners.length,
      itemBuilder: (ctx, index) {
        return InkWell(
            onTap: () {},
            child: Image.network(
              banners[index],
              fit: BoxFit.fill,
            ));
      },
    ));
  }
}
