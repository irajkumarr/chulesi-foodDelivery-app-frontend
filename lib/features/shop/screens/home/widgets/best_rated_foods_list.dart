import 'package:chulesi/features/shop/providers/foods_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chulesi/common/widgets/products/foods_card/food_tile_vertical.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/core/utils/shimmers/food_tile_vertical_shimmer.dart';
import 'package:chulesi/data/models/foods_model.dart';
import 'package:provider/provider.dart';

class BestRatedFoodsList extends StatelessWidget {
  const BestRatedFoodsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final foodsListProvider = Provider.of<FoodsListProvider>(context);

    return Container(
        margin: EdgeInsets.only(bottom: KSizes.spaceBtwItems),
        height: 270.h,
        child: foodsListProvider.isLoading
            ? const FoodTileVerticalShimmer()
            : foodsListProvider.error != null
                ? Center(child: Text(foodsListProvider.error!))
                : foodsListProvider.bestRatedFoodsList != null &&
                        foodsListProvider.bestRatedFoodsList!.isNotEmpty
                    ? ListView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        children: List.generate(
                            foodsListProvider.bestRatedFoodsList!.length,
                            (index) {
                          FoodsModel foods =
                              foodsListProvider.bestRatedFoodsList![index];
                          return Padding(
                            padding: const EdgeInsets.only(left: KSizes.md),
                            child: ProductCardVertical(
                              food: foods,
                            ),
                          );
                        }),
                      )
                    : const FoodTileVerticalShimmer()
        // ),
        );
  }
}
