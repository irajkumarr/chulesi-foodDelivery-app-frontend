import 'package:flutter/material.dart';


import '../../../../core/utils/constants/colors.dart';

class ProductPriceText extends StatelessWidget {
  const ProductPriceText({
    super.key,
    this.currencySign = "Rs.",
    required this.price,
    this.maxlines = 1,
    this.isLarge = false,
    this.lineThrough = false,
    this.color = KColors.primary,
  });
  final String currencySign, price;
  final int maxlines;
  final bool isLarge;
  final bool lineThrough;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      "$currencySign $price",
      maxLines: maxlines,
      overflow: TextOverflow.ellipsis,
      style: isLarge
          ? Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: color,
              decoration: lineThrough ? TextDecoration.lineThrough : null)
          : Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: color,
              decoration: lineThrough ? TextDecoration.lineThrough : null),
    );
  }
}
