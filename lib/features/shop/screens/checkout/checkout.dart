import 'dart:convert';
// import 'dart:math';
import 'package:chulesi/core/utils/circular_progress_indicator/circlular_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chulesi/core/network/connectivity_checker.dart';
import 'package:chulesi/core/utils/constants/api_constants.dart';
import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/core/utils/constants/image_strings.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/core/utils/popups/loaders.dart';
import 'package:chulesi/core/utils/popups/toast.dart';
import 'package:chulesi/core/utils/shimmers/shimmer_widget.dart';
import 'package:chulesi/data/hooks/fetch_default_address.dart';
import 'package:chulesi/data/models/order_request.dart';
import 'package:chulesi/features/personalization/providers/order_provider.dart';
import 'package:chulesi/features/personalization/screens/address/add_new_address.dart';
import 'package:chulesi/features/shop/providers/cart_provider.dart';
import 'package:chulesi/features/shop/screens/checkout/widgets/checkout_address_tile.dart';
import 'package:chulesi/features/shop/screens/checkout/widgets/order_note_bottom_sheet.dart';
import 'package:chulesi/features/shop/screens/checkout/widgets/payment_method_bottom_sheet.dart';
import 'package:chulesi/features/shop/screens/checkout/widgets/promo_code_bottom_sheet.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

Future<double> getDrivingDistance(
    double lat1, double lon1, double lat2, double lon2, String apiKey) async {
  final response = await http.get(
    Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json?origin=$lat1,$lon1&destination=$lat2,$lon2&key=$apiKey'),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    // print(data);
    final distanceInMeters = data['routes'][0]['legs'][0]['distance']['value'];
    return distanceInMeters / 1000; // Convert to kilometers
  } else {
    throw Exception('Failed to load directions');
  }
}

class CheckoutScreen extends HookWidget {
  const CheckoutScreen({required this.item, super.key});
  final List<OrderItem>? item;

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    final box = GetStorage();
    final userId = box.read("userId");
    final deliveryAddress = box.read("defaultAddressId");
    final hookResult = useFetchDefaultAddress();
    final address = hookResult.data;
    final isLoading = hookResult.isLoading; // Is the address being loaded
    final refetch = hookResult.refetch;

    final cartProvider = Provider.of<CartProvider>(context);
    final double itemsTotal = cartProvider.totalPrice;
    final promoCodeController = useTextEditingController();
    final discount = useState<double>(0);
    final appliedPromoCode = useState<String>("");

    // State for delivery charge and loading state
    final deliveryCharge = useState<double>(0.0);
    final isDeliveryChargeLoading =
        useState<bool>(true); // State for loading delivery charge

    // Asynchronous function to fetch the delivery charge
    Future<void> fetchDeliveryCharge() async {
      if (itemsTotal >= 2499) {
        deliveryCharge.value = 0.0;
        isDeliveryChargeLoading.value = false;
      } else if (deliveryAddress == null) {
        deliveryCharge.value = 75.0;
        isDeliveryChargeLoading.value = false;
      } else if (address != null &&
          address.latitude != null &&
          address.longitude != null) {
        const double defaultLat =
            27.430986970568913; // Center location latitude
        const double defaultLon =
            85.03193736075626; // Center location longitude

        try {
          // Fetch the driving distance using Google Maps API
          double distance = await getDrivingDistance(
            address.latitude!,
            address.longitude!,
            defaultLat,
            defaultLon,
            kGoogleMapAPIKey,
          );

          // Set delivery charge based on distance with a minimum of Rs 75
          double calculatedCharge = distance * 20;
          deliveryCharge.value =
              calculatedCharge < 75 ? 75.0 : calculatedCharge;
        } catch (error) {
          // Default delivery charge if error occurs
          deliveryCharge.value = 75.0;
        } finally {
          isDeliveryChargeLoading.value =
              false; // Set loading to false when done
        }
      }
    }

