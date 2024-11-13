import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chulesi/core/utils/constants/image_strings.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/core/utils/device/device_utility.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(KSizes.md),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(KSizes.sm),
        child: SizedBox(
          // height: 160.h,
          height: 160.h,
          width: KDeviceUtils.getScreenWidth(context),
          child: Image.asset(
            KImages.firstOrderBanner,
            fit: BoxFit.cover,
          ),
          //  CachedNetworkImage(
          //   imageUrl: KImages.firstOrderBanner,
          //   placeholder: (context, url) => SizedBox(
          //     // height: 150.h,
          //     height: 140.h,
          //     width: KDeviceUtils.getScreenWidth(context),
          //     child: Image.asset(
          //       KImages.banner_placeholder,
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          //   errorWidget: (context, url, error) => Image.asset(
          //     KImages.banner_placeholder,
          //   ),
          //   fit: BoxFit.cover,
          // ),
        ),
      ),
    );
  }
}
