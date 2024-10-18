import 'package:flutter/material.dart';

import 'package:iconsax/iconsax.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/image_strings.dart';
import '../../../../core/utils/constants/sizes.dart';
import '../../../../core/utils/helpers/helper_functions.dart';
import '../../images_widget/roundedimage.dart';
import '../products_text/product_title_text.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = KHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        RoundedImage(
          width: 60,
          height: 60,
          imageUrl: KImages.google,
          color: dark ? KColors.darkerGrey : KColors.grey,
          padding: EdgeInsets.all(KSizes.sm),
        ),
        SizedBox(width: KSizes.spaceBtwItems),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Nike",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                   SizedBox(
                    width: KSizes.xs,
                  ),
                   Icon(
                    Iconsax.verify5,
                    color: KColors.primary,
                    size: KSizes.iconXs,
                  )
                ],
              ),
              const Flexible(
                  child: ProductTitleText(
                title: "Green Nike Sport Shoes",
                maxlines: 1,
              )),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Color ',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: ' Green',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextSpan(
                      text: ' Size',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: ' XXL',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
