import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chulesi/core/services/notification_service.dart';
import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/core/utils/constants/text_strings.dart';
import 'package:chulesi/core/utils/validators/validation.dart';
import 'package:chulesi/data/models/registration_model.dart';
import 'package:chulesi/features/authentication/providers/password_provider.dart';
import 'package:chulesi/features/authentication/providers/signup_provider.dart';
import 'package:chulesi/features/authentication/screens/sign_up/widgets/terms_conditions_checkbox.dart';

import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({
    super.key,
  });

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signupProvider = Provider.of<SignupProvider>(context);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ///firstName and lastname--------------
              Expanded(
                child: TextFormField(
                  controller: _firstNameController,
                  textInputAction: TextInputAction.next,
                  validator: (value) =>
                      KValidator.validateEmptyText("First name", value),
                  expands: false,
                  decoration: const InputDecoration(
                    // prefixIcon: Icon(Iconsax.user),
                    labelText: KTexts.firstName,
                  ),
                ),
              ),
              SizedBox(
                width: KSizes.spaceBtwInputFields,
              ),
              Expanded(
                child: TextFormField(
                  controller: _lastNameController,
                  textInputAction: TextInputAction.next,
                  validator: (value) =>
                      KValidator.validateEmptyText("Last name", value),
                  expands: false,
                  decoration: const InputDecoration(
                    // prefixIcon: Icon(Iconsax.user),
                    labelText: KTexts.lastName,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: KSizes.spaceBtwInputFields,
          ),

          ///email-------------------
          TextFormField(
            controller: _emailController,
            textInputAction: TextInputAction.next,
            validator: (value) => KValidator.validateEmail(value),
            decoration: const InputDecoration(
              // prefixIcon: Icon(Iconsax.direct),
              labelText: KTexts.email,
            ),
          ),
          SizedBox(
            height: KSizes.spaceBtwInputFields,
          ),

          ///phoneNumber-----------------
          TextFormField(
            controller: _phoneController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.phone,
            validator: (value) => KValidator.validatePhoneNumber(value),
            decoration: const InputDecoration(
              // prefixIcon: Icon(Iconsax.call),
              labelText: KTexts.phoneNo,
            ),
          ),
          SizedBox(
            height: KSizes.spaceBtwInputFields,
          ),

          ///password-------------------
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

          SizedBox(
            height: KSizes.spaceBtwInputFields,
          ),

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
            height: KSizes.spaceBtwSections / 2,
          ),
          //terms and condition------------------
          const TermsConditionsCheckbox(),

          SizedBox(
            height: KSizes.spaceBtwSections,
          ),
          // create account Buttons---------------
          SizedBox(
            width: double.infinity,
            // height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(KSizes.md),
                // padding: EdgeInsets.zero,
                backgroundColor: KColors.primary,
              ),
              onPressed: signupProvider.isLoading
                  ? null
                  : () async {
                      NotificationService notificationService =
                          NotificationService();
                      var fcmToken = await notificationService.getDeviceToken();
                      if (_formKey.currentState!.validate()) {
                        RegistrationModel model = RegistrationModel(
                          firstName: _firstNameController.text.trim(),
                          lastName: _lastNameController.text.trim(),
                          phone: _phoneController.text.trim(),
                          email: _emailController.text.trim(),
                          password: _passwordController.text,
                          fcm: fcmToken ?? '',
                        );
                        String data = registrationModelToJson(model);

                        await signupProvider.signup(context, data);
                      }
                    },
              child: signupProvider.isLoading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(KTexts.signup),
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
                  : const Text(KTexts.signup),
            ),
          ),
          SizedBox(
            height: KSizes.spaceBtwSections / 2,
          ),
        ],
      ),
    );
  }
}
