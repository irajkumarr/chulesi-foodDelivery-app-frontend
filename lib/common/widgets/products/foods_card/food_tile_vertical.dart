import 'package:chulesi/core/utils/helpers/custom_cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get_storage/get_storage.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/image_strings.dart';
import '../../../../core/utils/constants/sizes.dart';
import '../../../../core/utils/device/device_utility.dart';
import '../../../../data/models/foods_model.dart';
import '../../../../features/shop/screens/food/food_screen.dart';
import '../../custom_shapes/container/rounded_container.dart';
import '../products_text/product_price_text.dart';
import '../products_text/product_title_text.dart';

class ProductCardVertical extends StatelessWidget {
  const ProductCardVertical({
    super.key,
    required this.food,
  });
  final FoodsModel food;

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    // String? token = box.read("token");

    return GestureDetector(
      onTap: () {
        showFoodModalSheet(context, food);
      },
      child: Container(
        width: 185.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(KSizes.productImageRadius),
          color: KColors.white,
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RoundedContainer(
                  color: KColors.white,
                  padding: const EdgeInsets.all(3),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(KSizes.md),
                        child: SizedBox(
                          height: 160.h,
                          width: KDeviceUtils.getScreenWidth(context),
                          child: CachedNetworkImage(
                            imageUrl: food.imageUrl[0],
                            cacheKey: food.id,
                            cacheManager: MyCustomCacheManager.instance,
                            placeholder: (context, url) => SizedBox(
                              height: 150.h,
                              width: KDeviceUtils.getScreenWidth(context),
                              child: Image.asset(
                                KImages.food_placeholder,
                                fit: BoxFit.cover,
                              ),
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              KImages.food_placeholder,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: KSizes.md),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: KSizes.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductTitleText(
                        title: food.title,
                        smallSize: true,
                        maxlines: 1,
                      ),
                      // SizedBox(
                      //   height: KSizes.xs,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Text(
                      //       food.rating.toStringAsFixed(1),
                      //       style: Theme.of(context)
                      //           .textTheme
                      //           .bodyMedium!
                      //           .copyWith(fontWeight: FontWeight.w600),
                      //     ),
                      //     SizedBox(
                      //       width: KSizes.sm,
                      //     ),
                      //     Icon(
                      //       Icons.star,
                      //       color: KColors.primary,
                      //       size: KSizes.iconSm,
                      //     ),
                      //     SizedBox(
                      //       width: KSizes.sm,
                      //     ),
                      //     Text(
                      //       "(${food.ratingCount})",
                      //       style: Theme.of(context)
                      //           .textTheme
                      //           .labelSmall!
                      //           .copyWith(color: KColors.textGrey),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(height: KSizes.spaceBtwItems / 2),
                      ProductPriceText(
                        price: food.price.toStringAsFixed(1),
                        color: KColors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (!food.isAvailable)
              Padding(
                padding: const EdgeInsets.all(3),
                child: Container(
                  height: 160.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(KSizes.md),
                  ),
                  child: Center(
                    child: Text(
                      'Not Available',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          // fontSize: KSizes.fontSizeLg,
                          fontWeight: FontWeight.w600,
                          color: KColors.white),
                    ),
                  ),
                ),
              ),
            Positioned(
              right: 5,
              bottom: 23,
              child: Material(
                elevation: 0,
                color: KColors.white,
                borderRadius: BorderRadius.circular(50),
                child: SizedBox(
                  child: Icon(
                    Icons.add,
                    size: KSizes.iconMd,
                    color: KColors.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
