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
import 'package:chulesi/data/models/foods_model.dart';
import 'package:chulesi/features/shop/providers/cart_provider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

void showFoodModalSheet(BuildContext context, FoodsModel food) {
  final box = GetStorage();

  final bool hasOffer = food.offer != null && food.offer!.discountValue > 0;
  final double originalPrice = food.price.toDouble();
  final double discountedPrice = hasOffer
      ? (food.offer!.discountType == "flat")
          ? originalPrice - food.offer!.discountValue
          : originalPrice * (1 - (food.offer!.discountValue / 100))
      : originalPrice;

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
                              Image.asset(KImages.chulesi_placeholder),
                          errorWidget: (context, url, error) =>
                              Image.asset(KImages.chulesi_placeholder),
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
                        SizedBox(height: KSizes.spaceBtwItems / 2),
                        if (hasOffer)
                          Row(
                            children: [
                              ProductPriceText(
                                price: discountedPrice.toStringAsFixed(0),
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
                            price: originalPrice.toStringAsFixed(0),
                            color: KColors.black,
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
                      borderRadius: BorderRadius.circular(KSizes.sm),
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
                        "Description not provided yet",
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    : Text(
                        food.description,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
              ],
            ),
            SizedBox(height: KSizes.spaceBtwItems),
            // Note about item images
            Text(
              "*Note- Item images can be different from real ones",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: KColors.grey,
                    fontStyle: FontStyle.italic,
                  ),
            ),

            SizedBox(height: KSizes.spaceBtwItems),
            //total amount and price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Price:",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: KColors.primary, fontWeight: FontWeight.w600)),

                Consumer<CartProvider>(
                  builder: (context, cartProvider, child) {
                    final quantity = cartProvider.getItemQuantity(food.id);
                    final totalPrice = discountedPrice * quantity;
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
                    // final isAlreadyInCart =
                    //     cartProvider.getItemQuantity(food.id) > 1;

                    // if (isAlreadyInCart) {
                    //   return ElevatedButton(
                    //     onPressed: null,
                    //     style: ElevatedButton.styleFrom(
                    //         backgroundColor: Colors.grey),
                    //     child: Text(
                    //       "Already in Cart",
                    //       style: Theme.of(context)
                    //           .textTheme
                    //           .titleMedium!
                    //           .copyWith(color: KColors.white),
                    //     ),
                    //   );
                    // }
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          disabledBackgroundColor: KColors.primary,
                          disabledForegroundColor: KColors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(KSizes.sm))),
                      onPressed: token == null
                          ? () async {
                              await CustomAlertBox.loginAlert(context);
                            }
                          : cartProvider.isLoading ||
                                  food.isAvailable == false ||
                                  !food.isAvailable
                              ? null
                              : () async {
                                  final quantity =
                                      cartProvider.getItemQuantity(food.id);
                                  final totalPrice = food.price * quantity;
                                  var data = CartRequest(
                                    productId: food.id,
                                    totalPrice: totalPrice,
                                    quantity: quantity,
                                  );
                                  String cart = cartRequestToJson(data);

                                  await cartProvider.addToCart(context, cart);
                                  Navigator.pop(context);
                                },
                      child: cartProvider.isLoading
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Adding to Cart",
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
                          : food.isAvailable
                              ? Text("Add to Cart",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: KColors.white))
                              : Tooltip(
                                  message: 'This item is unavailable',
                                  child: Text(
                                    "Add to Cart",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(color: KColors.primary),
                                  ),
                                ),
                    );
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
