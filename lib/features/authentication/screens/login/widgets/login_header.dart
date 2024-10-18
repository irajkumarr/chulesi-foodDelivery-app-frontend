import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chulesi/core/utils/constants/image_strings.dart';
import 'package:chulesi/core/utils/constants/text_strings.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          // width: 300.w,
          height: 200.h,
          image: const AssetImage(KImages.darkAppLogo),
          fit: BoxFit.cover,
        ),
        // SizedBox(
        //   height: KSizes.spaceBtwItems,
        // ),
        Text(
          KTexts.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ],
    );
  }
}
