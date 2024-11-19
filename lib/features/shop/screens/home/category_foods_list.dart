import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:chulesi/common/widgets/products/carts/cart_counter_icon.dart';
import 'package:chulesi/common/widgets/products/foods_card/food_tile_horizontal.dart';
import 'package:chulesi/core/network/connectivity_checker.dart';
import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/core/utils/shimmers/foodlist_shimmer.dart';
import 'package:chulesi/data/hooks/fetch_category_foods.dart';
import 'package:chulesi/data/hooks/fetch_category_nonveg_foods.dart';
import 'package:chulesi/data/hooks/fetch_category_veg_foods.dart';
import 'package:chulesi/data/models/foods_model.dart';
import 'package:chulesi/features/shop/providers/category_provider.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class CategoryFoodsList extends HookWidget {
  const CategoryFoodsList({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final hookResultAll =
        useFetchAllCategoryFoods(categoryProvider.categoryValue);
    List<FoodsModel>? allFoodsList = hookResultAll.data;
    final isLoadingAll = hookResultAll.isLoading;
    // final errorAll = hookResultAll.error;

    final hookResultVeg =
        useFetchCategoryVegFoods(categoryProvider.categoryValue);
    List<FoodsModel>? vegFoodsList = hookResultVeg.data;
    final isLoadingVeg = hookResultVeg.isLoading;
    // final errorVeg = hookResultVeg.error;

    final hookResultNonveg =
        useFetchCategoryNonvegFoods(categoryProvider.categoryValue);
    List<FoodsModel>? nonvegFoodsList = hookResultNonveg.data;
    final isLoadingNonveg = hookResultNonveg.isLoading;
    // final errorNonveg = hookResultNonveg.error;

    // if (errorAll != null) {
    //   return Scaffold(
    //     body: Center(
    //       child: FullScreenErrorWidget(
    //         message: errorAll.message,
    //         onRetry: () {
    //           hookResultAll.refetch();
    //           hookResultVeg.refetch();
    //           hookResultNonveg.refetch();
    //         },
    //       ),
    //     ),
    //   );
    // }

    return ConnectivityChecker(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              categoryProvider.titleValue,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                tooltip: "Search",
                onPressed: () {
                  Navigator.pushNamed(context, "/search");
                },
                icon: Icon(
                  AntDesign.search1,
                  size: KSizes.iconMd,
                ),
              ),
              const CartCounterIcon(iconColor: KColors.black),
            ],
            bottom: TabBar(
              dividerColor: KColors.grey,
              indicatorColor: KColors.primary,
              labelColor: KColors.primary,
              labelStyle: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w600),
              tabs: const [
                Tab(text: "All"),
                Tab(text: "Veg"),
                Tab(text: "Non-veg"),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(right: KSizes.md, left: KSizes.md),
            child: TabBarView(
              children: [
                // All foods
                RefreshIndicator(
                  onRefresh: () async {
                    await hookResultAll.refetch();
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: isLoadingAll
                        ? const Padding(
                            padding: EdgeInsets.only(top: KSizes.md),
                            child: FoodsListShimmer(),
                          )
                        : (allFoodsList == null || allFoodsList.isEmpty)
                            ? Center(
                                child: Text(
                                "No Food Items Found",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ))
                            : ListView(
                                physics: const BouncingScrollPhysics(),
                                children:
                                    List.generate(allFoodsList.length, (index) {
                                  FoodsModel food = allFoodsList[index];
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(top: KSizes.md),
                                    child: ProductCardHorizontal(
                                      food: food,
                                    ),
                                  );
                                }),
                              ),
                  ),
                ),
                // Veg foods
                RefreshIndicator(
                  onRefresh: () async {
                    await hookResultVeg.refetch();
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: isLoadingVeg
                        ? const Padding(
                            padding: EdgeInsets.only(top: KSizes.md),
                            child: FoodsListShimmer(),
                          )
                        : (vegFoodsList == null || vegFoodsList.isEmpty)
                            ? Center(
                                child: Text(
                                "No Items Found",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ))
                            : ListView(
                                physics: const BouncingScrollPhysics(),
                                children:
                                    List.generate(vegFoodsList.length, (index) {
                                  FoodsModel food = vegFoodsList[index];
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(top: KSizes.md),
                                    child: ProductCardHorizontal(
                                      food: food,
                                    ),
                                  );
                                }),
                              ),
                  ),
                ),
                // Non-veg foods
                RefreshIndicator(
                  onRefresh: () async {
                    await hookResultNonveg.refetch();
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: isLoadingNonveg
                        ? const Padding(
                            padding: EdgeInsets.only(top: KSizes.md),
                            child: FoodsListShimmer(),
                          )
                        : (nonvegFoodsList == null || nonvegFoodsList.isEmpty)
                            ? Center(
                                child: Text(
                                "No Items Found",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ))
                            : ListView(
                                physics: const BouncingScrollPhysics(),
                                children: List.generate(nonvegFoodsList.length,
                                    (index) {
                                  FoodsModel food = nonvegFoodsList[index];
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(top: KSizes.md),
                                    child: ProductCardHorizontal(
                                      food: food,
                                    ),
                                  );
                                }),
                              ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
