import 'package:cached_network_image/cached_network_image.dart';
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
          height: 150.h,
          width: KDeviceUtils.getScreenWidth(context),
          child: CachedNetworkImage(
            imageUrl:
                "https://firebasestorage.googleapis.com/v0/b/chulesi-app.appspot.com/o/slider%2Ffirstorder%20banner.jpeg?alt=media&token=067bb4d1-0e71-485d-bfc3-2a8c3cc4bb1d",
            placeholder: (context, url) => SizedBox(
              // height: 150.h,
              height: 140.h,
              width: KDeviceUtils.getScreenWidth(context),
              child: Image.asset(
                KImages.banner_placeholder,
                fit: BoxFit.cover,
              ),
            ),
            errorWidget: (context, url, error) => Image.asset(
              KImages.placeholder_image,
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
