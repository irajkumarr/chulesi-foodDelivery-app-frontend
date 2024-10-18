import 'package:flutter/material.dart';
import 'package:chulesi/core/utils/constants/colors.dart';

import '../../../../../../core/utils/constants/sizes.dart';

class SettingsListTile extends StatelessWidget {
  const SettingsListTile({
    super.key,
    this.icon,
    required this.title,
    this.onPressed,
  });
  final IconData? icon;
  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: ListTile(
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            size: KSizes.iconSm,
            color: KColors.darkGrey,
          ),
          leading: Icon(
            icon,
            size: KSizes.iconMd - 3,
          ),
        )
        // Padding(
        //   padding:
        //       EdgeInsets.symmetric(horizontal: KSizes.sm, vertical: KSizes.md),
        //   child: Row(
        //     children: [
        //       Icon(
        //         icon,
        //         // size: KSizes.iconSm,
        //       ),
        //       const SizedBox(width: KSizes.md),
        //       Text(title,
        //           style: Theme.of(context).textTheme.titleSmall!.copyWith(
        //               fontWeight: FontWeight.w600, fontSize: KSizes.fontSizeSm)),

        //     ],
        //   ),
        // ),
        );
  }
}
