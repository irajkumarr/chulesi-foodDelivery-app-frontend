import 'package:chulesi/features/shop/providers/foods_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/core/utils/shimmers/food_tile_vertical_shimmer.dart';
import 'package:chulesi/data/models/foods_model.dart';
import 'package:chulesi/features/shop/screens/home/widgets/carousel_widget.dart';
import 'package:provider/provider.dart';

import '../../../../../common/widgets/products/foods_card/food_tile_vertical.dart';

class PopularFoodsList extends StatelessWidget {
  const PopularFoodsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final foodsListProvider = Provider.of<FoodsListProvider>(context);

    return Container(
      height: 270.h,
      // height: 300.h,
      margin: EdgeInsets.only(bottom: KSizes.spaceBtwItems),
      width: double.infinity,
      child: foodsListProvider.isLoading
          ? const FoodTileVerticalShimmer()
          : (foodsListProvider.popularFoodsList != null &&
                  foodsListProvider.popularFoodsList!.isNotEmpty)
              ? CarouselWidget(
                  itemCount: foodsListProvider.popularFoodsList!.length,
                  aspectRatio: 16 / 14,
                  // aspectRatio: 16 / 16,
                  viewportFraction: 0.50,
                  // viewportFraction: 0.520,
                  itemBuilder: (context, index, pageviewIndex) {
                    FoodsModel foods =
                        foodsListProvider.popularFoodsList![index];
                    return ProductCardVertical(
                      food: foods,
                    );
                  },
                )
              : const Center(
                  child: FoodTileVerticalShimmer(),
                ),
    );
  }
}
