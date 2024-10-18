import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';

import 'package:chulesi/core/utils/shimmers/shimmer_widget.dart';

class FullScreenShimmer extends StatelessWidget {
  const FullScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        // padding: EdgeInsets.zero,
        // height: 75.h,
        // margin: EdgeInsets.only(right: KSizes.md),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            ShimmerWidget(
                // shimmerWidth: 70.w,
                // shimmerHieght: 60.h,

                shimmerWidth: MediaQuery.of(context).size.width,
                shimmerHeight: 175.h,
                shimmerRadius: KSizes.borderRadiusMd),
            Container(
              padding: const EdgeInsets.only(left: KSizes.md),
              // height: 190.h,
              height: 270.h,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShimmerWidget(
                            // shimmerWidth: KDeviceUtils.getScreenWidth(context) * 0.55,
                            // shimmerHieght: 180.h,
                            // shimmerHeight: 270,
                            shimmerWidth: 180.w,
                            // shimmerHeight: 170,
                            shimmerHeight: 180.h,
                            shimmerRadius: KSizes.md),
                        SizedBox(height: KSizes.spaceBtwItems / 2),
                        ShimmerWidget(
                            shimmerWidth: 140.w,
                            shimmerHeight: 30.h,
                            shimmerRadius: KSizes.md),
                        SizedBox(height: KSizes.spaceBtwItems / 2),
                        ShimmerWidget(
                            shimmerWidth: 60.w,
                            shimmerHeight: 30.h,
                            shimmerRadius: KSizes.md),
                        //  SizedBox(height: KSizes.spaceBtwItems / 2),
                        // ShimmerWidget(
                        //     shimmerWidth: 100,
                        //     shimmerHeight: 25,
                        //     shimmerRadius: KSizes.md),
                      ],
                    );
                  }),
            ),
            SizedBox(
              // padding: const EdgeInsets.only(left: 12, top: 10),
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  // padding: EdgeInsets.only(bottom: KSizes.defaultSpace),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ShimmerWidget(
                            shimmerWidth: 100,
                            // shimmerHieght: 70.h,
                            shimmerHeight: 100,
                            shimmerRadius: KSizes.md),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: KSizes.sm),
                            const ShimmerWidget(
                                shimmerWidth: 200,
                                // shimmerHieght: 70.h,
                                shimmerHeight: 25,
                                shimmerRadius: KSizes.md),
                            SizedBox(height: KSizes.sm),
                            const ShimmerWidget(
                                shimmerWidth: 100,
                                // shimmerHieght: 70.h,
                                shimmerHeight: 25,
                                shimmerRadius: KSizes.md),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: KSizes.sm),
                            const ShimmerWidget(
                                shimmerWidth: 50,
                                // shimmerHieght: 70.h,
                                shimmerHeight: 25,
                                shimmerRadius: KSizes.md),
                            SizedBox(height: KSizes.sm),
                            const ShimmerWidget(
                                shimmerWidth: 50,
                                // shimmerHieght: 70.h,
                                shimmerHeight: 25,
                                shimmerRadius: KSizes.md),
                          ],
                        ),
                        // ShimmerWidget(
                        //     shimmerWidth: MediaQuery.of(context).size.width,
                        //     // shimmerHieght: 70.h,
                        //     shimmerHeight: 125,
                        //     shimmerRadius: KSizes.md),
                      ],
                    );
                  }),
            )
          ],
        ));
  }
}
