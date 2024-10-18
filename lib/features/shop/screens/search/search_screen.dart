import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:chulesi/core/network/connectivity_checker.dart';
import 'package:chulesi/core/utils/circular_progress_indicator/circlular_indicator.dart';
import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/features/shop/providers/search_provider.dart';
import 'package:chulesi/features/shop/screens/search/search_results.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchController;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
      final searchProvider =
          Provider.of<SearchProvider>(context, listen: false);
      searchProvider.updateSearchText(value);
      searchProvider.searchFoods(value); // Trigger search after debounce
    });
  }

  void _onSearchSubmitted(String value) {
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    searchProvider.updateSearchText(value);
    searchProvider.searchFoods(value); // Trigger search on search action
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityChecker(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: KColors.secondaryBackground,
          titleSpacing: 0,
          toolbarHeight: 80.h,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: KSizes.md),
            child: Consumer<SearchProvider>(
              builder: (context, searchProvider, child) {
                // Sync TextField with provider's search text
                if (_searchController.text != searchProvider.searchText) {
                  _searchController.text = searchProvider.searchText;
                }

                return TextField(
                  autofocus: true,
                  controller: _searchController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.search,
                  mouseCursor: SystemMouseCursors.basic,
                  onChanged: _onSearchChanged,
                  enableSuggestions: true,
                  onSubmitted: _onSearchSubmitted,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder().copyWith(
                      borderRadius: BorderRadius.circular(KSizes.defaultSpace),
                      borderSide:
                          const BorderSide(width: 1, color: KColors.primary),
                    ),
                    enabledBorder: const OutlineInputBorder().copyWith(
                      borderRadius: BorderRadius.circular(KSizes.defaultSpace),
                      borderSide:
                          const BorderSide(width: 1, color: KColors.primary),
                    ),
                    disabledBorder: const OutlineInputBorder().copyWith(
                      borderRadius: BorderRadius.circular(KSizes.defaultSpace),
                      borderSide:
                          const BorderSide(width: 1, color: KColors.secondary),
                    ),
                    focusedBorder: const OutlineInputBorder().copyWith(
                      borderRadius: BorderRadius.circular(KSizes.defaultSpace),
                      borderSide:
                          const BorderSide(width: 0.3, color: KColors.primary),
                    ),
                    errorBorder: const OutlineInputBorder().copyWith(
                      borderRadius: BorderRadius.circular(KSizes.defaultSpace),
                      borderSide:
                          const BorderSide(width: 2, color: KColors.error),
                    ),
                    focusedErrorBorder: const OutlineInputBorder().copyWith(
                      borderRadius: BorderRadius.circular(KSizes.defaultSpace),
                      borderSide:
                          const BorderSide(width: 2, color: KColors.error),
                    ),
                    hintText: "What are you looking for...",
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        if (searchProvider.isTrigger) {
                          searchProvider.clearSearch();
                          _searchController.clear();
                        } else {
                          searchProvider.searchFoods(_searchController.text);
                        }
                      },
                      child: Icon(
                        searchProvider.isTrigger
                            ? Iconsax.close_circle
                            : AntDesign.search1,
                        color: KColors.black,
                        size: KSizes.iconMd,
                      ),
                    ),
                    prefixIcon: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back, color: KColors.black),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: KSizes.md, right: KSizes.md),
          child: Consumer<SearchProvider>(
            builder: (context, searchProvider, child) {
              if (searchProvider.isLoading) {
                // return const FoodsListShimmer();
                return KIndicator.circularIndicator();
              } else if (searchProvider.searchResults == null) {
                return const SizedBox();
              } else if (searchProvider.searchResults!.isEmpty) {
                return Center(
                  child: Text(
                    'Search results not found',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                );
              } else {
                return const SearchResults();
              }
            },
          ),
        ),
      ),
    );
  }
}
