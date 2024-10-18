import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chulesi/core/utils/circular_progress_indicator/circlular_indicator.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/core/utils/popups/toast.dart';
import 'package:chulesi/data/models/promo_code_model.dart';
import 'package:chulesi/features/personalization/providers/order_provider.dart';
import 'package:provider/provider.dart';

class PromoCodeBottomSheet extends StatelessWidget {
  final TextEditingController promoCodeController;
  final VoidCallback onApply;

  const PromoCodeBottomSheet({
    super.key,
    required this.promoCodeController,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    // print(orderProvider.promoCodes);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: bottomInset + 16.0.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Apply Promo Code',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: KSizes.spaceBtwItems),
          TextField(
            controller: promoCodeController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter promo code',
            ),
          ),
          SizedBox(height: KSizes.spaceBtwItems),
          Text(
            'Available Promo Codes:',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: KSizes.spaceBtwItems),
          SizedBox(
            height: 70.h,
            child: orderProvider.promoCodes.isEmpty
                ? const Text("No Promo Code Available")
                : orderProvider.isLoading
                    ? KIndicator.circularIndicator()
                    : ListView.builder(
                        itemCount: orderProvider.promoCodes.length,
                        itemBuilder: (context, index) {
                          PromoCodeModel promoCode =
                              orderProvider.promoCodes[index];
                          return Row(
                            children: [
                              Text(
                                promoCode.code,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text(
                                " - ",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text(
                                promoCode.description,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          );
                        },
                      ),
          ),
          SizedBox(height: KSizes.spaceBtwSections),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: KSizes.md),
              ),
              onPressed: () {
                final promoCode = promoCodeController.text;
                if (promoCode.isNotEmpty) {
                  onApply();
                  Navigator.pop(context);
                } else {
                  showToast("Promo Code is empty");
                }
              },
              child: const Text('Apply Promo Code'),
            ),
          ),
        ],
      ),
    );
  }
}
