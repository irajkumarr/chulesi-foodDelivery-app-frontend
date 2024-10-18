import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chulesi/data/models/user_profile_model.dart';

import 'package:chulesi/features/personalization/providers/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/core/utils/constants/image_strings.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/core/utils/constants/text_strings.dart';
import 'package:chulesi/core/utils/validators/validation.dart';

class ProfileSettings extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  const ProfileSettings({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
  });

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.firstName);
    _lastNameController = TextEditingController(text: widget.lastName);
    _emailController = TextEditingController(text: widget.email);
    _phoneController = TextEditingController(text: widget.phone);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Update Profile"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: KSizes.spaceBtwItems,
                horizontal: KSizes.defaultSpace),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    width: 100.w,
                    height: 100.h,
                    child: Image.asset(KImages.user),
                  ),
                  SizedBox(height: KSizes.spaceBtwSections * 1.5),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // First name
                        TextFormField(
                          controller: _firstNameController,
                          textInputAction: TextInputAction.next,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: KSizes.fontSizeSm),
                          validator: (value) =>
                              KValidator.validateEmptyText("First name", value),
                          decoration: const InputDecoration(
                            labelText: KTexts.firstName,
                          ),
                        ),
                        SizedBox(
                          height: KSizes.spaceBtwSections,
                        ),
                        // Last name
                        TextFormField(
                          controller: _lastNameController,
                          textInputAction: TextInputAction.next,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: KSizes.fontSizeSm),
                          validator: (value) =>
                              KValidator.validateEmptyText("Last name", value),
                          decoration: const InputDecoration(
                            labelText: KTexts.lastName,
                          ),
                        ),
                        SizedBox(
                          height: KSizes.spaceBtwSections,
                        ),
                        // Phone number
                        TextFormField(
                          controller: _phoneController,
                          textInputAction: TextInputAction.next,
                          readOnly: true,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontSize: KSizes.fontSizeSm,
                                  color: KColors.darkGrey),
                          decoration: const InputDecoration(
                              labelText: KTexts.phoneNo,
                              labelStyle: TextStyle(color: KColors.darkGrey),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: KColors.grey))),
                        ),
                        SizedBox(height: KSizes.sm),
                        Text(
                          "NOTE: Your Phone Number cannot be changed",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(color: KColors.darkGrey),
                        ),
                        SizedBox(
                          height: KSizes.spaceBtwSections,
                        ),
                        // Email
                        TextFormField(
                          controller: _emailController,
                          textInputAction: TextInputAction.next,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: KSizes.fontSizeSm),
                          validator: (value) => KValidator.validateEmail(value),
                          decoration: const InputDecoration(
                            labelText: KTexts.email,
                          ),
                        ),
                        SizedBox(
                          height: KSizes.spaceBtwSections * 2,
                        ),
                        // Update profile Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: profileProvider.isLoading
                                ? null
                                : () async {
                                    if (_formKey.currentState!.validate()) {
                                      UserProfileModel model = UserProfileModel(
                                        firstName: _firstNameController.text,
                                        lastName: _lastNameController.text,
                                        email: _emailController.text.trim(),
                                        phone: _phoneController.text.trim(),
                                      );

                                      await profileProvider.updateProfile(
                                          context, model);
                                    }
                                  },
                            style: ElevatedButton.styleFrom(),
                            child: profileProvider.isLoading
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text("Updating Profile"),
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
                                : const Text("Update Profile"),
                          ),
                        ),
                        const SizedBox(
                          height: KSizes.defaultSpace,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
