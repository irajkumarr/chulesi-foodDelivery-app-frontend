import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/core/utils/constants/text_strings.dart';
import 'package:chulesi/core/utils/validators/validation.dart';
import 'package:chulesi/data/models/login_model.dart';
import 'package:chulesi/features/authentication/providers/login_provider.dart';
import 'package:chulesi/features/authentication/providers/password_provider.dart';

import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../../../../core/services/notification_service.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailOrPhoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailOrPhoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ///Email
          TextFormField(
            controller: _emailOrPhoneController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontSize: KSizes.fontSizeSm),
            validator: (value) => KValidator.validateEmailOrPhone(value),
            decoration: const InputDecoration(
              // prefixIcon: Icon(Iconsax.direct_right),
              labelText: "Email/Phone",
            ),
          ),
          SizedBox(
            height: KSizes.spaceBtwInputFields,
          ),

          ///Password
          Consumer<PasswordProvider>(builder: (context, value, child) {
            return TextFormField(
              controller: _passwordController,
              textInputAction: TextInputAction.done,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: KSizes.fontSizeSm),
              validator: (value) =>
                  KValidator.validateEmptyText("Password", value),
              obscureText: value.loginPasswordVisible,
              decoration: InputDecoration(
                // prefixIcon: const Icon(Iconsax.password_check),
                labelText: KTexts.password,
                suffixIcon: IconButton(
                    onPressed: () {
                      value.toggleLoginPasswordVisibility();
                    },
                    icon: Icon(value.loginPasswordVisible
                        ? Iconsax.eye_slash
                        : Iconsax.eye)),
              ),
            );
          }),

          SizedBox(
            height: KSizes.spaceBtwSections / 2,
          ),

          //forget password
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/forgotPassword");
                  },
                  child: const Text(
                    KTexts.forgetPassword,
                    style: TextStyle(
                        color: KColors.primary, fontWeight: FontWeight.w600),
                  )),
            ],
          ),
          SizedBox(
            height: KSizes.spaceBtwSections,
          ),
          // login Buttons
          SizedBox(
            width: double.infinity,
            // height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(KSizes.md),
                // padding: EdgeInsets.zero,
                backgroundColor: KColors.primary,
              ),
              onPressed: loginProvider.isLoading
                  ? null
                  : () async {
                      NotificationService notificationService =
                          NotificationService();
                      var fcmToken = await notificationService.getDeviceToken();
                      if (_formKey.currentState!.validate()) {
                        LoginModel model = LoginModel(
                          email: _emailOrPhoneController.text.trim(),
                          password: _passwordController.text,
                          fcm: fcmToken ?? '',
                        );
                        String data = loginModelToJson(model);
                        await loginProvider.login(context, data);
                      }
                    },
              child: loginProvider.isLoading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(KTexts.login),
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
                  : const Text(KTexts.login),
            ),
          ),
          SizedBox(
            height: KSizes.spaceBtwSections / 2,
          ),
          SizedBox(
            width: double.infinity,
            // height: 50,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(KSizes.md),
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/signup");
              },
              child: const Text(KTexts.signup),
            ),
          ),
        ],
      ),
    );
  }
}
