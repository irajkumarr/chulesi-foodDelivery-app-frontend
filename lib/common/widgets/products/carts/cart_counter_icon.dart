import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/sizes.dart';
import '../../../../features/shop/providers/cart_provider.dart';

class CartCounterIcon extends StatefulWidget {
  const CartCounterIcon({
    super.key,
    // required this.onPressed,
    this.iconColor = KColors.white,
  });
  // final VoidCallback onPressed;
  final Color? iconColor;

  @override
  State<CartCounterIcon> createState() => _CartCounterIconState();
}

class _CartCounterIconState extends State<CartCounterIcon> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchCartCount();
    });
  }

  void _fetchCartCount() {
    final box = GetStorage();
    String userId = box.read("userId") ?? '';
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.fetchCartCount(userId);
  }

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    String? token = box.read("token");
    return Padding(
      padding: EdgeInsets.only(right: KSizes.sm),
      child: Stack(
        children: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/cart");
              },
              icon: Icon(
                MaterialCommunityIcons.cart,
                color: widget.iconColor,
              )),
          token == null
              ? const SizedBox()
              : Consumer<CartProvider>(builder: (context, cartProvider, child) {
                  return cartProvider.cartCount > 0
                      ? Positioned(
                          right: 5,
                          top: 5,
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              color: KColors.primary,
                              border: Border.all(color: KColors.white),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Center(
                              child: Text(
                                // cartProvider.cartCount == 0
                                //     ? "0"
                                //     :
                                cartProvider.cartCount.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                      color: KColors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox();
                })
        ],
      ),
    );
  }
}
