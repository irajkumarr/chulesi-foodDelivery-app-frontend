import 'package:chulesi/features/shop/providers/foods_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chulesi/common/widgets/products/foods_card/food_tile_vertical.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/core/utils/shimmers/food_tile_vertical_shimmer.dart';
import 'package:chulesi/data/models/foods_model.dart';
import 'package:provider/provider.dart';

class NewFoodsList extends StatelessWidget {
  const NewFoodsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final foodsListProvider = Provider.of<FoodsListProvider>(context);

    // if (isLoading) {
    //   return Center(child: CircularProgressIndicator());
    // }
    return Container(
        margin: EdgeInsets.only(bottom: KSizes.spaceBtwItems),
        height: 270.h,
        // height: 300.h,
        child: foodsListProvider.isLoading
            ? const FoodTileVerticalShimmer()
            : foodsListProvider.error != null
                ? Center(child: Text(foodsListProvider.error!))
                : foodsListProvider.newFoodsList != null &&
                        foodsListProvider.newFoodsList!.isNotEmpty
                    ? ListView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        children: List.generate(
                            foodsListProvider.newFoodsList!.length, (index) {
                          FoodsModel foods =
                              foodsListProvider.newFoodsList![index];
                          return Padding(
                            padding: const EdgeInsets.only(left: KSizes.md),
                            child: ProductCardVertical(
                              food: foods,
                            ),
                          );
                        }),
                      )
                    : const FoodTileVerticalShimmer());
  }
}