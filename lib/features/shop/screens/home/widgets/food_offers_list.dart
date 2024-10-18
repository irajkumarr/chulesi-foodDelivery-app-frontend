import 'package:chulesi/features/shop/providers/offers_food_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chulesi/common/widgets/products/foods_card/food_offers_tile_vertical.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/core/utils/shimmers/food_tile_vertical_shimmer.dart';
import 'package:chulesi/data/models/foods_with_offers_model.dart';
import 'package:provider/provider.dart';

class FoodOffersList extends StatelessWidget {
  const FoodOffersList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final offersFoodListProvider = Provider.of<OffersFoodListProvider>(context);

    return Container(
        margin: EdgeInsets.only(bottom: KSizes.spaceBtwItems),
        height: 270.h,
        child: offersFoodListProvider.isLoading
            ? const FoodTileVerticalShimmer()
            : offersFoodListProvider.error != null
                ? Center(child: Text(offersFoodListProvider.error!))

                // Check if items are not null and not empty
                : offersFoodListProvider.offersFoodsList != null &&
                        offersFoodListProvider.offersFoodsList!.isNotEmpty
                    ? ListView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        children: List.generate(
                            offersFoodListProvider.offersFoodsList!.length,
                            (index) {
                          FoodsWithOffersModel food =
                              offersFoodListProvider.offersFoodsList![index];
                          return Padding(
                            padding: const EdgeInsets.only(left: KSizes.md),
                            child: FoodOffersTileVertical(
                              food: food,
                            ),
                          );
                        }),
                      )
                    :
                    // const Center(
                    //     child: Text("No Offers available."),
                    //   ),
                    const FoodTileVerticalShimmer()
        // ),
        );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:chulesi/common/widgets/products/foods_card/food_offers_tile_vertical.dart';
// import 'package:chulesi/core/utils/constants/sizes.dart';
// import 'package:chulesi/core/utils/shimmers/food_tile_vertical_shimmer.dart';
// import 'package:chulesi/data/hooks/fetch_offer_food.dart';
// import 'package:chulesi/data/models/foods_with_offers_model.dart';

// class FoodOffersList extends HookWidget {
//   const FoodOffersList({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final hookResult = useFetchOfferFood();
//     List<FoodsWithOffersModel> foodList = hookResult.data ?? [];
//     final isLoading = hookResult.isLoading;

//     return Container(
//       margin: EdgeInsets.only(bottom: KSizes.spaceBtwItems),

//       height: 270.h,

//       child: isLoading
//           ? const FoodTileVerticalShimmer()
//           : ListView(
//               scrollDirection: Axis.horizontal,
//               physics: const BouncingScrollPhysics(),
//               children: List.generate(foodList.length, (index) {
//                 FoodsWithOffersModel food = foodList[index];
//                 return Padding(
//                   padding: const EdgeInsets.only(left: KSizes.md),
//                   child: FoodOffersTileVertical(
//                     food: food,
//                   ),
//                 );
//               }),
//             ),
//       // ),
//     );
//   }
// }
