import 'package:flutter/material.dart';
import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/data/models/foods_model.dart';
import 'package:chulesi/features/shop/providers/search_provider.dart';
import 'package:provider/provider.dart';

import '../../../../common/widgets/products/foods_card/food_tile_horizontal.dart';
import '../../../../core/utils/constants/sizes.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({super.key});

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);
    return ListView(
      // crossAxisAlignment: CrossAxisAlignment.start,
      // physics: NeverScrollableScrollPhysics(),
      children: [
        Row(
          children: [
            Text(
              "${searchProvider.searchResults!.length}",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w600, color: KColors.primary),
            ),
            const Text(" results found"),
            Text(
              ' "${searchProvider.searchText}"',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.w700, color: KColors.black),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: KSizes.sm),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.83,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              // physics: NeverScrollableScrollPhysics(),
              children:
                  List.generate(searchProvider.searchResults!.length, (index) {
                FoodsModel food = searchProvider.searchResults![index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: KSizes.md),
                  child: ProductCardHorizontal(
                    food: food,
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
