import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chulesi/common/widgets/alert_box/alert_box.dart';
import 'package:chulesi/common/widgets/products/carts/cart_with_text_add_remove.dart';
import 'package:chulesi/common/widgets/products/products_text/product_price_text.dart';
import 'package:chulesi/common/widgets/products/products_text/product_title_text.dart';
import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/core/utils/constants/image_strings.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/data/models/cart_request.dart';
import 'package:chulesi/data/models/foods_with_offers_model.dart';
import 'package:chulesi/features/shop/providers/cart_provider.dart';
// import 'package:chulesi/features/shop/providers/foods_provider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

void showfoodOffersModel(BuildContext context, FoodsWithOffersModel food) {
  // final foodsProvider = Provider.of<FoodsProvider>(context, listen: false);
  // final cartProvider = Provider.of<CartProvider>(context, listen: false);
  // foodsProvider
  //     .resetCount(food.id); // Reset the count for the selected food item
  final box = GetStorage();

  String? token = box.read("token");

  showModalBottomSheet<void>(
    context: context,
    backgroundColor: KColors.white,
    enableDrag: false,
    showDragHandle: false,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(KSizes.borderRadiusLg),
            topRight: Radius.circular(KSizes.borderRadiusLg))),
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(KSizes.md),
        child: SizedBox(
            // height: 300.h,
            child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // image url,title, rating,ratingcount,price,heart
            Stack(
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(KSizes.sm),
                      child: SizedBox(
                        height: 100.h,
                        width: 100.w,
                        child: CachedNetworkImage(
                          imageUrl: food.imageUrl[0],
                          placeholder: (context, url) =>
                              Image.asset(KImages.placeholder_default),
                          errorWidget: (context, url, error) =>
                              Image.asset(KImages.placeholder_default),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: KSizes.md),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProductTitleText(
                          title: food.title,
                          smallSize: true,
                          maxlines: 1,
                        ),
                        // SizedBox(height: KSizes.spaceBtwItems / 2),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     RatingBarIndicator(
                        //       rating: food.rating.toDouble(),
                        //       itemSize: 15.sp,
                        //       unratedColor: KColors.grey,
                        //       itemBuilder: (_, __) {
                        //         return const Icon(
                        //           Iconsax.star1,
                        //           color: KColors.primary,
                        //         );
                        //       },
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
                                price: food.price.toStringAsFixed(1),
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
                                                      (food.offer
                                                              .discountValue /
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
                      ],
                    )
                  ],
                ),
                if (!food.isAvailable)
                  Container(
                    height: 100.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(KSizes.md),
                    ),
                    child: Center(
                      child: Text(
                        'Not Available',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            // fontSize: KSizes.fontSizeMd,
                            fontWeight: FontWeight.w500,
                            color: KColors.white),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: KSizes.spaceBtwItems),
            const Divider(
              height: 0.3,
              color: KColors.grey,
            ),
            SizedBox(height: KSizes.spaceBtwItems),
            // description

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProductTitleText(
                  title: "Description",
                  smallSize: true,
                ),
                (food.description).isEmpty
                    ? Text(
                        "No description available yet",
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    : Text(
                        food.description,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
              ],
            ),
            SizedBox(height: KSizes.spaceBtwItems),

            //total amount and price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Price:",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: KColors.primary, fontWeight: FontWeight.w600)),
                // Consumer<FoodsProvider>(builder: (context, value, child) {
                //   return Consumer<FoodsProvider>(
                //       builder: (context, foodsProvider, child) {
                //     return ProductPriceText(
                //       // price: "",
                //       price: "${food.price * value.getCount(food.id)}",
                //       color: KColors.primary,
                //     );
                //   });
                Consumer<CartProvider>(
                  builder: (context, cartProvider, child) {
                    final quantity = cartProvider.getItemQuantity(food.id);
                    final totalPrice = food.price * quantity;
                    return ProductPriceText(
                      price: totalPrice.toStringAsFixed(0),
                      color: KColors.primary,
                    );
                  },
                )
                // });
              ],
            ),
            SizedBox(height: KSizes.spaceBtwItems),
            //increment adn decrement and add to cart button
            Row(
              children: [
                CartWithTextAndAddRemoveButton(foodId: food.id),
                // CartWithTextAndAddRemoveButton(food: food),
                SizedBox(width: KSizes.spaceBtwSections),
                Expanded(
                  child: Consumer<CartProvider>(
                      builder: (context, cartProvider, child) {
                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(KSizes.sm))),
                        onPressed: token == null
                            ? () async {
                                // Navigator.pushNamed(context, "/login");
                                await CustomAlertBox.loginAlert(context);
                              }
                            : food.isAvailable == false
                                ? null
                                : () {
                                    final quantity =
                                        cartProvider.getItemQuantity(food.id);
                                    final totalPrice = food.price * quantity;
                                    var data = CartRequest(
                                      productId: food.id,
                                      totalPrice: totalPrice.toInt(),
                                      quantity: quantity,
                                    );
                                    String cart = cartRequestToJson(data);

                                    cartProvider.addToCart(context, cart);
                                  },
                        child: cartProvider.isLoading
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Add to Cart",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            // fontWeight: FontWeight.w600,
                                            color: KColors.white),
                                  ),
                                  const SizedBox(width: KSizes.md),
                                  SizedBox(
                                    height: 12.h,
                                    width: 12.w,
                                    child: const CircularProgressIndicator(
                                      color: KColors.white,
                                      strokeWidth: 1,
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                "Add to Cart",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        // fontWeight: FontWeight.w600,
                                        color: KColors.white),
                              ));
                  }),
                ),
              ],
            ),
          ],
        )),
      );
    },
  );
}
