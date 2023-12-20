import 'package:flutter/material.dart';

class BannerAds extends StatelessWidget {
  final String image;
  final double? margin;

  const BannerAds({
    super.key,
    required this.image,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    double baseWidth = MediaQuery.of(context).size.width - 12 * 2;
    return Container(
        width: baseWidth,
        height: 128.0,
        margin: EdgeInsets.symmetric(horizontal: margin ?? 12.0),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(8.0),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ));
  }
}
