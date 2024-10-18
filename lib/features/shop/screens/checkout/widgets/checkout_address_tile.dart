import 'package:flutter/material.dart';
import 'package:chulesi/core/utils/constants/colors.dart';

class CheckoutAddressTile extends StatelessWidget {
  final String addressTitle;
  final String addressLocation;
  final bool isSelected;
  final void Function() onSelect;

  const CheckoutAddressTile({
    super.key,
    required this.addressTitle,
    required this.addressLocation,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      minVerticalPadding: 1,
      
      minTileHeight: 40,
      // leading: Radio<bool>(
      //   value: true,
      //   activeColor: KColors.primary,
      //   groupValue: isSelected,
      //   onChanged: (value) {
      //     if (value != null) {
      //       onSelect();
      //     }
      //   },
      // ),
      title: Text(
        addressTitle,
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: KColors.primary),
      ),
      subtitle: Text(
        addressLocation,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      onTap: () {
        onSelect();
      },
    );
  }
}
