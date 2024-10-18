import 'package:flutter/material.dart';

import 'package:chulesi/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/data/models/order_model.dart';
import 'package:chulesi/features/personalization/screens/order/order_detail.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class OrderList extends StatelessWidget {
  const OrderList({super.key, required this.order});
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    DateTime parsedDate = DateTime.parse(order.orderDate.toString());

    String formattedDate = DateFormat('yyyy-MM-dd HH:mm ').format(parsedDate);
    return RoundedContainer(
        width: double.infinity,
        showBorder: true,
        // color: KColors.light,
        color: KColors.white,
        padding: const EdgeInsets.all(KSizes.md),
        borderColor: KColors.grey,
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //processing
                Row(
                  children: [
                    const Icon(Iconsax.ship),
                    SizedBox(width: KSizes.spaceBtwItems / 2),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order.paymentStatus,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .apply(color: KColors.primary),
                          ),
                          Text(
                            // formattedDate,
                            order.deliveryAddress.location,
                            style: Theme.of(context).textTheme.headlineSmall,
                          )
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      OrderDetail(order: order)));
                        },
                        icon: Icon(
                          Iconsax.arrow_right_34,
                          size: KSizes.iconSm,
                        ))
                  ],
                ),
                SizedBox(height: KSizes.spaceBtwItems),
                //order
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(Iconsax.tag),
                          SizedBox(width: KSizes.spaceBtwItems / 2),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Payment Status",
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                              Text(
                                order.paymentStatus,
                                style: Theme.of(context).textTheme.titleMedium,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    //delivery address
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(Iconsax.calendar),
                          SizedBox(width: KSizes.spaceBtwItems / 2),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Order Date",
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                              Text(
                                formattedDate,
                                style: Theme.of(context).textTheme.titleMedium,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: KSizes.spaceBtwItems),
                //order
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(Iconsax.save_2),
                          SizedBox(width: KSizes.spaceBtwItems / 2),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Order Total",
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                              Text(
                                order.orderTotal.toStringAsFixed(0),
                                style: Theme.of(context).textTheme.titleMedium,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    //delivery address
                    Expanded(
                      child: Row(
                        children: [
                          // const Icon(Iconsax.calendar),
                          SizedBox(width: KSizes.xs),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Discount Amount",
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                              Text(
                                order.discountAmount.toStringAsFixed(0),
                                style: Theme.of(context).textTheme.titleMedium,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          // const Icon(Iconsax.calendar),
                          SizedBox(width: KSizes.xs),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Grand Total",
                                style: Theme.of(context).textTheme.labelMedium,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Text(
                                order.grandTotal.toStringAsFixed(0),
                                style: Theme.of(context).textTheme.titleMedium,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // !order.orderStatus == "Delivered"
            //     ?
            // Positioned(
            //     right: 0,
            //     bottom: 0,
            //     child: IconButton(onPressed: () {}, icon: Icon(Icons.star)))
            // : SizedBox()
          ],
        ));
  }
}
