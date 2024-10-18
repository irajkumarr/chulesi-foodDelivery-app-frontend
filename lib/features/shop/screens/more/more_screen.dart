import 'package:chulesi/core/utils/http/url_launch.dart';
import 'package:flutter/material.dart';
import 'package:chulesi/core/network/connectivity_checker.dart';
import 'package:chulesi/features/shop/screens/more/widgets/settings_list_tile.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/sizes.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ConnectivityChecker(
      child: Scaffold(
        backgroundColor: KColors.secondaryBackground,
        appBar: AppBar(
          elevation: 0.5,
          shadowColor: Colors.black,
          backgroundColor: KColors.primary,
          automaticallyImplyLeading: false,
          title: const Text(
            "More",
            style: TextStyle(color: KColors.white),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            // margin: EdgeInsets.only(top: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SettingsListTile(
                        icon: Iconsax.notification_bing,
                        title: "Notification",
                        onPressed: () {
                          Navigator.pushNamed(context, "/notification");
                        },
                      ),
                      const ProfileDivider(),

                      SettingsListTile(
                        icon: Iconsax.support,
                        title: "Help and Support",
                        onPressed: () {
                          // Navigator.pushNamed(context, "/feedback");
                          // launchUrlString("https://timalsinarajkumar.com.np");
                          Navigator.pushNamed(context, "/helpAndSupport");
                        },
                      ),
                      const ProfileDivider(),
                      SettingsListTile(
                        icon: Iconsax.message_question,
                        title: "FAQs",
                        onPressed: () {
                          // Navigator.pushNamed(context, "/faq");
                          UrlLaunch.launchUrl(
                              "https://www.timalsinarajkumar.com.np");
                          // launchUrlString("https://timalsinarajkumar.com.np");
                        },
                      ),
                      const ProfileDivider(),
                      SettingsListTile(
                        icon: Iconsax.direct,
                        title: "About Us",
                        onPressed: () {
                          // Navigator.pushNamed(context, "/aboutUs");
                          UrlLaunch.launchUrl(
                              "https://www.timalsinarajkumar.com.np");
                        },
                      ),
                      const ProfileDivider(),
                      SettingsListTile(
                        icon: Iconsax.star,
                        title: "Rate Us",
                        onPressed: () {
                          UrlLaunch.launchUrl(
                              "https://play.google.com/store/apps/details?id=com.google.android.youtube");
                        },
                      ),
                      const ProfileDivider(),
                      SettingsListTile(
                        icon: Iconsax.book,
                        title: "Terms and Conditions",
                        onPressed: () {
                          // Navigator.pushNamed(context, "/termsAndConditions");
                          UrlLaunch.launchUrl(
                              "https://www.timalsinarajkumar.com.np");
                        },
                      ),
                      const ProfileDivider(),
                      SettingsListTile(
                        icon: Icons.privacy_tip_outlined,
                        title: "Privacy Policy",
                        onPressed: () {
                          // Navigator.pushNamed(context, "/privacyPolicy");
                          UrlLaunch.launchUrl(
                              "https://www.timalsinarajkumar.com.np");
                        },
                      ),
                      const ProfileDivider(),
                      SizedBox(height: KSizes.spaceBtwSections * 2),
                      // const SocialIcon(),
                      // const ProfileDivider(),
                    ],
                  ),
                  SizedBox(height: KSizes.spaceBtwItems),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileDivider extends StatelessWidget {
  const ProfileDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: KSizes.md),
      child: Divider(
        color: KColors.textGrey,
        thickness: 0.2,
      ),
    );
  }
}
