import 'package:chulesi/features/shop/providers/foods_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:chulesi/common/widgets/products/foods_card/food_tile_horizontal.dart';
import 'package:chulesi/core/network/connectivity_checker.dart';
import 'package:chulesi/core/utils/shimmers/foodlist_shimmer.dart';
import 'package:chulesi/data/models/foods_model.dart';
import 'package:provider/provider.dart';

import '../../../../common/widgets/products/carts/cart_counter_icon.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/sizes.dart';

class AllPopularFoodsScreen extends StatelessWidget {
  const AllPopularFoodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final foodsListProvider = Provider.of<FoodsListProvider>(context);
    return ConnectivityChecker(
      child: DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: const Text("Popular Foods"),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(50.0.h),
              child: Align(
                alignment: Alignment.topLeft,
                child: TabBar(
                  dividerColor: KColors.softGrey,
                  onTap: (value) async {
                    await Future.delayed(const Duration(seconds: 1));
                    await foodsListProvider.refetchPopularFoodsList();
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
            children: [
              RefreshIndicator(
                color: KColors.primary,
                onRefresh: () async {
                  await Future.delayed(const Duration(seconds: 1));
                  await foodsListProvider.refetchPopularFoodsList();
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
                                itemCount: foodsListProvider
                                        .popularFoodsList?.length ??
                                    0,
                                itemBuilder: (context, index) {
                                  FoodsModel food = foodsListProvider
                                      .popularFoodsList![index];
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
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';
// import 'package:chulesi/common/widgets/products/foods_card/food_tile_horizontal.dart';
// import 'package:chulesi/core/network/connectivity_checker.dart';
// import 'package:chulesi/core/utils/shimmers/foodlist_shimmer.dart';
// import 'package:chulesi/data/hooks/fetch_popular_foods.dart';
// import 'package:chulesi/data/models/foods_model.dart';

// import '../../../../common/widgets/products/carts/cart_counter_icon.dart';
// import '../../../../core/utils/constants/colors.dart';
// import '../../../../core/utils/constants/sizes.dart';

// class AllPopularFoodsScreen extends HookWidget {
//   const AllPopularFoodsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final hookResult = useFetchAllPopularFoods();
//     // final hookResult = useFetchAllFoods();
//     List<FoodsModel>? foodsList = hookResult.data;
//     final isLoading = hookResult.isLoading;
//     final refetch = hookResult.refetch;
//     return ConnectivityChecker(
//       child: DefaultTabController(
//         length: 1,
//         child: Scaffold(
//           appBar: AppBar(
//             elevation: 0,
//             centerTitle: true,
//             title: const Text("Popular Foods"),
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
//                   onPressed: () {
//                     Navigator.pushNamed(context, "/search");
//                   },
//                   icon: Icon(
//                     AntDesign.search1,
//                     size: KSizes.iconMd,
//                   )),
//               const CartCounterIcon(iconColor: KColors.black),
//             ],
//           ),
//           body: TabBarView(
//             children: [
//               RefreshIndicator(
//                 color: KColors.primary,
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
//                                     FoodsModel food = foodsList![index];
//                                     return Padding(
//                                       padding:
//                                           const EdgeInsets.only(top: KSizes.md),
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

// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:chulesi/common/widgets/products/carts/cart_counter_icon.dart';
// import 'package:chulesi/common/widgets/products/foods_card/food_tile_horizontal.dart';
// import 'package:chulesi/core/utils/circular_progress_indicator/circlular_indicator.dart';
// import 'package:chulesi/core/utils/constants/colors.dart';
// import 'package:chulesi/core/utils/constants/sizes.dart';
// import 'package:chulesi/core/utils/shimmers/foodlist_shimmer.dart';
// import 'package:chulesi/data/hooks/fetch_all_foods.dart';
// import 'package:chulesi/data/models/foods_model.dart';

// class AllPopularFoodsScreen extends HookWidget {
//   const AllPopularFoodsScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     final fetchFood = useFetchAllFoods();

//     // This controller helps in detecting when the user has scrolled to the bottom
//     final scrollController = useScrollController();

//     useEffect(() {
//       // Add a listener to the scroll controller to load more items when reaching the bottom
//       void onScroll() {
//         if (scrollController.position.extentAfter < 200) {
//           fetchFood.loadMore!();
//         }
//       }

//       scrollController.addListener(onScroll);
//       return () => scrollController.removeListener(onScroll);
//     }, [scrollController]);

//     if (fetchFood.isLoading && fetchFood.data == null) {
//       return Center(child: CircularProgressIndicator());
//     }

//     // if (fetchFood.error != null) {
//     //   return Center(child: Text(fetchFood.error!.message));
//     // }

//     return DefaultTabController(
//       length: 1,
//       child: Scaffold(
//         appBar: AppBar(
//           elevation: 0,
//           centerTitle: true,
//           title: const Text("Popular Foods"),
//           bottom: PreferredSize(
//             preferredSize: Size.fromHeight(50.0.h),
//             child: Align(
//               alignment: Alignment.topLeft,
//               child: TabBar(
//                 dividerColor: KColors.softGrey,
//                 onTap: (value) async {
//                   await fetchFood.refetch();
//                 },
//                 splashFactory: NoSplash.splashFactory,
//                 tabAlignment: TabAlignment.start,
//                 isScrollable: true,
//                 indicator: BoxDecoration(
//                   borderRadius: BorderRadius.circular(KSizes.borderRadiusMd),
//                 ),
//                 unselectedLabelColor: KColors.black,
//                 labelColor: Colors.white,
//                 tabs: [
//                   Tab(
//                     height: 40.h,
//                     child: Container(
//                       padding:
//                           const EdgeInsets.symmetric(horizontal: KSizes.md),
//                       decoration: BoxDecoration(
//                         borderRadius:
//                             BorderRadius.circular(KSizes.borderRadiusMd),
//                         color: KColors.secondary,
//                       ),
//                       child: const Align(
//                         alignment: Alignment.center,
//                         child: Text("All"),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           actions: [
//             IconButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, "/search");
//               },
//               icon: Icon(
//                 Icons.search,
//                 color: KColors.black,
//                 size: KSizes.iconMd + 3,
//               ),
//             ),
//             const CartCounterIcon(iconColor: KColors.black),
//           ],
//         ),
//         body: TabBarView(
//           children: [
//             RefreshIndicator(
//               onRefresh: fetchFood.refetch,
//               child: Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: KSizes.buttonHeight,
//                 ),
//                 child: ListView.builder(
//                   physics: const BouncingScrollPhysics(),
//                   controller: scrollController,
//                   itemCount: fetchFood.data!.length + 1,
//                   itemBuilder: (context, index) {
//                     if (index < fetchFood.data!.length) {
//                       final foodItem = fetchFood.data![index];
//                       return Padding(
//                         padding: const EdgeInsets.only(top: KSizes.md),
//                         child: ProductCardHorizontal(food: foodItem),
//                       );
//                     } else {
//                       // Show a loading indicator at the bottom when more data is being loaded
//                       return fetchFood.isLoading
//                           ? Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child:
//                                   Center(child: KIndicator.circularIndicator()),
//                             )
//                           : SizedBox(); // Empty space if not loading
//                     }
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
