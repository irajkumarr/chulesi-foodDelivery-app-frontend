import 'package:flutter/material.dart';
import 'package:chulesi/common/widgets/products/products_text/product_price_text.dart';
import 'package:chulesi/common/widgets/products/products_text/product_title_text.dart';
import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';

import 'package:chulesi/data/models/order_model.dart';

class OrderDetail extends StatelessWidget {
  const OrderDetail({super.key, required this.order});
  // final List<OrderItem> orderItems;
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    List<OrderItem> orderItems = order.orderItems;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
      ),
      body: ListView.builder(
        itemCount: orderItems.length,
        itemBuilder: (context, index) {
          OrderItem order = orderItems[index];
          return Container(
            margin: EdgeInsets.only(top: KSizes.sm, bottom: KSizes.sm),
            color: KColors.white,
            padding: const EdgeInsets.symmetric(
                horizontal: KSizes.md, vertical: KSizes.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ProductTitleText(
                      title: order.title,
                      smallSize: true,
                    ),
                    ProductPriceText(
                      price: "${order.price}",
                      color: KColors.black,
                    ),
                  ],
                ),
                SizedBox(height: KSizes.xs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Qty: ${order.quantity}",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
