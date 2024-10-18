import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/core/utils/constants/image_strings.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/features/personalization/providers/profile_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(KSizes.md),
      child: SizedBox(
        width: double.infinity,
        child: Consumer<ProfileProvider>(
            builder: (context, profileProvider, child) {
          final user = profileProvider.user;

          return Row(
            children: [
              SizedBox(
                width: 80.w,
                height: 80.h,
                child: Image.asset(KImages.user),
              ),
              SizedBox(width: KSizes.spaceBtwItems),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${user?.firstName ?? "User"} ${user?.lastName ?? "Name"}",
                      style: Theme.of(context).textTheme.titleLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: KSizes.sm),
                    Row(
                      children: [
                        const Icon(
                          MaterialCommunityIcons.email_outline,
                          size: KSizes.md + 5,
                        ),
                        SizedBox(width: KSizes.sm),
                        Expanded(
                          child: Text(
                            user?.email ?? "Email not available",
                            style: Theme.of(context).textTheme.bodyMedium,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: KSizes.sm),
                    Row(
                      children: [
                        const Icon(
                          MaterialCommunityIcons.phone_outline,
                          size: KSizes.md + 5,
                        ),
                        SizedBox(width: KSizes.sm),
                        Expanded(
                          child: Text(
                            user?.phone ?? "Phone number not available",
                            style: Theme.of(context).textTheme.bodyMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: KSizes.spaceBtwSections),
              GestureDetector(
                onTap: () async {
                  Navigator.pushNamed(
                    context,
                    '/profileSetting',
                    arguments: {
                      'firstName': user!.firstName,
                      'lastName': user.lastName,
                      'email': user.email,
                      'phone': user.phone,
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(KSizes.sm),
                  decoration: BoxDecoration(
                      color: KColors.white,
                      borderRadius: BorderRadius.circular(50)),
                  child: const Icon(
                    MaterialCommunityIcons.pencil,
                    color: KColors.primary,
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
