import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/core/utils/constants/image_strings.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/core/utils/constants/text_strings.dart';
import 'package:chulesi/core/utils/validators/validation.dart';
import 'package:chulesi/features/authentication/providers/login_provider.dart';

import 'package:provider/provider.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
      backgroundColor: KColors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/login", (route) => false);
            },
            icon: const Icon(Icons.arrow_back)),
        backgroundColor: KColors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: KSizes.defaultSpace,
              vertical: KSizes.spaceBtwSections),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                // width: 200.w,
                height: 200.h,
                image: const AssetImage(KImages.darkAppLogo),
                fit: BoxFit.cover,
              ),
              // SizedBox(
              //   height: KSizes.spaceBtwItems,
              // ),
              Text(
                "Enter email address",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: KSizes.spaceBtwSections),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        validator: (value) => KValidator.validateEmail(value),
                        decoration: const InputDecoration(
                          labelText: KTexts.email,
                        ),
                      ),
                      SizedBox(
                        height: KSizes.spaceBtwSections,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: KColors.primary,
                            // padding: const EdgeInsets.all(KSizes.md),
                          ),
                          onPressed: loginProvider.isLoading
                              ? null
                              : () async {
                                  if (_formKey.currentState!.validate()) {
                                    await loginProvider.forgotPassword(
                                        context, _emailController.text.trim());
                                  }
                                },
                          child: loginProvider.isLoading
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(KTexts.kContinue),
                                    const SizedBox(width: KSizes.md),
                                    SizedBox(
                                      height: 12.h,
                                      width: 12.w,
                                      child: const CircularProgressIndicator(
                                        color: KColors.primary,
                                        strokeWidth: 1,
                                      ),
                                    ),
                                  ],
                                )
                              : const Text(KTexts.kContinue),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
