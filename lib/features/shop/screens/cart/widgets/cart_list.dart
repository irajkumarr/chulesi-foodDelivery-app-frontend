// import 'package:flutter/material.dart';
// import 'package:frontend/core/utils/constants/sizes.dart';
// import 'package:frontend/core/utils/device/device_utility.dart';
// import 'package:frontend/core/utils/shimmers/foodlist_shimmer.dart';
// import 'package:frontend/data/hooks/fetch_cart.dart';
// import 'package:frontend/data/models/cart_response.dart';
// import 'package:frontend/features/shop/screens/cart/widgets/cart_tile.dart';

// class CartList extends StatelessWidget {
//   const CartList({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
 
//     return Container(
//       padding: const EdgeInsets.all(KSizes.md),
//       margin: EdgeInsets.only(bottom: KSizes.spaceBtwItems),
//       child: isLoading
//           ? FoodsListShimmer()
//           : (cartList == null || cartList.isEmpty)
//               ? Center(
//                   child: Text(
//                   "Your Cart is Empty",
//                   style: Theme.of(context)
//                       .textTheme
//                       .titleMedium!
//                       .copyWith(fontWeight: FontWeight.w600),
//                 ))
//               : SizedBox(
//                   width: KDeviceUtils.getScreenWidth(context),
//                   height: KDeviceUtils.getScreenHeight(context),
//                   child: ListView.builder(
//                       itemCount: cartList.length,
//                       itemBuilder: (context, index) {
//                         CartResponse cart = cartList[index];
//                         return CartTile(
//                           cart: cart,
//                           refetch: refetch,
//                         );
//                       }),
//                 ),
//     );
//   }
// }
