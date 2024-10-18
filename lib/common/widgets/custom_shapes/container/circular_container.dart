import 'package:flutter/material.dart';

class CircularContainer extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final double radius;
  final EdgeInsetsGeometry? margin;

  const CircularContainer({
    super.key,
    this.width = 400,
    this.height = 400,
    required this.color,
    this.radius = 400,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
