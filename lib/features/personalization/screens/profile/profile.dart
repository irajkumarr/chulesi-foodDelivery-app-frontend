import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chulesi/common/widgets/alert_box/alert_box.dart';
import 'package:chulesi/common/widgets/loaders/full_screen_overlay.dart';
import 'package:chulesi/core/network/connectivity_checker.dart';
import 'package:chulesi/core/utils/shimmers/foodlist_shimmer.dart';
import 'package:chulesi/features/authentication/screens/login/widgets/login_redirect.dart';
import 'package:chulesi/features/personalization/providers/profile_provider.dart';
import 'package:chulesi/features/personalization/screens/profile/widgets/user_profile_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:chulesi/features/authentication/providers/login_provider.dart';

import 'package:chulesi/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:chulesi/features/personalization/screens/profile/widgets/profile_divider.dart';

import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    return ConnectivityChecker(
      child: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          if (profileProvider.isLoading) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Profile"),
                centerTitle: true,
                automaticallyImplyLeading: false,
              ),
              body: const FoodsListShimmer(),
            );
          }

          final user = profileProvider.user;
          if (user == null) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: KColors.primary,
                automaticallyImplyLeading: false,
                title: const Text(
                  "Profile",
                  style: TextStyle(color: KColors.white),
                ),
                centerTitle: true,
              ),
              body: const LoginRedirect(),
            );
          }
          // if (loginProvider.isLoading) {
          //   return Center(child: CircularProgressIndicator());
          // }
          return FullScreenOverlay(
            isLoading: loginProvider.isLoading,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: KColors.primary,
                automaticallyImplyLeading: false,
                title: const Text(
                  "Account",
                  style: TextStyle(color: KColors.white),
                ),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    // UserProfileWidget(user: user),
                    const UserProfileWidget(),
                    SizedBox(height: KSizes.spaceBtwSections),
                    Container(
                      color: KColors.white,
                      padding: EdgeInsets.symmetric(
                          vertical: KSizes.sm, horizontal: KSizes.sm),
                      child: Column(
                        children: [
                          ProfileMenu(
                            title: "Order History",
                            subTitle: "Your Purchase History",
                            icon: Iconsax.book,
                            onPressed: () {
                              Navigator.pushNamed(context, "/orderHistory");
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 40.0.h),
                            child: const ProfileDivider(),
                          ),
                          ProfileMenu(
                            title: "Delivery Address",
                            subTitle: "Your Delivery Address",
                            icon: Iconsax.location_add,
                            onPressed: () {
                              Navigator.pushNamed(context, "/address");
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 40.0.h),
                            child: const ProfileDivider(),
                          ),
                          ProfileMenu(
                            title: "Change Password",
                            subTitle: "Change Your Password",
                            icon: Iconsax.password_check,
                            onPressed: () {
                              Navigator.pushNamed(context, "/changePassword");
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 40.0.h),
                            child: const ProfileDivider(),
                          ),
                          ProfileMenu(
                              title: "Delete Account",
                              subTitle: "Delete My Account",
                              icon: Iconsax.trash,
                              onPressed: () async {
                                // Show confirmation dialog
                                CustomAlertBox.showAlert(
                                  context,
                                  "Are you sure you want to delete your account permanently?",
                                  () async {
                                    await loginProvider.delete(context);
                                    // profileProvider.clearUserData();

                                    // WidgetsBinding.instance
                                    //     .addPostFrameCallback((_) {
                                    //   Navigator.pushNamedAndRemoveUntil(
                                    //       context, "/splash", (route) => false);
                                    // });
                                  },
                                );
                              }),
                        ],
                      ),
                    ),
                    SizedBox(height: KSizes.sm),
                    GestureDetector(
                      onTap: () {
                        CustomAlertBox.showAlert(
                            context, "Are you sure you want to logout?",
                            () async {
                          await loginProvider.logout(context);
                        });
                      },
                      child: Container(
                        color: KColors.white,
                        child: Padding(
                          padding: EdgeInsets.all(20.0.h),
                          child: Row(
                            children: [
                              const Icon(Iconsax.logout),
                              SizedBox(width: KSizes.sm + 3),
                              Text("Logout",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: KSizes.fontSizeSm)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
