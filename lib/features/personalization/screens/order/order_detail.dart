// import 'package:flutter/material.dart';
// import 'package:chulesi/common/widgets/products/products_text/product_price_text.dart';
// import 'package:chulesi/common/widgets/products/products_text/product_title_text.dart';
// import 'package:chulesi/core/utils/constants/colors.dart';
// import 'package:chulesi/core/utils/constants/sizes.dart';

// import 'package:chulesi/data/models/order_model.dart';

// class OrderDetail extends StatelessWidget {
//   const OrderDetail({super.key, required this.order});
//   // final List<OrderItem> orderItems;
//   final OrderModel order;

//   @override
//   Widget build(BuildContext context) {
//     List<OrderItem> orderItems = order.orderItems;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Order Details"),
//       ),
//       body: ListView.builder(
//         itemCount: orderItems.length,
//         itemBuilder: (context, index) {
//           OrderItem order = orderItems[index];
//           return Container(
//             margin: EdgeInsets.only(top: KSizes.sm, bottom: KSizes.sm),
//             color: KColors.white,
//             padding: const EdgeInsets.symmetric(
//                 horizontal: KSizes.md, vertical: KSizes.md),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     ProductTitleText(
//                       title: order.title,
//                       smallSize: true,
//                     ),
//                     ProductPriceText(
//                       price: "${order.price}",
//                       color: KColors.black,
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: KSizes.xs),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "Qty: ${order.quantity}",
//                       style: Theme.of(context).textTheme.bodySmall,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:chulesi/common/widgets/products/products_text/product_price_text.dart';
import 'package:chulesi/common/widgets/products/products_text/product_title_text.dart';
import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/data/models/order_model.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/device/device_utility.dart';

