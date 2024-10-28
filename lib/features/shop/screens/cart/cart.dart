import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chulesi/core/network/connectivity_checker.dart';
import 'package:chulesi/core/utils/circular_progress_indicator/circlular_indicator.dart';
import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/core/utils/device/device_utility.dart';
import 'package:chulesi/data/hooks/fetch_cart.dart';
import 'package:chulesi/data/models/cart_response.dart';
import 'package:chulesi/data/models/login_response.dart';
import 'package:chulesi/data/models/order_request.dart';
import 'package:chulesi/features/authentication/providers/login_provider.dart';
import 'package:chulesi/features/authentication/screens/login/widgets/login_redirect.dart';
import 'package:chulesi/features/shop/providers/cart_provider.dart';
import 'package:chulesi/features/shop/screens/cart/widgets/cart_tile.dart';
import 'package:chulesi/features/shop/screens/checkout/checkout.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulHookWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchTotalPrice();
    });
  }

  void _fetchTotalPrice() {
    final box = GetStorage();
    String userId = box.read("userId") ?? '';

    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.fetchTotalCartPrice(userId);
  }

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final hookResult = useFetchCart();
    List<CartResponse>? cartList = hookResult.data;
    final isLoading = hookResult.isLoading;

    final List<String> emptyCartMessages = [
      "Your cart is looking lonely! Start adding some items.",
      "Oops, nothing here! Explore and add some delicious treats.",
      "Your cart is empty, but your appetite doesn’t have to be!",
      "Hungry? Your cart is waiting for you to add something.",
      "Add items to your cart and let the feast begin!"
    ];
// Randomly select a message from the list
    final randomCartMessage =
        emptyCartMessages[Random().nextInt(emptyCartMessages.length)];
    final refetch = hookResult.refetch;
    LoginResponse? user;

    final loginProvider = Provider.of<LoginProvider>(context);

    String? token = box.read("token");
    if (token != null) {
      user = loginProvider.getUserInfo();
    }

    if (token == null) {
      return ConnectivityChecker(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60.0),
            child: Material(
              elevation: 1.0,
              child: AppBar(
                title: const Text("Your Shopping Cart"),
              ),
            ),
          ),
          body: const LoginRedirect(),
        ),
      );
    }

    return ConnectivityChecker(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60.0),
            child: Material(
              elevation: 1.0,
              child: AppBar(
                title: const Text("Your Shopping Cart"),
              ),
            ),
          ),
          bottomNavigationBar: (cartList == null || cartList.isEmpty)
              ? const SizedBox()
              : PreferredSize(
                  preferredSize: Size.fromHeight(75.h),
                  child: Material(
                    elevation: 4,
                    child: BottomAppBar(
                      // height: 75.h,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: KSizes.defaultSpace),
                        child: ElevatedButton(
                          onPressed: () {
                            if (cartList.isNotEmpty) {
                              // Prepare the order items
                              List<OrderItem> orderItems =
                                  cartList.map((cartItem) {
                                return OrderItem(
                                  foodId: cartItem.productId.id,
                                  title: cartItem.productId.title,
                                  quantity: cartItem.quantity,
                                  price: cartItem.totalPrice.toInt(),
                                  instructions:
                                      '', // or any special instructions
                                );
                              }).toList();

                              // Pass to CheckoutScreen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CheckoutScreen(item: orderItems),
                                ),
                              );
                            }
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             CheckoutScreen(item: )));
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    KSizes.borderRadiusLg)),
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(
                                double.infinity, 80), // Full width button
                          ),
                          child: (cartList.isEmpty)
                              ? Center(
                                  child: Text(
                                    "Your Cart is Empty",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                )
                              : Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: KSizes.defaultSpace),
                                  child: Consumer<CartProvider>(
                                      builder: (context, cartProvider, child) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${cartProvider.cartCount} items",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .copyWith(
                                                      color: KColors.white),
                                            ),
                                            Text(
                                              // "Rs 600",
                                              "Rs ${cartProvider.totalPrice.toStringAsFixed(0)}",

                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                      color: KColors.white),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "CONTINUE",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                      color: KColors.white),
                                            ),
                                            SizedBox(width: KSizes.xs),
                                            const Icon(
                                              Icons.arrow_forward_ios,
                                              size: KSizes.md - 2,
                                            ),
                                          ],
                                        )
                                      ],
                                    );
                                  }),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
          body: RefreshIndicator(
            onRefresh: () async {
              return await refetch();
            },
            child: Column(
              children: [
                (cartList == null || cartList.isEmpty)
                    ? const SizedBox()
                    : Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: KSizes.md),
                        margin: EdgeInsets.only(top: KSizes.spaceBtwItems),
                        decoration: const BoxDecoration(
                          color: KColors.grey,
                        ),
                        child: Consumer<CartProvider>(
                            builder: (context, cartProvider, child) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Items (${cartProvider.cartCount})"),
                              TextButton(
                                  onPressed: () async {
                                    await cartProvider.clearCart(
                                        user!.id, refetch);
                                  },
                                  child: Text(
                                    "Clear All",
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  )),
                            ],
                          );
                        }),
                      ),
                Container(
                  padding: const EdgeInsets.only(
                    top: KSizes.md,
                    left: KSizes.md,
                    right: KSizes.md,
                  ),
                  width: KDeviceUtils.getScreenWidth(context),
                  height: KDeviceUtils.getScreenHeight(context) * 0.71,
                  child: isLoading
                      // ? const FoodsListShimmer()
                      ? KIndicator.circularIndicator()
                      : (cartList == null || cartList.isEmpty)
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.shopping_bag_outlined,
                                    size: 80,
                                    color: KColors.primary,
                                  ),
                                  SizedBox(height: KSizes.spaceBtwItems),
                                  Text(
                                    "Your cart is empty!",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22),
                                  ),
                                  SizedBox(height: KSizes.spaceBtwSections),
                                  Text(
                                    randomCartMessage,
                                    // "Looks like you haven't added anything yet.\nStart exploring our wide selection of products.",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: KColors.darkGrey,
                                        ),
                                  ),
                                  SizedBox(height: KSizes.spaceBtwSections),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: KSizes.md),
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamedAndRemoveUntil(context,
                                          "/navigationMenu", (route) => false);
                                    },
                                    child: const Text("Start Shopping"),
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemCount: cartList.length,
                              itemBuilder: (context, index) {
                                CartResponse cart = cartList[index];

                                return CartTile(
                                  cart: cart,
                                  refetch: refetch,
                                );
                              }),
                )
              ],
            ),
          )),
    );
  }
}
