import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';

import 'package:chulesi/core/utils/shimmers/shimmer_widget.dart';

class CatergoriesShimmer extends StatelessWidget {
  const CatergoriesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12),
      // height: 75.h,
      height: 115.h,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(right: KSizes.md),
              child: Column(
                children: [
                  ShimmerWidget(
                      shimmerWidth: 65.w,
                      shimmerHeight: 65.h,
                      shimmerRadius: KSizes.borderRadiusMd),
                  SizedBox(height: KSizes.sm),
                  ShimmerWidget(
                      shimmerWidth: 55.w,
                      shimmerHeight: 10.h,
                      shimmerRadius: KSizes.borderRadiusMd),
                ],
              ),
            );
          }),
    );
  }
}
