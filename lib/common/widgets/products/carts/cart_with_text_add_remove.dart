import 'package:flutter/material.dart';
import 'package:chulesi/features/shop/providers/cart_provider.dart';

import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/sizes.dart';
import '../../icons_widget/circular_icon.dart';

class CartWithTextAndAddRemoveButton extends StatelessWidget {
  final String foodId;
  // final FoodsModel food;
  const CartWithTextAndAddRemoveButton({
    super.key,
    required this.foodId,
  });

  @override
  Widget build(BuildContext context) {
    // final foodsProvider = Provider.of<FoodsProvider>(context);
    // final cartProvider = Provider.of<CartProvider>(context);
    // final count = cartProvider.getItemQuantity(foodId);
    // final box = GetStorage();
    // String userId = box.read("userId") ?? '';

    return Consumer<CartProvider>(builder: (context, cartProvider, child) {
      final count = cartProvider.getItemQuantity(foodId);
      return Row(
        children: [
          CircularIcon(
            icon: Iconsax.minus,
            iconColor: KColors.black,
            bgColor: KColors.light,
            onPressed: () async {
              await cartProvider.decrement(foodId);

              // foodsProvider.decrement(foodId);
            },
          ),
          SizedBox(
            width: KSizes.spaceBtwItems,
          ),
          // Consumer<CartProvider>(
          //   builder: (context, value, child) {
          //     // Use the cartProvider's getItemQuantity method
          //     // final quantity = value.getItemQuantity(foodId);
          //     // final quantity = value.cartCount;
          //     final count = value.getItemQuantity(foodId);
          // return
          Text(
            // "${foodsProvider.getCount(foodId)}",
            "$count",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          // },
          // ),
          SizedBox(
            width: KSizes.spaceBtwItems,
          ),
          CircularIcon(
            icon: Iconsax.add,
            iconColor: KColors.white,
            bgColor: KColors.primary,
            onPressed: () async {
              await cartProvider.increment(foodId);
              // await cartProvider.addToCart(context, foodId);
              // foodsProvider.increment(foodId);
            },
          ),
        ],
      );
    });
    // }
    // );
  }
}