class OrderDetail extends StatelessWidget {
  const OrderDetail({super.key, required this.order});
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    List<OrderItem> orderItems = order.orderItems;
    DateTime parsedDate = DateTime.parse(order.orderDate.toString()).toLocal();
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(parsedDate);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight()),
        child: Material(
          elevation: 1,
          child: AppBar(
            title: const Text("Order Details"),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(KSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Status Stepper
              _buildOrderStatusStepper(context),

              const SizedBox(height: KSizes.md),

              // Order Summary Card
              Card(
                elevation: 1,
                color: KColors.white,
                child: Padding(
                  padding: const EdgeInsets.all(KSizes.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order Summary',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: KSizes.sm),
                      _buildOrderInfoRow('Order ID', order.id),
                      _buildOrderInfoRow('Order Date', formattedDate),
                      _buildOrderInfoRow(
                          'Total Items', orderItems.length.toString()),
                      _buildOrderInfoRow(
                          'Delivery fee',
                          (order.deliveryFee == 0)
                              ? "Free Delivery"
                              : order.deliveryFee.toStringAsFixed(0)),
                      _buildOrderInfoRow('Discount Amount',
                          order.discountAmount.toStringAsFixed(0)),
                      _buildOrderInfoRow('Total Amount',
                          "Rs. ${order.grandTotal.toStringAsFixed(0)}"),
                      _buildOrderInfoRow('Status', order.orderStatus),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: KSizes.md),

              // Order Items Section
              Text(
                'Order Items',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: KSizes.sm),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: orderItems.length,
                itemBuilder: (context, index) {
                  OrderItem orderItem = orderItems[index];
                  return _buildOrderItemCard(context, orderItem);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Order Status Stepper
  Widget _buildOrderStatusStepper(BuildContext context) {
    // Define base order status steps
    final List<String> orderSteps = [
      "Placed",
      "Preparing",
      "Out for Delivery",
      "Delivered",
    ];

    // Check if the order is cancelled
    bool isCancelled = order.orderStatus.toLowerCase() == 'cancelled';

    // Add "Cancelled" step only if the order is cancelled
    if (isCancelled) {
      orderSteps.add("Cancelled");
    }

    // Determine the current step index
    int currentStep = _getCurrentStepIndex(order.orderStatus, orderSteps);

    return Card(
      elevation: 1,
      color: KColors.white,
      child: Padding(
        padding: const EdgeInsets.all(KSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Tracking',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: KSizes.sm),
            Stepper(
              physics: NeverScrollableScrollPhysics(),
              currentStep: currentStep,
              controlsBuilder: (context, details) => Container(),
              steps: orderSteps.map((status) {
                final bool isCurrentStep =
                    orderSteps.indexOf(status) == currentStep;
                final bool isCompletedStep =
                    orderSteps.indexOf(status) < currentStep;

                return Step(
                  title: Text(
                    status,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isCancelled && status == 'Cancelled'
                          ? Colors.red // Highlight "Cancelled" in red
                          : (isCompletedStep || isCurrentStep
                              ? KColors.primary
                              : Colors.grey),
                      decoration: isCancelled && isCompletedStep
                          ? TextDecoration
                              .lineThrough // Add strikethrough for cancelled steps
                          : null,
                    ),
                  ),
                  state: isCancelled
                      ? (status == 'Cancelled'
                          ? StepState
                              .error // Show error state for cancelled step
                          : StepState
                              .disabled) // Disable other steps for cancelled orders
                      : (isCompletedStep
                          ? StepState.complete
                          : (isCurrentStep
                              ? StepState.complete
                              : StepState.disabled)),
                  content: Container(),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

// Helper method to get current step index
  int _getCurrentStepIndex(String currentStatus, List<String> orderSteps) {
    switch (currentStatus.toLowerCase()) {
      case 'placed':
        return 0;
      case 'preparing':
        return 1;
      case 'out for delivery':
        return 2;
      case 'delivered':
        return 3;
      case 'cancelled':
        return orderSteps
            .indexOf("Cancelled"); // Dynamically handle "Cancelled"
      default:
        return 0; // Default to "Placed" if status is unknown
    }
  }

//   Widget _buildOrderStatusStepper(BuildContext context) {
//     // Define all possible order status steps
//     final List<String> orderSteps = [
//       "Placed",
//       "Preparing",
//       "Out for Delivery",
//       "Delivered",
//       // "Completed",
//       "Cancelled",
//     ];
// // Exclude "Cancelled" if the order is delivered
//     if (order.orderStatus.toLowerCase() == 'delivered') {
//       orderSteps.remove("Cancelled");
//     }
//     // Determine current step based on order status
//     int currentStep = _getCurrentStepIndex(order.orderStatus, orderSteps);

//     // Check if the order is cancelled
//     bool isCancelled = order.orderStatus.toLowerCase() == 'cancelled';

//     return Card(
//       elevation: 1,
//       color: KColors.white,
//       child: Padding(
//         padding: const EdgeInsets.all(KSizes.md),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Order Tracking',
//               style: Theme.of(context).textTheme.titleMedium,
//             ),
//             SizedBox(height: KSizes.sm),
//             Stepper(
//               physics: NeverScrollableScrollPhysics(),
//               currentStep: currentStep,
//               controlsBuilder: (context, details) => Container(),
//               steps: orderSteps.map((status) {
//                 return Step(
//                   title: Text(
//                     status,
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       color: isCancelled && status == 'Cancelled'
//                           ? Colors.red // Highlight cancelled status in red
//                           : (orderSteps.indexOf(status) <= currentStep
//                               ? KColors.primary
//                               : Colors.grey),
//                       // Add strikethrough for cancelled steps
//                       decoration: isCancelled &&
//                               orderSteps.indexOf(status) < currentStep
//                           ? TextDecoration.lineThrough
//                           : null,
//                     ),
//                   ),
//                   state: isCancelled
//                       ? (status == 'Cancelled'
//                           ? StepState.error // Show error state for cancelled
//                           : StepState.disabled) // Disable other steps
//                       : (orderSteps.indexOf(status) < currentStep
//                           ? StepState.complete
//                           : (orderSteps.indexOf(status) == currentStep
//                               ? StepState.complete
//                               : StepState.disabled)),
//                   content: Container(),
//                 );
//               }).toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Helper method to get current step index
//   int _getCurrentStepIndex(String currentStatus, List<String> orderSteps) {
//     switch (currentStatus.toLowerCase()) {
//       case 'placed':
//         return 0;
//       case 'preparing':
//         return 1;
//       case 'out for delivery':
//         return 2;
//       case 'delivered':
//         return 3;
//       // case 'completed':
//       //   return 4;
//       case 'cancelled':
//         return 4;
//       default:
//         return 0;
//     }
//   }

  // Helper method to build order information rows
  Widget _buildOrderInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: KSizes.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build individual order item cards
  Widget _buildOrderItemCard(BuildContext context, OrderItem order) {
    return Card(
      margin: EdgeInsets.only(bottom: KSizes.sm),
      color: KColors.white,
      child: Padding(
        padding: const EdgeInsets.all(KSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ProductTitleText(
                    title: order.title,
                    smallSize: true,
                  ),
                ),
                ProductPriceText(
                  price: (order.price / order.quantity).toStringAsFixed(0),
                  color: KColors.black,
                ),
              ],
            ),
            SizedBox(height: KSizes.xs),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Quantity: ${order.quantity}",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  "Subtotal: ${order.price.toString()}",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
