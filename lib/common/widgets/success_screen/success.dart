import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/constants/sizes.dart';
import '../../../core/utils/constants/text_strings.dart';
import '../../../core/utils/helpers/helper_functions.dart';
import '../../styles/spacing_style.dart';

class SuccessScreen extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subTitle;
  final VoidCallback onPressed;
  const SuccessScreen(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.subTitle,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: KSpacingStyle.paddingWithAppbar() * 2,
        child: Column(
          children: [
            Lottie.asset(imagePath,
                width: KHelperFunctions.screenWidth(context) * 0.6),
            SizedBox(
              height: KSizes.spaceBtwItems,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: KSizes.spaceBtwItems,
            ),
            Text(
              subTitle,
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: KSizes.spaceBtwSections,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: KColors.primary,
                ),
                onPressed: onPressed,
                child: const Text(KTexts.done),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
