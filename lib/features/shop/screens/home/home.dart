import 'package:chulesi/features/shop/providers/category_provider.dart';
import 'package:chulesi/features/shop/providers/foods_list_provider.dart';
import 'package:chulesi/features/shop/providers/offers_food_list_provider.dart';
import 'package:chulesi/features/shop/providers/slider_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chulesi/core/network/connectivity_checker.dart';
import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/features/personalization/providers/map_provider.dart';
import 'package:chulesi/features/shop/screens/home/explore_category.dart';
import 'package:chulesi/features/shop/screens/home/widgets/home_add_address_widget.dart';
import 'package:chulesi/features/shop/screens/home/widgets/home_app_bar.dart';
import 'package:chulesi/features/shop/screens/home/widgets/home_banner.dart';
import 'package:chulesi/features/shop/screens/home/widgets/home_best_rated_foods.dart';
import 'package:chulesi/features/shop/screens/home/widgets/home_food_offers.dart';
import 'package:chulesi/features/shop/screens/home/widgets/home_popular_foods.dart';
import 'package:chulesi/features/shop/screens/home/widgets/home_recommended_foods.dart';
import 'package:chulesi/features/shop/screens/home/widgets/home_slider_and_category_list.dart';
import 'package:provider/provider.dart';

import 'widgets/home_offer_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<MapProvider>(context, listen: false);

    // Fetch the current location and address when the home screen is loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // mapProvider.updateCurrentLocation();
      // mapProvider.getCurrentLocation();
      mapProvider.getCurrentLocation();
    });

    Future<void> retryFetchData() async {
      await Future.wait([
        Provider.of<FoodsListProvider>(context, listen: false)
            .refetchNewFoodsList(),
        Provider.of<FoodsListProvider>(context, listen: false)
            .refetchBestRatedFoods(),
        Provider.of<FoodsListProvider>(context, listen: false)
            .refetchPopularFoodsList(),
        Provider.of<OffersFoodListProvider>(context, listen: false)
            .refetchOfferFoodList(),
        Provider.of<CategoryProvider>(context, listen: false)
            .refetchAllCategories(),
        Provider.of<CategoryProvider>(context, listen: false)
            .refetchCategories(),
        Provider.of<SliderProvider>(context, listen: false)
            .refetchpromoSliders(),
        Provider.of<SliderProvider>(context, listen: false)
            .refetchofferSliders(),
      ]);
    }

    return ConnectivityChecker(
      child: Scaffold(
        backgroundColor: KColors.secondaryBackground,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56.h),
          child: const HomeAppBar(),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 2));
            await retryFetchData();
          },
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const HomeSliderAndCategoryList(),
              const HomeFoodOffers(),
              const SizedBox(height: KSizes.md),
              const HomeOfferSlider(),
              SizedBox(height: KSizes.defaultSpace),
              const HomeBestRatedFoods(),
              // const SizedBox(height: KSizes.md),
              const HomeAddAddressWidget(),
              const SizedBox(height: KSizes.md),
              const HomePopularFoods(),
              const HomeBanner(),
              const SizedBox(height: KSizes.md),
              const HomeRecommendedFoods(),
              const SizedBox(height: KSizes.md),
              const ExploreCategoryScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
