import 'package:flutter/material.dart';


import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/constants/sizes.dart';


class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    this.buttonText = "View all",
    required this.showButtonTitle,
    this.textColor,
    this.onPressed,
  });
  final String title, buttonText;
  final bool showButtonTitle;
  final Color? textColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KSizes.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.w600, color: textColor),
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
          if (showButtonTitle)
            InkWell(
              onTap: onPressed,
              child: Text(
                buttonText,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: KColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          // GestureDetector(
          //   onTap: onPressed,
          //   child: Container(
          //     padding: const EdgeInsets.all(3),
          //     decoration: BoxDecoration(
          //         color: KColors.white,
          //         borderRadius: BorderRadius.circular(50),
          //         border: Border.all(
          //           color: KColors.secondary,
          //         )),
          //     child: const Icon(
          //       MaterialCommunityIcons.arrow_right,
          //       color: KColors.primary,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
