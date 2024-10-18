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

// }
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:chulesi/common/widgets/products/products_text/product_price_text.dart';
// import 'package:chulesi/common/widgets/products/products_text/product_title_text.dart';
// import 'package:chulesi/core/utils/constants/colors.dart';
// import 'package:chulesi/core/utils/constants/sizes.dart';
// import 'package:chulesi/data/models/order_model.dart';

// class OrderDetail extends StatelessWidget {
//   const OrderDetail({super.key, required this.order});
//   final OrderModel order;

//   @override
//   Widget build(BuildContext context) {
//     List<OrderItem> orderItems = order.orderItems;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Order Details"),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(
//                 vertical: KSizes.md, horizontal: KSizes.md),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("Delivered to:"),
//                 Text(order.deliveryAddress.location),
//                 Text("Payment Method"),
//                 Text(order.paymentMethod),
//                 Text("Order Status"),
//                 Text(order.orderStatus),
//               ],
//             ),
//           ),
//           Divider(
//             color: KColors.grey,
//           ),
//           SizedBox(height: KSizes.spaceBtwItems),
//           Flexible(
//             child: LayoutBuilder(
//               builder: (context, constraints) {
//                 return ListView.builder(
//                   padding: EdgeInsets.zero, // Remove default padding
//                   itemCount: orderItems.length,
//                   itemBuilder: (context, index) {
//                     OrderItem orderItem = orderItems[index];
//                     return Container(
//                       padding: EdgeInsets.symmetric(
//                           horizontal: KSizes.md, vertical: KSizes.sm),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               ProductTitleText(
//                                 title: orderItem.title,
//                                 smallSize: true,
//                               ),
//                               ProductPriceText(
//                                 price: "${orderItem.price}",
//                                 color: KColors.black,
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: KSizes.xs),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "Qty: ${orderItem.quantity}",
//                                 style: Theme.of(context).textTheme.bodySmall,
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: KSizes.sm),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Divider(
//             color: KColors.grey,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(
//                 vertical: KSizes.md, horizontal: KSizes.md),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Text("Delivered to:"),
//                     Text(order.deliveryAddress.location),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Text("Delivered to:"),
//                     Text(order.deliveryAddress.location),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Text("Delivered to:"),
//                     Text(order.deliveryAddress.location),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Text("Delivered to:"),
//                     Text(order.deliveryAddress.location),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//  Container(
//               padding: const EdgeInsets.all(16.0),
//               // height: 120.0, // Adjust height as needed
//               child: LayoutBuilder(
//                 builder: (context, constraints) {
//                   return SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: ConstrainedBox(
//                       constraints: BoxConstraints(
//                         maxWidth: constraints.maxWidth,
//                       ),
//                       child: Stepper(
//                         type: StepperType
//                             .vertical, // Set Stepper type to horizontal
//                         currentStep: _getCurrentStep(order.orderStatus),
//                         controlsBuilder: (context, details) =>
//                             SizedBox.shrink(),
//                         steps: _buildSteps(order.orderStatus),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//   int _getCurrentStep(String status) {
//     switch (status) {
//       case "Placed":
//         return 0;
//       case "Preparing":
//         return 1;
//       case "Out for Delivery":
//         return 2;
//       case "Delivered":
//         return 3;
//       case "Completed":
//         return 4;
//       case "Cancelled":
//         return 5;
//       default:
//         return 0;
//     }
//   }

//   List<Step> _buildSteps(String status) {
//     List<Map<String, String>> stepsData = [
//       {'title': 'Placed', 'status': 'Placed'},
//       {'title': 'Preparing', 'status': 'Preparing'},
//       {'title': 'Out for Delivery', 'status': 'Out for Delivery'},
//       {'title': 'Delivered', 'status': 'Delivered'},
//       {'title': 'Cancelled', 'status': 'Cancelled'},
//     ];

//     return stepsData.map((stepData) {
//       return Step(
//         title: Text(
//           stepData['title']!,
//           style: TextStyle(
//             color:
//                 status == stepData['status'] ? KColors.primary : Colors.black,
//           ),
//         ),
//         content: SizedBox(), // Empty content to remove it from the step
//         isActive: status == stepData['status'], // Highlight the current step
//         state: status == stepData['status']
//             ? StepState.complete
//             : StepState.indexed, // Highlight the current step
//       );
//     }).toList();
//   }
}
