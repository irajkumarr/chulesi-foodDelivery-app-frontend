import 'package:chulesi/features/shop/providers/offers_food_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chulesi/common/widgets/products/foods_card/food_offers_tile_horizontal.dart';
import 'package:chulesi/core/network/connectivity_checker.dart';
import 'package:chulesi/core/utils/shimmers/foodlist_shimmer.dart';
import 'package:chulesi/data/models/foods_with_offers_model.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

import '../../../../common/widgets/products/carts/cart_counter_icon.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/sizes.dart';

// class DealsAndOffersScreen extends StatelessWidget {
//   const DealsAndOffersScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final offerFoodsListProvider = Provider.of<OffersFoodListProvider>(context);
//     return ConnectivityChecker(
//       child: DefaultTabController(
//         length: 1,
//         child: Scaffold(
//           appBar: AppBar(
//             elevation: 0,
//             centerTitle: true,
//             title: const Text("Deals and Offers"),
//             bottom: PreferredSize(
//               preferredSize: Size.fromHeight(50.0.h),
//               child: Align(
//                 alignment: Alignment.topLeft,
//                 child: TabBar(
//                   dividerColor: KColors.softGrey,
//                   onTap: (value) async {
//                     await Future.delayed(Duration(seconds: 1));
//                     await offerFoodsListProvider.refetchOfferFoodList();
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
//                       height: 35.h,
//                       child: Container(
//                         padding:
//                             const EdgeInsets.symmetric(horizontal: KSizes.md),
//                         decoration: BoxDecoration(
//                           borderRadius:
//                               BorderRadius.circular(KSizes.borderRadiusSm),
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
//                   AntDesign.search1,
//                   size: KSizes.iconMd,
//                 ),
//               ),
//               const CartCounterIcon(iconColor: KColors.black),
//             ],
//           ),
//           body: TabBarView(
//             children: [
//               RefreshIndicator(
//                 onRefresh: () async {
//                   await Future.delayed(Duration(seconds: 1));
//                   await offerFoodsListProvider.refetchOfferFoodList();
//                 },
//                 child: SingleChildScrollView(
//                   physics:
//                       const BouncingScrollPhysics(), // Bouncing scroll effect
//                   child: Padding(
//                     padding:
//                         EdgeInsets.symmetric(horizontal: KSizes.buttonHeight),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         offerFoodsListProvider.isLoading
//                             ? const Padding(
//                                 padding: EdgeInsets.only(top: KSizes.md),
//                                 child: FoodsListShimmer(),
//                               )
//                             : ListView.builder(
//                                 shrinkWrap:
//                                     true, // Ensures ListView takes only the necessary space
//                                 physics:
//                                     const NeverScrollableScrollPhysics(), // No internal scrolling
//                                 itemCount: offerFoodsListProvider
//                                         .offersFoodsList?.length ??
//                                     0,
//                                 itemBuilder: (context, index) {
//                                   FoodsWithOffersModel food =
//                                       offerFoodsListProvider
//                                           .offersFoodsList![index];
//                                   return Padding(
//                                     padding:
//                                         const EdgeInsets.only(top: KSizes.md),
//                                     child: FoodOffersTileHorizontal(food: food),
//                                   );
//                                 },
//                               ),
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

class DealsAndOffersScreen extends StatelessWidget {
  const DealsAndOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final offerFoodsListProvider = Provider.of<OffersFoodListProvider>(context);
    return ConnectivityChecker(
      child: DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: const Text("Deals and Offers"),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(50.0.h),
              child: Align(
                alignment: Alignment.topLeft,
                child: TabBar(
                  dividerColor: KColors.softGrey,
                  onTap: (value) async {
                    await Future.delayed(const Duration(seconds: 1));
                    await offerFoodsListProvider.refetchOfferFoodList();
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
                      height: 35.h,
                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: KSizes.md),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(KSizes.borderRadiusSm),
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
                    AntDesign.search1,
                    size: KSizes.iconMd,
                  )),
              const CartCounterIcon(iconColor: KColors.black),
            ],
          ),
          body: TabBarView(
            // physics: BouncingScrollPhysics(),
            children: [
              RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(const Duration(seconds: 1));
                  await offerFoodsListProvider.refetchOfferFoodList();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: KSizes.buttonHeight,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: offerFoodsListProvider.isLoading
                            ? const Padding(
                                padding: EdgeInsets.only(top: KSizes.md),
                                child: FoodsListShimmer(),
                              )
                            : ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: offerFoodsListProvider
                                        .offersFoodsList?.length ??
                                    0,
                                itemBuilder: (context, index) {
                                  FoodsWithOffersModel food =
                                      offerFoodsListProvider
                                          .offersFoodsList![index];
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(top: KSizes.md),
                                    child: FoodOffersTileHorizontal(food: food),
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

// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:chulesi/common/widgets/products/foods_card/food_offers_tile_horizontal.dart';
// import 'package:chulesi/core/network/connectivity_checker.dart';
// import 'package:chulesi/core/utils/shimmers/foodlist_shimmer.dart';
// import 'package:chulesi/data/hooks/fetch_offer_food.dart';
// import 'package:chulesi/data/models/foods_with_offers_model.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';

// import '../../../../common/widgets/products/carts/cart_counter_icon.dart';
// import '../../../../core/utils/constants/colors.dart';
// import '../../../../core/utils/constants/sizes.dart';

// class DealsAndOffersScreen extends HookWidget {
//   const DealsAndOffersScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final hookResult = useFetchOfferFood();
//     List<FoodsWithOffersModel>? foodsList = hookResult.data;
//     final isLoading = hookResult.isLoading;
//     final refetch = hookResult.refetch;
//     return ConnectivityChecker(
//       child: DefaultTabController(
//         length: 1,
//         child: Scaffold(
//           appBar: AppBar(
//             elevation: 0,
//             centerTitle: true,
//             title: const Text("Deals and Offers"),
//             bottom: PreferredSize(
//               preferredSize: Size.fromHeight(50.0.h),
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
//                       height: 35.h,
//                       child: Container(
//                         padding:
//                             const EdgeInsets.symmetric(horizontal: KSizes.md),
//                         decoration: BoxDecoration(
//                           borderRadius:
//                               BorderRadius.circular(KSizes.borderRadiusSm),
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
//               AntDesign.search1,
             
//               size: KSizes.iconMd,
//             )
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
//                                   padding: EdgeInsets.only(top: KSizes.md),
//                                   child: FoodsListShimmer(),
//                                 )
//                               : ListView.builder(
//                                   physics: const BouncingScrollPhysics(),
//                                   itemCount: foodsList?.length ?? 0,
//                                   itemBuilder: (context, index) {
//                                     FoodsWithOffersModel food =
//                                         foodsList![index];
//                                     return Padding(
//                                       padding:
//                                           const EdgeInsets.only(top: KSizes.md),
//                                       child:
//                                           FoodOffersTileHorizontal(food: food),
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
