
import 'package:chulesi/features/authentication/providers/timer_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/core/utils/constants/text_strings.dart';
import 'package:chulesi/core/utils/validators/validation.dart';
import 'package:chulesi/features/authentication/providers/login_provider.dart';
import 'package:chulesi/features/authentication/providers/password_provider.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, required this.email});
  final String email;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    final timerProvider = Provider.of<ResendTimerProvider>(context);
    return Scaffold(
      backgroundColor: KColors.white,
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/login");
            },
            icon: const Icon(Icons.arrow_back)),
        backgroundColor: KColors.white,
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Navigator.pushNamed(context, "/login");
        //       },
        //       icon: const Icon(CupertinoIcons.clear))
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(KSizes.defaultSpace),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter Verification Code",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: KSizes.spaceBtwSections),
                Pinput(
                  controller: _otpController,
                  length: 6,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter OTP';
                    } else if (value.length != 6) {
                      return 'OTP must be exactly 6 digits';
                    }

                    return null;
                  },
                  defaultPinTheme: PinTheme(
                    width: 50.w,
                    height: 50.h,
                    textStyle: TextStyle(
                        fontSize: 18.sp,
                        color: const Color.fromRGBO(30, 60, 87, 1),
                        fontWeight: FontWeight.w500),
                    decoration: BoxDecoration(
                      color: KColors.white,
                      border:
                          // Border.all(color: KColors.secondary),
                          Border.all(
                              color: const Color.fromRGBO(234, 239, 243, 1)),
                      borderRadius:
                          BorderRadius.circular(KSizes.borderRadiusMd),
                    ),
                  ),
                  focusedPinTheme: PinTheme(
                    width: 50.w,
                    height: 50.h,
                    textStyle: TextStyle(
                        fontSize: 18.sp,
                        color: KColors.primary,
                        fontWeight: FontWeight.w500),
                    decoration: BoxDecoration(
                      color: KColors.white,
                      border: Border.all(color: KColors.primary),
                      borderRadius:
                          BorderRadius.circular(KSizes.borderRadiusMd),
                    ),
                  ),
                  submittedPinTheme: PinTheme(
                    width: 50.w,
                    height: 50.h,
                    textStyle: TextStyle(
                        fontSize: 18.sp,
                        color: const Color.fromRGBO(30, 60, 87, 1),
                        fontWeight: FontWeight.w500),
                    decoration: BoxDecoration(
                      color: KColors.white,
                      border: Border.all(color: KColors.accent),
                      borderRadius:
                          BorderRadius.circular(KSizes.borderRadiusMd),
                    ),
                  ),
                  onCompleted: (value) {
                    loginProvider.setOtp(value);
                    print(value);
                    print(loginProvider.otp);
                    // authRepo.verifyOTP(
                    //     context, verificationId, formProvider.otp.toString());
                  },
                ),
                SizedBox(height: KSizes.spaceBtwSections),
                //new password
                ///Password
                Consumer<PasswordProvider>(builder: (context, value, child) {
                  return TextFormField(
                    controller: _passwordController,
                    textInputAction: TextInputAction.next,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: KSizes.fontSizeSm),
                    validator: (value) => KValidator.validatePassword(value),
                    obscureText: value.signupPasswordVisible,
                    decoration: InputDecoration(
                      // prefixIcon: const Icon(Iconsax.password_check),
                      labelText: KTexts.password,
                      suffixIcon: IconButton(
                          onPressed: () {
                            value.toggleSignupPasswordVisibility();
                          },
                          icon: Icon(value.signupPasswordVisible
                              ? Iconsax.eye_slash
                              : Iconsax.eye)),
                    ),
                  );
                }),

                SizedBox(height: KSizes.spaceBtwSections),

                ///confirm password-------------------
                Consumer<PasswordProvider>(builder: (context, value, child) {
                  return TextFormField(
                    controller: _confirmPasswordController,
                    textInputAction: TextInputAction.done,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: KSizes.fontSizeSm),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    obscureText: value.signupConfirmPasswordVisible,
                    decoration: InputDecoration(
                      // prefixIcon: const Icon(Iconsax.password_check),
                      labelText: "Confirm Password",
                      suffixIcon: IconButton(
                          onPressed: () {
                            value.toggleSignupConfirmPasswordVisibility();
                          },
                          icon: Icon(value.signupConfirmPasswordVisible
                              ? Iconsax.eye_slash
                              : Iconsax.eye)),
                    ),
                  );
                }),
                SizedBox(
                  height: KSizes.spaceBtwInputFields,
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
                              // print(loginProvider.otp);
                              await loginProvider.resetPassword(
                                context,
                                widget.email,
                                loginProvider.otp,
                                _passwordController.text,
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
                SizedBox(
                  height: KSizes.spaceBtwSections / 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn't get code?",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    TextButton(
                      onPressed: timerProvider.canResendCode
                          ? () async {
                              _passwordController.clear();
                              _confirmPasswordController.clear();
                              _otpController.clear();
                              loginProvider.setOtp('');
                              await loginProvider.resendCode(
                                  context, widget.email);
                              timerProvider
                                  .startTimer(); // Restart timer after resending
                            }
                          : null,
                      child: Text(
                        timerProvider.canResendCode
                            ? "Resend Code"
                            : "Resend in ${timerProvider.formattedTime}s",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: timerProvider.canResendCode
                                ? KColors.primary
                                : KColors.grey,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
