import 'package:flutter/material.dart';

import 'package:iconsax/iconsax.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/sizes.dart';
import '../../../../core/utils/device/device_utility.dart';
import '../../../../core/utils/helpers/helper_functions.dart';

class SearchContainer extends StatelessWidget {
   const SearchContainer({
    super.key,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: KSizes.defaultSpace),
  });
  final bool showBackground, showBorder;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final dark = KHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Container(
          width: KDeviceUtils.getScreenWidth(context),
          padding:  const EdgeInsets.all(KSizes.md),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(KSizes.cardRadiusLg),
              color: showBackground
                  ? dark
                      ? KColors.dark
                      : KColors.light
                  : Colors.transparent,
              border: showBorder ? Border.all(color: KColors.grey) : null),
          child: Row(children: [
            const Icon(
              Iconsax.search_normal,
              color: KColors.darkerGrey,
            ),
             SizedBox(width: KSizes.spaceBtwItems),
            Text(
              "Search in store",
              style: Theme.of(context).textTheme.bodySmall,
            )
          ]),
        ),
      ),
    );
  }
}
