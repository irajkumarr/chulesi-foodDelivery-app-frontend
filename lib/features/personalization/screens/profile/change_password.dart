import 'package:chulesi/core/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:chulesi/common/widgets/loaders/full_screen_overlay.dart';
import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/core/utils/validators/validation.dart';
import 'package:chulesi/features/authentication/providers/password_provider.dart';
import 'package:chulesi/features/personalization/providers/profile_provider.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context, listen: true);
    return FullScreenOverlay(
      isLoading: profileProvider.isLoading,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight()),
          child: Material(
            elevation: 1,
            child: AppBar(
              title: const Text("Change Password"),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: KSizes.spaceBtwSections,
              horizontal: KSizes.defaultSpace),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                //old password
                Consumer<PasswordProvider>(builder: (context, value, child) {
                  return TextFormField(
                    controller: _oldPasswordController,
                    textInputAction: TextInputAction.next,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: KSizes.fontSizeSm),
                    validator: (value) =>
                        KValidator.validateEmptyText("Old Password", value),
                    obscureText: value.oldPasswordVisible,
                    decoration: InputDecoration(
                      labelText: "Old Password",
                      suffixIcon: IconButton(
                        onPressed: () {
                          value.toggleOldPasswordVisibility();
                        },
                        icon: Icon(value.oldPasswordVisible
                            ? Iconsax.eye_slash
                            : Iconsax.eye),
                      ),
                    ),
                  );
                }),
                SizedBox(height: KSizes.spaceBtwSections),
                //new password
                Consumer<PasswordProvider>(builder: (context, value, child) {
                  return TextFormField(
                    controller: _newPasswordController,
                    textInputAction: TextInputAction.next,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: KSizes.fontSizeSm),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your new password';
                      }
                      if (value == _oldPasswordController.text) {
                        return 'New password cannot be the same as old password';
                      }
                      return null;
                    },
                    obscureText: value.newPasswordVisible,
                    decoration: InputDecoration(
                      labelText: "New Password",
                      suffixIcon: IconButton(
                          onPressed: () {
                            value.toggleNewPasswordVisibility();
                          },
                          icon: Icon(value.newPasswordVisible
                              ? Iconsax.eye_slash
                              : Iconsax.eye)),
                    ),
                  );
                }),
                SizedBox(height: KSizes.spaceBtwSections),
                //confirm new password
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
                        return 'Please confirm your new password';
                      }
                      if (value != _newPasswordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    obscureText: value.confirmPasswordVisible,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      suffixIcon: IconButton(
                          onPressed: () {
                            value.toggleConfirmPasswordVisibility();
                          },
                          icon: Icon(value.confirmPasswordVisible
                              ? Iconsax.eye_slash
                              : Iconsax.eye)),
                    ),
                  );
                }),
                SizedBox(height: KSizes.spaceBtwSections * 2),
                // Change password Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(KSizes.md),
                      backgroundColor: KColors.primary,
                    ),
                    onPressed: profileProvider.isLoading
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              await profileProvider.changePassword(
                                  context,
                                  _oldPasswordController.text,
                                  _newPasswordController.text);
                            }
                          },
                    child:
                        //  profileProvider.isLoading
                        //     ? Row(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           const Text("Changing Password"),
                        //           const SizedBox(width: KSizes.md),
                        //           SizedBox(
                        //             height: 12.h,
                        //             width: 12.w,
                        //             child: const CircularProgressIndicator(
                        //               color: KColors.primary,
                        //               strokeWidth: 1,
                        //             ),
                        //           ),
                        //         ],
                        //       )
                        //     :
                        const Text("Change Password"),
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
