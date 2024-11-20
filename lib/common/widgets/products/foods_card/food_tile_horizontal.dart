import 'package:chulesi/core/utils/helpers/custom_cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/image_strings.dart';
import '../../../../core/utils/constants/sizes.dart';
import '../../../../data/models/foods_model.dart';
import '../../../../features/shop/screens/food/food_screen.dart';
import '../products_text/product_price_text.dart';
import '../products_text/product_title_text.dart';

class ProductCardHorizontal extends StatelessWidget {
  const ProductCardHorizontal({
    super.key,
    required this.food,
  });

  final FoodsModel food;

  @override
  Widget build(BuildContext context) {
    // final bool hasOffer = food.offer != null && food.offer!.discountValue > 0;
    // final double discountedPrice = food.price.toDouble();
    // final double originalPrice = hasOffer
    //     ? (food.offer!.discountType == "flat")
    //         ? discountedPrice + food.offer!.discountValue
    //         : discountedPrice * (1 + (food.offer!.discountValue / 100))
    //     : discountedPrice;
    final bool hasOffer = food.offer != null && food.offer!.discountValue > 0;
    final double originalPrice = food.price.toDouble();
    final double discountedPrice = hasOffer
        ? (food.offer!.discountType == "flat")
            ? originalPrice - food.offer!.discountValue
            : originalPrice * (1 - (food.offer!.discountValue / 100))
        : originalPrice;
    return GestureDetector(
      onTap: () {
        showFoodModalSheet(context, food);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 120.h,
        padding: EdgeInsets.all(4.h),
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: KColors.softGrey,
                spreadRadius: 3,
                blurRadius: 2,
                offset: Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.circular(KSizes.md),
            color: KColors.white),
        child: Stack(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 115.w,
                  height: 115.h,

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(KSizes.md),
                    child: CachedNetworkImage(
                      imageUrl: food.imageUrl[0],
                      cacheKey: food.id,
                      cacheManager: MyCustomCacheManager.instance,
                      placeholder: (context, url) => SizedBox(
                          width: 115.w,
                          height: 115.h,
                          child: Image.asset(
                            KImages.chulesi_placeholder,
                            fit: BoxFit.cover,
                          )),
                      errorWidget: (context, url, error) =>
                          Image.asset(KImages.chulesi_placeholder),
                      fit: BoxFit.cover,
                    ),
                  ),
                  //  RoundedImage(
                  //   imageUrl: imageUrl,
                  //   isNetworkImage: true,
                  // ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: KSizes.md, top: KSizes.sm),
                  child: SizedBox(
                    width: 170,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const SizedBox(height: KSizes.spaceBtwItems),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ProductTitleText(
                              title: food.title,
                              smallSize: true,
                            ),
                            // SizedBox(
                            //   height: KSizes.spaceBtwItems / 2,
                            // ),
                            // Row(
                            //   children: [
                            //     Icon(
                            //       Icons.star,
                            //       color: KColors.primary,
                            //       size: KSizes.iconSm,
                            //     ),
                            //     SizedBox(
                            //       width: KSizes.sm,
                            //     ),
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
                            //     Text(
                            //       "(${food.ratingCount})",
                            //       style: Theme.of(context)
                            //           .textTheme
                            //           .labelSmall!
                            //           .copyWith(color: KColors.textGrey),
                            //     ),
                            //   ],
                            // ),
                            SizedBox(
                              height: KSizes.spaceBtwItems / 2,
                            ),
                            if (hasOffer)
                              Row(
                                children: [
                                  ProductPriceText(
                                    price: discountedPrice.toStringAsFixed(1),
                                    color: KColors.primary,
                                  ),
                                  SizedBox(width: KSizes.sm),
                                  ProductPriceText(
                                    price: originalPrice.toStringAsFixed(0),
                                    color: KColors.black,
                                    lineThrough: true,
                                  )
                                ],
                              )
                            else
                              ProductPriceText(
                                price: originalPrice.toStringAsFixed(1),
                                color: KColors.black,
                              ),
                            // ProductPriceText(
                            //   price: food.price.toStringAsFixed(1),
                            // ),
                          ],
                        ),
                        // Spacer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (!food.isAvailable)
              Container(
                width: 115.w,
                height: 115.h,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(KSizes.md),
                ),
                child: Center(
                  child: Text(
                    'Not Available for this time',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        // fontSize: KSizes.fontSizeMd,
                        fontWeight: FontWeight.w500,
                        color: KColors.white),
                  ),
                ),
              ),
            // Offer badge
            if (hasOffer)
              Positioned(
                left: 7,
                top: 5,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: KSizes.xs,
                    horizontal: KSizes.sm,
                  ),
                  decoration: BoxDecoration(
                    color: KColors.primary,
                    borderRadius: BorderRadius.circular(KSizes.xs),
                  ),
                  child: Text(
                    food.offer!.discountType == 'flat'
                        ? "Rs.${food.offer!.discountValue} off"
                        : "${food.offer!.discountValue}% off",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: KColors.white,
                        ),
                  ),
                ),
              ),
            Positioned(
              bottom: 0,
              right: 5,
              child: SizedBox(
                width: KSizes.iconMd,
                height: KSizes.iconMd,
                child: Icon(
                  Icons.add,
                  size: KSizes.iconMd,
                  color: KColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
