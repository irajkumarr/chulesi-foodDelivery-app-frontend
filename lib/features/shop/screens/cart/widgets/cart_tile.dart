import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:chulesi/common/widgets/products/products_text/product_price_text.dart';
import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/data/models/cart_response.dart';
import 'package:chulesi/features/shop/providers/cart_provider.dart';
// import 'package:chulesi/features/shop/providers/foods_provider.dart';

import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../../../../common/widgets/products/products_text/product_title_text.dart';

class CartTile extends StatelessWidget {
  const CartTile({
    super.key,
    required this.cart,
    this.refetch,
  });

  final CartResponse cart;
  final Function()? refetch;

  @override
  Widget build(BuildContext context) {
    // final foodProvider = Provider.of<FoodsProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    // final foodId = cart.productId.id;
    // final count = foodProvider.getCount(foodId);
    // final foodId = cart.productId.id;
    // final count = foodProvider.getCount(foodId);
    final foodId = cart.productId.id;
    // final count = cartProvider.getItemQuantity(foodId);
    // final price = cart.productId.price;
    // final box = GetStorage();
    // String userId = box.read("userId");
    // final count = cartProvider.fetchCartCount(userId);

    return Container(
      margin: const EdgeInsets.only(top: KSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(
          //   width: 60.w,
          //   height: 60.h,
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(KSizes.sm),
          //     child: CachedNetworkImage(
          //       imageUrl: cart.productId.imageUrl[0],
          //       placeholder: (context, url) => SizedBox(
          //           width: 60.w,
          //           height: 60.h,
          //           child: Image.asset(
          //             KImages.placeholder_image,
          //             fit: BoxFit.cover,
          //           )),
          //       errorWidget: (context, url, error) =>
          //           Image.asset(KImages.placeholder_image),
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          SizedBox(height: KSizes.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ProductTitleText(
                title: cart.productId.title,
                smallSize: true,
              ),
              ProductPriceText(
                price: "${cart.totalPrice}",
                // price: "$price",
                color: KColors.black,
              ),
            ],
          ),
          SizedBox(height: KSizes.xs),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Rs.${cart.productId.price}",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: KColors.darkGrey,
                  ),
                  borderRadius: BorderRadius.circular(KSizes.xs),
                ),
                child: Row(
                  children: [
                    cart.quantity == 1
                        // count == 1
                        ? InkWell(
                            onTap: () {
                              cartProvider.removeFromCart(cart.id, refetch!);
                            
                            },
                            child: const Icon(
                              MaterialCommunityIcons.trash_can_outline,
                              color: KColors.darkGrey,
                              size: KSizes.md + 6,
                            ))
                        : InkWell(
                            onTap: () async {
                              // foodProvider.decrement(foodId);
                              await cartProvider.decrement(foodId);
                              refetch?.call();
                              // cartProvider.
                            },
                            child: const Icon(
                              Iconsax.minus,
                              size: KSizes.md + 6,
                            ),
                          ),
                    SizedBox(width: KSizes.sm),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: KSizes.sm),
                        decoration: const BoxDecoration(color: KColors.grey),
                        child: Text("${cart.quantity}",
                            // Text("${count}",
                            style: Theme.of(context).textTheme.titleMedium)),
                    SizedBox(width: KSizes.sm),
                    InkWell(
                      onTap: () async {
                        // foodProvider.increment(foodId);
                        // cartProvider.increment(foodId);
                        await cartProvider.increment(foodId);
                        refetch?.call();
                        // cartProvider.addToCart(context, cart.id);
                      },
                      child: const Icon(
                        Icons.add,
                        color: KColors.primary,
                        size: KSizes.md + 6,
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}