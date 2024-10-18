import 'package:flutter/material.dart';

class ProductTitleText extends StatelessWidget {
  const ProductTitleText({
    super.key,
    this.maxlines = 2,
    this.textAlign = TextAlign.left,
    this.smallSize = false,
    required this.title,
  });
  final int maxlines;
  final TextAlign? textAlign;
  final bool smallSize;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: smallSize
          ? Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.w600)
          : Theme.of(context).textTheme.headlineMedium,
      overflow: TextOverflow.ellipsis,
      maxLines: maxlines,
      textAlign: textAlign,
    );
  }
}
