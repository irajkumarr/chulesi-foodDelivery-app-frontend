import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chulesi/common/styles/spacing_style.dart';
import 'package:chulesi/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:chulesi/core/network/connectivity_checker.dart';
import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/features/authentication/screens/login/widgets/login_form.dart';
import 'package:chulesi/features/authentication/screens/login/widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ConnectivityChecker(
      child: Scaffold(
        backgroundColor: KColors.white,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                  top: 40,
                  child: IconButton(
                      onPressed: () {
                        // Navigator.pop(context);
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/navigationMenu", (route) => false);
                      },
                      icon: const Icon(Icons.arrow_back))),
              Positioned(
                  top: 10,
                  right: -30,
                  child: CircularContainer(
                    width: 100.w,
                    height: 100.h,
                    color: KColors.accent.withOpacity(0.1),
                  )),
              Padding(
                padding: KSpacingStyle.paddingWithAppbar(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // login header
                    SizedBox(height: KSizes.spaceBtwSections),
                    const LoginHeader(),
                    SizedBox(
                      height: KSizes.spaceBtwItems,
                    ),
                    // login Form
                    const LoginForm(),

                    SizedBox(
                      height: KSizes.spaceBtwSections,
                    ),
                    //divider
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
