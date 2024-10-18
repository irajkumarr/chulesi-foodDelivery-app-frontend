import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/core/utils/constants/image_strings.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';

class PaymentMethodBottomSheet extends StatelessWidget {
  final Function(String, String) onSelect;
  final String selectedPaymentMethod;

  const PaymentMethodBottomSheet({
    required this.onSelect,
    required this.selectedPaymentMethod,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(KSizes.md),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Method",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: KSizes.md),
          ListTile(
            leading: Image.asset(
              KImages.paymentMethod,
              width: 25.w,
              height: 25.h,
            ),
            title: const Text("Cash On Delivery"),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: KColors.darkGrey,
              size: KSizes.iconSm,
            ),
            onTap: () {
              onSelect("Cash On Delivery", KImages.paymentMethod);
              Navigator.pop(context);
            },
          ),
          // ListTile(
          //   leading: Image.asset(
          //     KImages.esewa,
          //     width: 25.w,
          //     height: 25.h,
          //   ),
          //   title: const Text("Esewa(COMING SOON)"),
          //   trailing: Icon(
          //     Icons.arrow_forward_ios,
          //     color: KColors.darkGrey,
          //     size: KSizes.iconSm,
          //   ),
          //   onTap: () {
          //     onSelect("Esewa", KImages.esewa);
          //     Navigator.pop(context);
          //   },
          // ),
          // ListTile(
          //   leading: Image.asset(
          //     KImages.khalti,
          //     width: 25.w,
          //     height: 25.h,
          //   ),
          //   title: const Text("Khalti(COMING SOON)"),
          //   trailing: Icon(
          //     Icons.arrow_forward_ios,
          //     color: KColors.darkGrey,
          //     size: KSizes.iconSm,
          //   ),
          //   onTap: () {
          //     onSelect("Khalti", KImages.khalti);
          //     Navigator.pop(context);
          //   },
          // ),
        ],
      ),
    );
  }
}
