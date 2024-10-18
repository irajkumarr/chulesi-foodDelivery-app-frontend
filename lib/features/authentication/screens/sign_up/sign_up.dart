import 'package:flutter/material.dart';
import 'package:chulesi/core/network/connectivity_checker.dart';
import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/features/authentication/screens/sign_up/widgets/signup_form.dart';
import 'package:chulesi/features/authentication/screens/sign_up/widgets/signup_header.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ConnectivityChecker(
      child: Scaffold(
        backgroundColor: KColors.white,
        appBar: AppBar(
          title: const Text("Sign up"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(KSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SignupHeader(),
                SizedBox(
                  height: KSizes.spaceBtwSections,
                ),
                const SignupForm(),
                SizedBox(
                  height: KSizes.spaceBtwSections / 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
