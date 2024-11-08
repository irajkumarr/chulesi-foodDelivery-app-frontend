import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/core/utils/constants/image_strings.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';

class LoginRedirect extends StatelessWidget {
  const LoginRedirect({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 200.w,
              height: 200.h,
              child: SvgPicture.asset(
                KImages.loginIllustration,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Oops!",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: KColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 32.sp,
                      ),
                ),
                SizedBox(height: KSizes.sm),
                Text(
                  "It looks like you're not logged in.",
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: KColors.black,
                        fontSize: 14.sp,
                        // fontStyle: FontStyle.italic,
                      ),
                ),
                SizedBox(height: KSizes.md),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    "To access this feature, please log in to your account.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: KColors.textGrey,
                        ),
                  ),
                ),
                SizedBox(height: KSizes.lg),
                SizedBox(
                  width: 175.w,
                  height: 55.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(KSizes.sm)),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "/login");
                    },
                    child: Text(
                      "LOGIN NOW",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: KColors.white,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
