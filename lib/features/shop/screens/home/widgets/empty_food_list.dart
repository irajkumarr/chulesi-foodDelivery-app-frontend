import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/sizes.dart';

class EmptyFoodList extends StatelessWidget {
  final VoidCallback? onRefresh;
  final VoidCallback? onBrowseCategories;

  const EmptyFoodList({
    super.key,
    this.onRefresh,
    this.onBrowseCategories,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(KSizes.defaultSpace),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon with background
              Container(
                padding: EdgeInsets.all(KSizes.lg),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  MaterialCommunityIcons.food_outline,
                  size: 64,
                  color: Colors.grey.shade400,
                ),
              ),

              SizedBox(height: KSizes.spaceBtwItems),

              // Title
              Text(
                'No Food Found',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: KColors.black,
                    ),
              ),

              SizedBox(height: KSizes.sm),

              // Description
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: KSizes.defaultSpace),
                child: Text(
                  'There are currently no food items available in this category. Please check back later or try another category.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.grey.shade600,
                      ),
                ),
              ),

              SizedBox(height: KSizes.spaceBtwItems),

              // Primary Button - Browse Categories
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: onBrowseCategories,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: KColors.primary,
                    padding: EdgeInsets.symmetric(
                      vertical: KSizes.buttonHeight,
                    ),
                  ),
                  child: Text(
                    'Browse Categories',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: KColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),

              SizedBox(height: KSizes.spaceBtwItems / 2),

              // Secondary Button - Refresh
              SizedBox(
                width: 200,
                child: TextButton(
                  onPressed: onRefresh,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: KSizes.buttonHeight,
                    ),
                  ),
                  child: Text(
                    'Refresh',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: KColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
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
