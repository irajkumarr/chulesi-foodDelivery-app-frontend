// import 'package:chulesi/core/utils/constants/image_strings.dart';
// import 'package:chulesi/core/utils/constants/sizes.dart';
// import 'package:chulesi/features/shop/screens/more/widgets/social_icon_widget.dart';
// import 'package:flutter/material.dart';

// import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher/url_launcher_string.dart';

// import '../../../../core/utils/device/device_utility.dart';

// class HelpAndSupportScreen extends StatelessWidget {
//   const HelpAndSupportScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight()),
//         child: Material(
//           elevation: 1,
//           child: AppBar(
//             title: const Text("Support"),
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: KSizes.md),
//           child: Column(
//             children: [
//               SocialIconWidget(
//                 image: KImages.whatsapp,
//                 text: "Whatsapp",
//                 onPressed: () {
//                   launchUrlString("https://wa.me/9821101186");
//                 },
//               ),
//               SizedBox(height: KSizes.spaceBtwItems),
//               SocialIconWidget(
//                 image: KImages.phone,
//                 text: "Contact",
//                 onPressed: () async {
//                   final Uri url = Uri(scheme: "tel", path: "9821101186");
//                   await launchUrl(url);
//                   // if (await canLaunchUrl(url)) {
//                   // } else {
//                   //   throw 'Could not launch $url';
//                   // }
//                 },
//               ),
//               SizedBox(height: KSizes.spaceBtwItems),
//               SocialIconWidget(
//                 image: KImages.messenger,
//                 text: "Messenger",
//                 onPressed: () {
//                   // launchUrlString("https://www.messenger.com/");
//                 },
//               ),
//               SizedBox(height: KSizes.spaceBtwItems),
//               SocialIconWidget(
//                 image: KImages.facebook,
//                 text: "facebook",
//                 onPressed: () {
//                   // launchUrlString(
//                   //     "https://www.facebook.com/p/Pathao-on-hetauda-100082625476980/");
//                 },
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:chulesi/core/utils/constants/image_strings.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../core/utils/device/device_utility.dart';

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight()),
        child: Material(
          elevation: 1,
          child: AppBar(
            title: const Text("Help and Support"),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: KSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: KSizes.md),
              _buildSupportCard(
                context,
                image: KImages.whatsapp,
                title: "WhatsApp",
                subtitle: "Chat with our support team",
                onTap: () => launchUrlString("https://wa.me/9821101186"),
              ),
              SizedBox(height: KSizes.spaceBtwItems),
              _buildSupportCard(
                context,
                image: KImages.phone,
                title: "Phone",
                subtitle: "Direct call to our support",
                onTap: () async {
                  final Uri url = Uri(scheme: "tel", path: "9821101186");
                  await launchUrl(url);
                },
              ),
              SizedBox(height: KSizes.spaceBtwItems),
              _buildSupportCard(
                context,
                image: KImages.messenger,
                title: "Messenger",
                subtitle: "Message us on Facebook",
                onTap: () {
                  // Add Messenger launch URL when available
                  // launchUrlString("https://www.messenger.com/");
                },
              ),
              SizedBox(height: KSizes.spaceBtwItems),
              _buildSupportCard(
                context,
                image: KImages.facebook,
                title: "Facebook",
                subtitle: "Connect with our page",
                onTap: () {
                  // Add Facebook page URL when available
                  // launchUrlString("https://www.messenger.com/");
                },
              ),
              SizedBox(height: KSizes.spaceBtwSections),
              const Text(
                'Need more help?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Text(
                'Email us at contact@chulesi.com',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSupportCard(
    BuildContext context, {
    required String image,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
          border: Border.all(color: Colors.grey.shade200),
        ),
        padding: EdgeInsets.all(KSizes.md),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(12),
              child: Image.asset(
                image,
                width: 40,
                height: 40,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(width: KSizes.spaceBtwItems),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}
