import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';

import 'package:chulesi/core/utils/shimmers/shimmer_widget.dart';

class FoodFullShimmer extends StatelessWidget {
  const FoodFullShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerWidget(
            // shimmerWidth: 70.w,
            // shimmerHieght: 60.h,
            shimmerWidth: 200.h,
            shimmerHeight: 175.h,
            shimmerRadius: KSizes.borderRadiusMd),
      ],
    );
  }
}
