import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:selling_food_store/shared/utils/image_constants.dart';
import 'package:selling_food_store/shared/widgets/banner/banner_ads.dart';

class SlideBanner extends StatefulWidget {
  const SlideBanner({super.key});

  @override
  State<SlideBanner> createState() => _SlideBannerState();
}

class _SlideBannerState extends State<SlideBanner> {

  List<String> imageSlides = [
    ImageConstants.bannerOne,
    ImageConstants.bannerTwo,
    ImageConstants.bannerThree,
    ImageConstants.bannerFour,
    ImageConstants.bannerFive,
    ImageConstants.bannerSix,
    ImageConstants.bannerSeven,
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 128.0,
        autoPlay: true,
        viewportFraction: 0.9,
      ),
      items: imageSlides.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return BannerAds(image: i, margin: 4.0);
          },
        );
      }).toList(),
    );
  }
}
