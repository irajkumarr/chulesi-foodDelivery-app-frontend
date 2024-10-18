import 'package:chulesi/features/shop/providers/foods_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chulesi/common/widgets/products/foods_card/food_tile_horizontal.dart';
import 'package:chulesi/core/network/connectivity_checker.dart';
import 'package:chulesi/core/utils/shimmers/foodlist_shimmer.dart';
import 'package:chulesi/data/models/foods_model.dart';
import 'package:provider/provider.dart';

import '../../../../common/widgets/products/carts/cart_counter_icon.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/sizes.dart';

class RecommendedFoodsScreen extends StatelessWidget {
  const RecommendedFoodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final foodsListProvider = Provider.of<FoodsListProvider>(context);
    return ConnectivityChecker(
      child: DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Newest Foods"),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(50.0.h),
              child: Align(
                alignment: Alignment.topLeft,
                child: TabBar(
                  dividerColor: KColors.softGrey,
                  onTap: (value) async {
                    await Future.delayed(const Duration(seconds: 1));
                    await foodsListProvider.refetchNewFoodsList();
                  },
                  splashFactory: NoSplash.splashFactory,
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(KSizes.borderRadiusMd),
                  ),
                  unselectedLabelColor: KColors.black,
                  labelColor: Colors.white,
                  tabs: [
                    Tab(
                      height: 40,
                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: KSizes.md),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(KSizes.borderRadiusMd),
                          color: KColors.secondary,
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text("All"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/search");
                },
                icon: Icon(
                  Icons.search,
                  color: KColors.black,
                  size: KSizes.iconMd + 3,
                ),
              ),
              const CartCounterIcon(iconColor: KColors.black),
            ],
          ),
          body: TabBarView(
            children: [
              RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(const Duration(seconds: 1));
                  await foodsListProvider.refetchNewFoodsList();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: KSizes.buttonHeight,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: foodsListProvider.isLoading
                            ? const Padding(
                                padding: EdgeInsets.only(top: KSizes.md),
                                child: FoodsListShimmer(),
                              )
                            : ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount:
                                    foodsListProvider.newFoodsList?.length ??
                                        0,
                                itemBuilder: (context, index) {
                                  FoodsModel food =
                                      foodsListProvider.newFoodsList![index];
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(top: KSizes.md),
                                    child: ProductCardHorizontal(
                                      food: food,
                                    ),
                                  );
                                },
                              ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// import 'package:chulesi/features/shop/providers/foods_list_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:chulesi/common/widgets/products/foods_card/food_tile_horizontal.dart';
// import 'package:chulesi/core/network/connectivity_checker.dart';
// import 'package:chulesi/core/utils/shimmers/foodlist_shimmer.dart';
// import 'package:chulesi/data/hooks/fetch_new_foods.dart';
// import 'package:chulesi/data/models/foods_model.dart';
// import 'package:provider/provider.dart';

// import '../../../../common/widgets/products/carts/cart_counter_icon.dart';
// import '../../../../core/utils/constants/colors.dart';
// import '../../../../core/utils/constants/sizes.dart';

// class RecommendedFoodsScreen extends HookWidget {
//   const RecommendedFoodsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final hookResult = useFetchNewFoods();
//     List<FoodsModel>? foodsList = hookResult.data;
//     final isLoading = hookResult.isLoading;
//     final refetch = hookResult.refetch;
//     //  final foodsListProvider = Provider.of<FoodsListProvider>(context);
//     return ConnectivityChecker(
//       child: DefaultTabController(
//         length: 1,
//         child: Scaffold(
//           appBar: AppBar(
//             centerTitle: true,
//             title: const Text("Newest Foods"),
//             bottom: PreferredSize(
//               preferredSize:  Size.fromHeight(50.0.h),
//               child: Align(
//                 alignment: Alignment.topLeft,
//                 child: TabBar(
//                   dividerColor: KColors.softGrey,
//                   onTap: (value) async {
//                     await refetch();
//                   },
//                   splashFactory: NoSplash.splashFactory,
//                   tabAlignment: TabAlignment.start,
//                   isScrollable: true,
//                   indicator: BoxDecoration(
//                     borderRadius: BorderRadius.circular(KSizes.borderRadiusMd),
//                   ),
//                   unselectedLabelColor: KColors.black,
//                   labelColor: Colors.white,
//                   tabs: [
//                     Tab(
//                       height: 40,
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(horizontal: KSizes.md),
//                         decoration: BoxDecoration(
//                           borderRadius:
//                               BorderRadius.circular(KSizes.borderRadiusMd),
//                           color: KColors.secondary,
//                         ),
//                         child: const Align(
//                           alignment: Alignment.center,
//                           child: Text("All"),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             actions: [
//               IconButton(
//                 onPressed: () {
//                   Navigator.pushNamed(context, "/search");
//                 },
//                 icon: Icon(
//                   Icons.search,
//                   color: KColors.black,
//                   size: KSizes.iconMd + 3,
//                 ),
//               ),
//               const CartCounterIcon(iconColor: KColors.black),
//             ],
//           ),
//           body: TabBarView(
//             children: [
//               RefreshIndicator(
//                 onRefresh: () async {
//                   await refetch();
//                 },
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: KSizes.buttonHeight,
//                   ),
//                   child: Container(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           child: isLoading
//                               ? const Padding(
//                                padding: EdgeInsets.only(top: KSizes.md),
//                                 child: FoodsListShimmer(),
//                               )
//                               : ListView.builder(
//                                   physics: const BouncingScrollPhysics(),
//                                   itemCount: foodsList?.length ?? 0,
//                                   itemBuilder: (context, index) {
//                                     FoodsModel food = foodsList![index];
//                                     return Padding(
//                                       padding: const EdgeInsets.only(top: KSizes.md),
//                                       child: ProductCardHorizontal(
//                                         food: food,
//                                       ),
//                                     );
//                                   },
//                                 ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
