import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';

import 'package:chulesi/core/utils/shimmers/shimmer_widget.dart';

class FullShimmer extends StatelessWidget {
  const FullShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        height: 195.h,
        child: Column(
          children: [
            ShimmerWidget(
                shimmerWidth: MediaQuery.of(context).size.width,
                shimmerHeight: 175.h,
                shimmerRadius: KSizes.borderRadiusMd),
          ],
        ));
  }
}
