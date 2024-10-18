import 'package:flutter/material.dart';

import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/constants/sizes.dart';
import '../../../core/utils/helpers/helper_functions.dart';


class VerticalImageText extends StatelessWidget {
  const VerticalImageText({
    super.key,
    required this.title,
    required this.image,
    this.textColor = KColors.white,
    this.bgColor,
    this.onTap,
  });
  final String title, image;
  final Color textColor;
  final Color? bgColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = KHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: KSizes.defaultSpace / 2),
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              padding:  EdgeInsets.all(KSizes.sm),
              decoration: BoxDecoration(
                color: bgColor ?? (dark ? KColors.black : KColors.white),
                borderRadius: BorderRadius.circular(56),
              ),
              child: Image(
                image: AssetImage(image),
                fit: BoxFit.cover,
                color: dark ? KColors.light : KColors.dark,
              ),
            ),
             SizedBox(height: KSizes.spaceBtwItems / 2),
            SizedBox(
              width: 55,
              child: Text(
                title,
                style: Theme.of(context).textTheme.labelMedium!.apply(
                      color: textColor,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
