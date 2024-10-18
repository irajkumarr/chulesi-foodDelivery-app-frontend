import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/features/authentication/screens/phone_verification/widgets/otp_form_field.dart';

import '../../../../../core/utils/constants/sizes.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final formProvider = Provider.of<FormProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: KColors.white,
        elevation: 1,
        shadowColor: KColors.black,
        title: const Text("Phone Verification"),
      ),
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text.rich(TextSpan(
                  text: 'Enter the verification code (OTP)\nsent to ',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: KColors.textGrey),
                  children: <InlineSpan>[
                    TextSpan(
                      text: '+977 9812345678',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: KColors.black, fontWeight: FontWeight.w800),
                    )
                  ])),
              SizedBox(height: KSizes.spaceBtwSections * 1.5),
              const OtpFormField(),
            ],
          ),
        ),
      ),
    );
  }
}
