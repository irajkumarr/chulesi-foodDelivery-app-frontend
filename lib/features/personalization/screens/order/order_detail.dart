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

import 'package:chulesi/features/personalization/providers/rating_provider.dart';
import 'package:flutter/material.dart';
import 'package:chulesi/common/widgets/products/products_text/product_price_text.dart';
import 'package:chulesi/common/widgets/products/products_text/product_title_text.dart';
import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/data/models/order_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/device/device_utility.dart';

class OrderDetail extends StatefulWidget {
  final OrderModel order;
  OrderDetail({super.key, required this.order});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  final TextEditingController _feedbackController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ratingProvider =
          Provider.of<RatingProvider>(context, listen: false);
      ratingProvider.initializeRating(widget.order);
      _feedbackController.text = widget.order.feedback ?? '';
    });
  }

  @override
  void dispose() {
    _feedbackController.dispose(); // Clean up the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<OrderItem> orderItems = widget.order.orderItems;
    DateTime parsedDate =
        DateTime.parse(widget.order.orderDate.toString()).toLocal();
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
                      _buildOrderInfoRow('Order ID', widget.order.id),
                      _buildOrderInfoRow('Order Date', formattedDate),
                      _buildOrderInfoRow(
                          'Total Items', orderItems.length.toString()),
                      _buildOrderInfoRow(
                          'Delivery fee',
                          (widget.order.deliveryFee == 0)
                              ? "Free Delivery"
                              : "Rs. ${widget.order.deliveryFee.toStringAsFixed(0)}"),
                      _buildOrderInfoRow('Discount Amount',
                          "Rs. ${widget.order.discountAmount.toStringAsFixed(0)}"),
                      _buildOrderInfoRow('Total Amount',
                          "Rs. ${widget.order.grandTotal.toStringAsFixed(0)}"),
                      _buildOrderInfoRow('Status', widget.order.orderStatus),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: KSizes.md),
// Order Rating Section
              _buildRatingSection(context),

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
    bool isCancelled = widget.order.orderStatus.toLowerCase() == 'cancelled';

    // Add "Cancelled" step only if the order is cancelled
    if (isCancelled) {
      orderSteps.add("Cancelled");
    }

    // Determine the current step index
    int currentStep =
        _getCurrentStepIndex(widget.order.orderStatus, orderSteps);

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

  Widget _buildRatingSection(BuildContext context) {
    // Only show rating section for delivered orders
    if (widget.order.orderStatus.toLowerCase() != 'delivered') {
      return SizedBox.shrink();
    }

    return Card(
      elevation: 1,
      color: KColors.white,
      child: Padding(
        padding: const EdgeInsets.all(KSizes.md),
        child: Consumer<RatingProvider>(
          builder: (context, ratingProvider, child) {
            // Initialize feedback controller if needed
            if (_feedbackController.text.isEmpty) {
              _feedbackController.text = ratingProvider.feedback;
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rate Your Order',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: KSizes.sm),

                // Conditional Rating Display
                ratingProvider.isRatingSubmitted
                    ? _buildSubmittedRatingView(context, ratingProvider)
                    : _buildRatingInputView(context, ratingProvider),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSubmittedRatingView(
      BuildContext context, RatingProvider ratingProvider) {
    return Column(
      children: [
        RatingBar.builder(
          initialRating: ratingProvider.currentRating,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 30,
          ignoreGestures: true,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {},
        ),
        SizedBox(height: KSizes.sm),
        Text(
          'Your feedback has been received. Thank you!',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        if (ratingProvider.feedback.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: KSizes.sm),
            child: Text(
              'Your Feedback: ${ratingProvider.feedback}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
      ],
    );
  }

  Widget _buildRatingInputView(
      BuildContext context, RatingProvider ratingProvider) {
    return Column(
      children: [
        RatingBar.builder(
          initialRating: 0,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 40,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            ratingProvider.updateRating(rating);
          },
        ),
        SizedBox(height: KSizes.sm),
        TextField(
          controller: _feedbackController,
          decoration: InputDecoration(
            labelText: 'Share your feedback (optional)',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
          onChanged: (value) {
            ratingProvider.updateFeedback(value);
          },
        ),
        SizedBox(height: KSizes.sm),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(KSizes.md),
            backgroundColor: KColors.primary,
          ),
          onPressed:
              ratingProvider.currentRating > 0 && !ratingProvider.isLoading
                  ? () async {
                      // final success =
                      //     await ratingProvider.submitRating(widget.order.id);
                      // if (success) {
                      //   // setState(() {});
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(content: Text('Rating submitted successfully!')),
                      //   );
                      // }
                      await ratingProvider.submitRating(widget.order.id);
                    }
                  : null,
          child: ratingProvider.isLoading
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Submit Rating"),
                    const SizedBox(width: KSizes.md),
                    SizedBox(
                      height: 12.h,
                      width: 12.w,
                      child: const CircularProgressIndicator(
                        color: KColors.primary,
                        strokeWidth: 1,
                      ),
                    ),
                  ],
                )
              : const Text("Submit Rating"),
        ),
      ],
    );
  }
}
