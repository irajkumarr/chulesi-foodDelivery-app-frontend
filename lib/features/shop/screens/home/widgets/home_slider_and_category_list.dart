import 'package:flutter/material.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/features/shop/screens/home/widgets/category_list.dart';
import 'package:chulesi/features/shop/screens/home/widgets/home_promo_slider.dart';

class HomeSliderAndCategoryList extends StatelessWidget {
  const HomeSliderAndCategoryList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HomePromoSlider(),
        SizedBox(height: KSizes.defaultSpace),
        const CategoryList(),
      ],
    );
  }
}
