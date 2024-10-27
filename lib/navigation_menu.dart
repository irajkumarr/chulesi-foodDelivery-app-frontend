import 'package:chulesi/common/widgets/alert_box/alert_box.dart';
import 'package:chulesi/features/shop/providers/category_provider.dart';
import 'package:chulesi/features/shop/providers/foods_list_provider.dart';
import 'package:chulesi/features/shop/providers/offers_food_list_provider.dart';
import 'package:chulesi/features/shop/providers/slider_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:chulesi/core/network/connectivity_checker.dart';
import 'package:chulesi/core/utils/exceptions/error_widget.dart';
import 'package:chulesi/features/personalization/screens/profile/profile.dart';
import 'package:chulesi/features/shop/screens/more/more_screen.dart';
import 'package:chulesi/features/shop/screens/category/all_category.dart';
import 'package:chulesi/features/shop/screens/home/home.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'core/utils/constants/colors.dart';
import 'core/utils/constants/sizes.dart';

class NavigationMenu extends HookWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> retryFetchData(BuildContext context) async {
      final foodsListProvider =
          Provider.of<FoodsListProvider>(context, listen: false);
      final categoryProvider =
          Provider.of<CategoryProvider>(context, listen: false);
      final sliderProvider =
          Provider.of<SliderProvider>(context, listen: false);
      final offersFoodListProvider =
          Provider.of<OffersFoodListProvider>(context, listen: false);

      await Future.wait([
        foodsListProvider.refetchNewFoodsList(),
        foodsListProvider.refetchBestRatedFoods(),
        foodsListProvider.refetchPopularFoodsList(),
        categoryProvider.refetchAllCategories(),
        categoryProvider.refetchCategories(),
        sliderProvider.refetchpromoSliders(),
        sliderProvider.refetchofferSliders(),
        offersFoodListProvider.refetchOfferFoodList(),
      ]);
    }

    final hasError = [
      Provider.of<FoodsListProvider>(context).error,
      Provider.of<OffersFoodListProvider>(context).error,
      Provider.of<CategoryProvider>(context).error,
      Provider.of<SliderProvider>(context).error,
    ].any((error) => error != null);

    if (hasError) {
      return Scaffold(
        body: Center(
          child: FullScreenErrorWidget(
            message: "Server Error",
            onRetry: () async {
              await retryFetchData(
                  context); // Ensure context is passed properly here
            },
          ),
        ),
      );
    }

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        return await CustomAlertBox.alertCloseApp(context);
      },
      child: ConnectivityChecker(
        child: Scaffold(
          bottomNavigationBar: Consumer<NavigationProvider>(
              builder: (context, navigationProvider, child) {
            return NavigationBar(
              elevation: 0,
              height: 80.h,
              selectedIndex: navigationProvider.selectedIndex,
              onDestinationSelected: (index) =>
                  navigationProvider.onItemTapped(index),
              backgroundColor: KColors.white,
              indicatorColor: KColors.black.withOpacity(0.1),
              destinations: [
                const NavigationDestination(
                  icon: Icon(Iconsax.home),
                  label: "Home",
                  selectedIcon: Icon(
                    Iconsax.home_15,
                    color: KColors.primary,
                  ),
                ),
                const NavigationDestination(
                  icon: Icon(Iconsax.category),
                  label: "Category",
                  selectedIcon: Icon(
                    Iconsax.category5,
                    color: KColors.primary,
                  ),
                ),
                NavigationDestination(
                  icon: Icon(
                    MaterialCommunityIcons.account_outline,
                    size: KSizes.iconMd + 3,
                  ),
                  label: "Account",
                  selectedIcon: Icon(
                    MaterialCommunityIcons.account,
                    size: KSizes.iconMd + 3,
                    color: KColors.primary,
                  ),
                ),
                const NavigationDestination(
                  icon: Icon(Iconsax.more_square),
                  label: "More",
                  selectedIcon: Icon(
                    Iconsax.more_square5,
                    color: KColors.primary,
                  ),
                ),
              ],
            );
          }),
          body: Consumer<NavigationProvider>(
              builder: (context, navigationProvider, child) {
            return navigationProvider.screens
                .elementAt(navigationProvider.selectedIndex);
          }),
        ),
      ),
    );
  }
}

class NavigationProvider with ChangeNotifier {
  var selectedIndex = 0;
  final screens = [
    const HomeScreen(),
    const AllCategoryScreen(),
    const ProfileScreen(),
    const MoreScreen(),
  ];

  void onItemTapped(index) {
    selectedIndex = index;
    notifyListeners();
  }

  void goToHome() {
    selectedIndex = 0;
    notifyListeners();
  }
}

