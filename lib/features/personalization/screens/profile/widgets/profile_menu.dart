import 'package:flutter/material.dart';

import '../../../../../../core/utils/constants/sizes.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,
    this.icon,
    required this.title,
    this.onPressed,
    required this.subTitle,
  });
  final IconData? icon;
  final String title;
  final String? subTitle;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: KSizes.sm, vertical: KSizes.sm),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: KSizes.iconMd,
            ),
            const SizedBox(width: KSizes.md),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                SizedBox(height: KSizes.xs),
                Text(subTitle!, style: Theme.of(context).textTheme.bodySmall)
              ],
            )
          ],
        ),
      ),
    );
  }
}
