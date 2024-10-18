import 'package:flutter/material.dart';

import '../../../../../../core/utils/constants/colors.dart';
import '../../../../../../core/utils/constants/sizes.dart';

class SocialIconWidget extends StatelessWidget {
  const SocialIconWidget({
    super.key,
    required this.image,
    required this.text,
    this.onPressed,
  });
  final String image;
  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        color: KColors.white,
        padding:
            EdgeInsets.symmetric(horizontal: KSizes.md, vertical: KSizes.sm),
        child: Row(
          children: [
            Image.asset(
              image,
              width: 35,
              height: 35,
              fit: BoxFit.cover,
            ),
            SizedBox(width: KSizes.sm),
            Text(text,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: KColors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: KSizes.fontSizeSm)),
          ],
        ),
      ),
    );
  }
}
