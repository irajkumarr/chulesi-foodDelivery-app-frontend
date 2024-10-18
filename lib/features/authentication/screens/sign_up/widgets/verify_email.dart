import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/core/utils/constants/image_strings.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/core/utils/constants/text_strings.dart';
import 'package:chulesi/core/utils/helpers/helper_functions.dart';


class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});
  final String? email;

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                // AuthenticationRepository.instance.logout();
              },
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(KSizes.defaultSpace),
        child: Column(
          children: [
            Image(
                width: KHelperFunctions.screenWidth(context) * 0.8,
                // height: THelperFunctions.screenHeight() * 0.6,
                image: const AssetImage(KImages.deliveredEmailIllustration)),
            Text(
              KTexts.confirmEmail,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
             SizedBox(
              height: KSizes.spaceBtwItems,
            ),
            Text(
              email ?? '',
              style: Theme.of(context).textTheme.labelLarge,
              textAlign: TextAlign.center,
            ),
             SizedBox(
              height: KSizes.spaceBtwItems,
            ),
            Text(
              KTexts.confirmEmailSubTitle,
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
                onPressed: () {
                  // controller.checkEmailVerificationStatus();
                },
                child:  const Text("Continue"),
              ),
            ),
             SizedBox(
              height: KSizes.spaceBtwSections / 2,
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  // controller.sendEmailVerification();
                },
                child: Text(
                  KTexts.resendEmail,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
