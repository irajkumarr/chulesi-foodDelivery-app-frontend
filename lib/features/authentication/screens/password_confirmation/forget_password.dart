import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/core/utils/constants/text_strings.dart';
import 'package:chulesi/core/utils/validators/validation.dart';
import 'package:chulesi/features/authentication/providers/login_provider.dart';
import 'package:chulesi/features/authentication/providers/timer_provider.dart';
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
    final timerProvider =
        Provider.of<ResendTimerProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: KColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: KColors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/login", (route) => false);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(KSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Header Section
                SizedBox(height: 40.h),
                Icon(
                  Icons.lock_reset_rounded,
                  size: 80.h,
                  color: KColors.primary,
                ),
                SizedBox(height: KSizes.spaceBtwItems),
                Text(
                  "Forgot Password?",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Don't worry! It happens. Enter your email address to receive\na verification code",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                SizedBox(height: 40.h),

                // Form Section
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
                          ),
                          onPressed: loginProvider.isLoading
                              ? null
                              : () async {
                                  if (_formKey.currentState!.validate()) {
                                    timerProvider.startTimer();

                                    // Call forgotPassword which will handle navigation
                                    await loginProvider.forgotPassword(
                                      context,
                                      _emailController.text.trim(),
                                    );
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
