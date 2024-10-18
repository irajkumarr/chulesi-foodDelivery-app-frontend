import 'package:chulesi/core/utils/helpers/custom_cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/image_strings.dart';
import '../../../../core/utils/constants/sizes.dart';
import '../../../../core/utils/device/device_utility.dart';
import '../../../../data/models/foods_with_offers_model.dart';
import '../../../../features/shop/screens/food/food_offers_model_sheet.dart';
import '../../custom_shapes/container/rounded_container.dart';
import '../products_text/product_price_text.dart';
import '../products_text/product_title_text.dart';

class FoodOffersTileVertical extends StatelessWidget {
  const FoodOffersTileVertical({
    super.key,
    required this.food,
  });
  final FoodsWithOffersModel food;

  @override
  Widget build(BuildContext context) {
    // double originalPrice = food.offer.discountType == "flat"
    //     ? food.price + food.offer.discountValue
    //     : food.price / (1 - (food.offer.discountValue / 100));
    return GestureDetector(
      onTap: () {
        showfoodOffersModel(context, food);
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
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(KSizes.productImageRadius),
                          topRight: Radius.circular(KSizes.productImageRadius),
                        ),
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
                                KImages.placeholder_default,
                                fit: BoxFit.cover,
                              ),
                            ),
                            // placeholder: (context, url) => SizedBox(
                            //     height: 150.h,
                            //     width: KDeviceUtils.getScreenWidth(context),
                            //     child: Center(
                            //       child: KIndicator.circularIndicator(),
                            //     )),
                            errorWidget: (context, url, error) => Image.asset(
                              KImages.placeholder_default,
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
                      food.offer.discountValue == 0
                          ? ProductPriceText(
                              price: food.price.toStringAsFixed(0),
                              color: KColors.black,
                            )
                          : Row(
                              children: [
                                food.offer.discountType == "flat"
                                    ? ProductPriceText(
                                        price: (food.price +
                                                food.offer.discountValue)
                                            .toStringAsFixed(0),
                                        color: KColors.black,
                                        lineThrough: true,
                                      )
                                    : ProductPriceText(
                                        price: (food.price /
                                                (1 -
                                                    (food.offer.discountValue /
                                                        100)))
                                            .toStringAsFixed(0),
                                        color: KColors.black,
                                        lineThrough: true,
                                      ),
                                SizedBox(width: KSizes.sm),
                                ProductPriceText(
                                  price: food.price.toStringAsFixed(1),
                                  color: KColors.black,
                                  // lineThrough: true,
                                ),
                              ],
                            ),
                      // food.offer.discountValue == 0
                      //     ? ProductPriceText(
                      //         price: originalPrice.toStringAsFixed(1),
                      //         color: KColors.black,
                      //       )
                      //     : Row(
                      //         children: [
                      //           ProductPriceText(
                      //             price: originalPrice.toStringAsFixed(1),
                      //             color: KColors.black,
                      //             lineThrough: true,
                      //           ),
                      //           SizedBox(width: KSizes.sm),
                      //           ProductPriceText(
                      //             price: food.price.toStringAsFixed(1),
                      //             color: KColors.black,
                      //           ),
                      //         ],
                      //       ),
                    ],
                  ),
                ),
              ],
            ),
            if (!food.isAvailable)
              Container(
                height: 160.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(KSizes.productImageRadius),
                    topRight: Radius.circular(KSizes.productImageRadius),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Not Available',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: KSizes.fontSizeLg,
                        fontWeight: FontWeight.w600,
                        color: KColors.white),
                  ),
                ),
              ),
            Positioned(
              right: 5,
              bottom: 23,
              child: Material(
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
            Positioned(
              left: 7,
              top: 5,
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: KSizes.xs, horizontal: KSizes.sm),
                decoration: BoxDecoration(
                  color: KColors.primary,
                  borderRadius: BorderRadius.circular(KSizes.xs),
                ),
                child: food.offer.discountType == 'flat'
                    ? Text(
                        "Rs.${food.offer.discountValue} off",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: KColors.white,
                            ),
                      )
                    : Text(
                        "${food.offer.discountValue}% off",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: KColors.white,
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
