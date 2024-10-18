// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:chulesi/core/utils/constants/colors.dart';
// import 'package:chulesi/core/utils/constants/image_strings.dart';
// import 'package:chulesi/core/utils/constants/sizes.dart';
// import 'package:get_storage/get_storage.dart';

// class HomeAddAddressWidget extends StatelessWidget {
//   const HomeAddAddressWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final box = GetStorage();
//     String? token = box.read("token");
//     String? defaultAddress = box.read("defaultAddressId");
//     return token == null || defaultAddress != null
//         ? const SizedBox()
//         : Container(
//             padding: const EdgeInsets.all(KSizes.md),
//             margin: EdgeInsets.only(bottom: KSizes.spaceBtwItems),
//             decoration: BoxDecoration(
//               // borderRadius: BorderRadius.circular(KSizes.md),
//               color: KColors.secondary.withOpacity(0.5),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 SizedBox(
//                   height: 75.h,
//                   width: 75.w,
//                   child: SvgPicture.asset(
//                     KImages.location,
//                   ),
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Which location do you want to select?",
//                         style: Theme.of(context).textTheme.titleLarge),
//                     SizedBox(height: KSizes.sm),
//                     ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: KColors.primary,
//                           foregroundColor: KColors.white,
//                           padding:
//                               const EdgeInsets.symmetric(horizontal: KSizes.md),
//                         ),
//                         onPressed: () {
//                           Navigator.pushNamed(context, "/address");
//                         },
//                         child: const Text("Add Delivery Address")),
//                   ],
//                 ),
//               ],
//             ),
//           );
//   }
// }

// ignore_for_file: deprecated_member_use

import 'package:chulesi/features/personalization/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/core/utils/constants/image_strings.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class HomeAddAddressWidget extends StatefulWidget {
  const HomeAddAddressWidget({super.key});

  @override
  _HomeAddAddressWidgetState createState() => _HomeAddAddressWidgetState();
}

class _HomeAddAddressWidgetState extends State<HomeAddAddressWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true); // Repeat the animation

    // Create a Tween animation for scaling
    _animation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller to free up resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final profileProvider = Provider.of<ProfileProvider>(context);
    String? token = box.read("token");
    String? defaultAddress = box.read("defaultAddressId");

    if (token == null || defaultAddress != null) {
      return const SizedBox();
    }

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: KSizes.sm.w,
        vertical: KSizes.sm.h,
      ),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.r),
            gradient: LinearGradient(
              colors: [
                KColors.primary,
                KColors.primary.withOpacity(0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(KSizes.md.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _buildAnimatedIcon(),
                    SizedBox(width: KSizes.md.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi ${profileProvider.user?.firstName ?? " "}!",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: KColors.white,
                                ),
                          ),
                          SizedBox(height: KSizes.xs.h),
                          Text(
                            "Add your delivery address to receive your orders at your doorstep.",
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: KColors.white.withOpacity(0.9),
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: KSizes.md.h),
                _buildAddAddressButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedIcon() {
    return ScaleTransition(
      scale: _animation,
      child: Container(
        padding: EdgeInsets.all(KSizes.sm.w),
        decoration: BoxDecoration(
          color: KColors.white.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: SizedBox(
          height: 50.h,
          width: 50.w,
          child: SvgPicture.asset(
            KImages.location,
            color: KColors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildAddAddressButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: KColors.white,
          foregroundColor: KColors.primary,
          padding: EdgeInsets.symmetric(
            horizontal: KSizes.md.w,
            // vertical: KSizes.md.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(context, "/address");
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add_location, size: 20.sp, color: KColors.primary),
            SizedBox(width: KSizes.sm.w),
            Text(
              "Add Delivery Address",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
                color: KColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
