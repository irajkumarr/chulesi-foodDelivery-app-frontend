import 'package:chulesi/core/utils/constants/image_strings.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/features/shop/screens/more/widgets/social_icon_widget.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../core/utils/constants/colors.dart';

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: KColors.white,
        title: const Text("Support"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: KSizes.md),
          child: Column(
            children: [
              SocialIconWidget(
                image: KImages.whatsapp,
                text: "Whatsapp",
                onPressed: () {
                  launchUrlString("https://wa.me/9807227662");
                },
              ),
              SizedBox(height: KSizes.spaceBtwItems),
              SocialIconWidget(
                image: KImages.phone,
                text: "Contact",
                onPressed: () async {
                  final Uri url = Uri(scheme: "tel", path: "9807227662");
                  await launchUrl(url);
                  // if (await canLaunchUrl(url)) {
                  // } else {
                  //   throw 'Could not launch $url';
                  // }
                },
              ),
              SizedBox(height: KSizes.spaceBtwItems),
              SocialIconWidget(
                image: KImages.messenger,
                text: "Messenger",
                onPressed: () {
                  launchUrlString(
                      "https://www.messenger.com/t/100075365573298/");
                },
              ),
              SizedBox(height: KSizes.spaceBtwItems),
              SocialIconWidget(
                image: KImages.facebook,
                text: "facebook",
                onPressed: () {
                  launchUrlString(
                      "https://www.facebook.com/p/Pathao-on-hetauda-100082625476980/");
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
