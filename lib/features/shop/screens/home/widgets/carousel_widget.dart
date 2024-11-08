import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarouselWidget extends StatelessWidget {
  const CarouselWidget(
      {super.key,
      required this.itemBuilder,
      required this.itemCount,
      this.pageChanged,
      required this.aspectRatio,
      required this.viewportFraction,
      this.height});

  final itemBuilder;
  final int itemCount;
  final dynamic Function(int, CarouselPageChangedReason)? pageChanged;
  final double aspectRatio;
  final double viewportFraction;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 275.h,
      child: CarouselSlider.builder(
        itemCount: itemCount,
        itemBuilder: itemBuilder,
        options: CarouselOptions(
          height: height,
          aspectRatio: aspectRatio,
          viewportFraction: viewportFraction,
          initialPage: 0,
          autoPlay: true,
          // scrollPhysics: BouncingScrollPhysics(),
          autoPlayInterval: const Duration(seconds: 4),
          autoPlayAnimationDuration: const Duration(milliseconds: 1000),
          autoPlayCurve: Curves.ease,

          enlargeCenterPage: true,
          enlargeFactor: 0.25,
          onPageChanged: pageChanged,
          // scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}