    // Call fetchDeliveryCharge when the screen is first built
    useEffect(() {
      fetchDeliveryCharge();
      return null;
    }, [address]);

    final double grandTotal = itemsTotal + deliveryCharge.value;

    final selectedPaymentMethod = useState<String>("Cash On Delivery");
    final selectedPaymentMethodImage = useState<String>(KImages.paymentMethod);
    final orderNoteController = useTextEditingController();

    void applyPromoCode({bool isOrder = false}) async {
      final box = GetStorage();
      String? token = box.read("token");
      String userId = box.read("userId");
      final promoCode = promoCodeController.text.trim();

      try {
        final response = await http.post(
          Uri.parse('$kAppBaseUrl/api/promoCodes/apply-promo'),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
          body: jsonEncode({
            "code": promoCode,
            "totalAmount": itemsTotal,
            "userId": userId,
            "isOrder": isOrder,
          }),
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          discount.value = data['discountAmount']?.toDouble() ?? 0.0;
          appliedPromoCode.value = promoCode;

          // Only show the toast if it's not an order
          if (!isOrder) {
            showToast(data['message']);
          }
        } else {
          final data = jsonDecode(response.body);
          // Only show the SnackBar if it's not an order
          if (!isOrder) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  backgroundColor: KColors.black,
                  content: Text(data['message'])),
            );
          }
          discount.value = 0;
          appliedPromoCode.value = "";
        }
      } catch (e) {
        // debugPrint(e.toString());
        if (!isOrder) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: KColors.black,
              content: Text("An error occurred while applying the promo code."),
            ),
          );
        }
        discount.value = 0;
        appliedPromoCode.value = "";
      }
    }

    Future<void> placeOrder() async {
      if (itemsTotal <= 249) {
        KLoaders.showSnackbarTop(
            context,
            "The total amount should be at least Rs 250 to place an order.",
            "Continue Shopping", () {
          Navigator.pushNamedAndRemoveUntil(
              context, "/navigationMenu", (route) => false);
        });
        return; // Exit the method to prevent placing the order
      }
      if (deliveryAddress == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: KColors.black,
              content: Text("Please select a delivery address.")),
        );
        return;
      }

      // Show confirmation dialog
      final shouldProceed = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SizedBox(
            width: 400.w,
            child: AlertDialog(
              backgroundColor: KColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(KSizes.xs),
              ),
              title: const Text("Confirm Order"),
              content: const Text(
                  "Are you sure you want to place this order? Once placed then you cannot cancelled it."),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text(
                    "CANCEL",
                    style: TextStyle(color: KColors.darkGrey),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text(
                    "CONFIRM",
                    style: TextStyle(color: KColors.primary),
                  ),
                ),
              ],
            ),
          );
        },
      );

      // If the user confirms the order
      if (shouldProceed == true) {
        applyPromoCode(isOrder: true);
        OrderRequest model = OrderRequest(
          userId: userId!,
          orderItems: item!,
          orderTotal: itemsTotal,
          deliveryFee: deliveryCharge.value,
          // deliveryFee: deliveryCharge,
          grandTotal: grandTotal,
          deliveryAddress: deliveryAddress,
          paymentMethod: selectedPaymentMethod.value,
          paymentStatus: "Pending",
          orderStatus: "Placed",
          orderDate: DateTime.now(),
          rating: 1,
          feedback: "",
          orderNote: orderNoteController.text,
          // discountAmount: 0,
          discountAmount: discount.value,
          promoCode: appliedPromoCode.value.toString(),
        );

        String data = orderRequestToJson(model);
        bool success = await orderProvider.addOrder(context, data);

        if (success) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            "/successScreen",
            (route) => route.isFirst,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("Failed to place order. Please try again.")),
          );
        }
      }
    }

    return ConnectivityChecker(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Material(
            elevation: 1.0,
            child: AppBar(
              title: const Text("Checkout"),
            ),
          ),
        ),
        bottomNavigationBar: isLoading || isDeliveryChargeLoading.value
            ? SizedBox()
            : PreferredSize(
                preferredSize: Size.fromHeight(75.h),
                child: Material(
                  elevation: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Free Delivery Progress Container
                      Container(
                        padding: const EdgeInsets.all(KSizes.md),
                        color: KColors.white,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Icon(
                                        itemsTotal >= 2500
                                            ? Icons.check_circle
                                            : Icons.local_shipping,
                                        color: itemsTotal >= 2500
                                            ? KColors.success
                                            : KColors.primary,
                                      ),
                                      SizedBox(width: KSizes.sm),
                                      Flexible(
                                        child: itemsTotal >= 2500
                                            ? Text(
                                                "Free Delivery Applied!",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                      color: KColors.success,
                                                    ),
                                              )
                                            // : Text(
                                            //     "Add Rs ${(2500 - itemsTotal).toStringAsFixed(0)} more for Free Delivery",
                                            //     style: Theme.of(context)
                                            //         .textTheme
                                            //         .bodyLarge,
                                            //   ),
                                            : Text.rich(
                                                TextSpan(
                                                  text: "Add ",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge,
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          "Rs ${(2500 - itemsTotal).toStringAsFixed(0)}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                            color: KColors
                                                                .primary, // Set the color to red
                                                          ),
                                                    ),
                                                    TextSpan(
                                                        text:
                                                            " more for Free Delivery"),
                                                  ],
                                                ),
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: KSizes.sm),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(KSizes.xs),
                              child: LinearProgressIndicator(
                                value: (itemsTotal / 2500).clamp(0.0, 1.0),
                                backgroundColor: KColors.grey,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  itemsTotal >= 2500
                                      ? KColors.success
                                      : KColors.primary,
                                ),
                                minHeight: 4,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Confirm Order Button
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: KSizes.defaultSpace,
                          vertical: KSizes.xs,
                        ),
                        child: ElevatedButton(
                          onPressed: isLoading || isDeliveryChargeLoading.value
                              ? null
                              : () async {
                                  await placeOrder();
                                },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    KSizes.borderRadiusLg)),
                            padding: EdgeInsets.zero,

                            minimumSize:
                                Size(double.infinity, 50.h), // Adjusted height
                          ),
                          child: const Text("CONFIRM ORDER"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        body: isLoading || isDeliveryChargeLoading.value
            ? Center(child: KIndicator.circularIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(KSizes.md),
                      margin: EdgeInsets.only(bottom: KSizes.xs),
                      color: KColors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Payment Details",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SizedBox(height: KSizes.spaceBtwItems),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Items Total",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text(
                                "Rs ${itemsTotal.toStringAsFixed(0)}",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                          const SizedBox(height: KSizes.md),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Delivery Charge",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text(
                                deliveryCharge.value == 0
                                    ? 'Free Delivery'
                                    : "Rs ${deliveryCharge.value.toStringAsFixed(0)}",
                                // : "Rs ${deliveryCharge.toStringAsFixed(0)}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        color: deliveryCharge.value == 0
                                            ? KColors.primary
                                            : Colors.black),
                              ),
                            ],
                          ),
                          const SizedBox(height: KSizes.md),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Grand Total",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              (appliedPromoCode.value.isNotEmpty)
                                  ? Row(
                                      children: [
                                        Text(
                                          "Rs ${grandTotal.toStringAsFixed(0)}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                        ),
                                        SizedBox(width: KSizes.xs),
                                        Text(
                                          "Rs ${(grandTotal - discount.value).toStringAsFixed(0)}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                      ],
                                    )
                                  : Text(
                                      "Rs ${grandTotal.toStringAsFixed(0)}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(KSizes.md),
                      margin: EdgeInsets.only(bottom: KSizes.xs),
                      color: KColors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Delivery Address",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SizedBox(height: KSizes.sm),
                          isLoading
                              ? ShimmerWidget(
                                  shimmerWidth: double.infinity,
                                  shimmerHeight: 60.h,
                                  shimmerRadius: KSizes.sm)
                              : deliveryAddress == null || address == null
                                  ? Text("No Address found",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium)
                                  : CheckoutAddressTile(
                                      addressTitle:
                                          address!.addressTitle ?? "No title",
                                      addressLocation:
                                          address!.location ?? "No location",
                                      isSelected: true,
                                      onSelect: () {},
                                    ),
                          const SizedBox(height: KSizes.md),
                          InkWell(
                            onTap: () {
                              showAddressModal(context, refetch);
                            },
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.add_location_alt_outlined,
                                  color: KColors.primary,
                                ),
                                SizedBox(width: KSizes.sm),
                                Text(
                                  "Add Delivery Address",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: KColors.primary,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(KSizes.md),
                      margin: EdgeInsets.only(bottom: KSizes.xs),
                      color: KColors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Payment Method",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: KSizes.md),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: KColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                          KSizes.borderRadiusLg),
                                      topRight: Radius.circular(
                                          KSizes.borderRadiusLg)),
                                ),
                                isScrollControlled: true,
                                builder: (context) => PaymentMethodBottomSheet(
                                  onSelect: (paymentMethod, imagePath) {
                                    selectedPaymentMethod.value = paymentMethod;
                                    selectedPaymentMethodImage.value =
                                        imagePath;
                                  },
                                  selectedPaymentMethod:
                                      selectedPaymentMethod.value,
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  selectedPaymentMethodImage.value,
                                  width: 30.w,
                                  height: 30.h,
                                ),
                                SizedBox(width: KSizes.sm),
                                Text(
                                  selectedPaymentMethod.value,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const Spacer(),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: KColors.darkGrey,
                                  size: KSizes.iconSm,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Provider.of<OrderProvider>(context, listen: false)
                            .getPromoCodes();
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: KColors.white,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(KSizes.borderRadiusLg),
                                topRight:
                                    Radius.circular(KSizes.borderRadiusLg)),
                          ),
                          builder: (context) => PromoCodeBottomSheet(
                            promoCodeController: promoCodeController,
                            onApply: applyPromoCode,
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(KSizes.md),
                        margin: EdgeInsets.only(bottom: KSizes.xs),
                        color: KColors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(
                                  Iconsax.discount_circle,
                                  color: KColors.primary,
                                ),
                                SizedBox(width: KSizes.sm),
                                Text(
                                  "Add a Promo Code",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ],
                            ),
                            if (appliedPromoCode.value.isNotEmpty)
                              Text(
                                "Promo Code Applied: ${appliedPromoCode.value} ",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            if (discount.value > 0)
                              Text(
                                "Discount Applied: Rs ${discount.value.toStringAsFixed(0)}",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            // const SizedBox(height: KSizes.md),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: KColors.white,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(KSizes.borderRadiusLg),
                                topRight:
                                    Radius.circular(KSizes.borderRadiusLg)),
                          ),
                          builder: (context) => OrderNoteBottomSheet(
                            orderNoteController: orderNoteController,
                            onSave: (note) {
                              // Optionally handle any additional actions here
                            },
                          ),
                        );
                        // updateOrderNote();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(KSizes.md),
                        margin: EdgeInsets.only(bottom: KSizes.xs),
                        color: KColors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(
                                  Iconsax.note,
                                  color: KColors.primary,
                                ),
                                SizedBox(width: KSizes.sm),
                                Text(
                                  "Add an Order Note",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(KSizes.md),
                      margin: EdgeInsets.only(bottom: KSizes.xs),
                      color: KColors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Order Summary",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: KSizes.md),
                          ...item!.map((order) => Padding(
                                padding: EdgeInsets.only(bottom: KSizes.sm),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(order.title),
                                    Text(
                                        "Rs ${order.price.toStringAsFixed(0)}"),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
