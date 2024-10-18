import 'package:flutter/material.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';

import 'package:chulesi/core/utils/shimmers/shimmer_widget.dart';

import '../device/device_utility.dart';

class CategoriesVerticalShimmer extends StatelessWidget {
  const CategoriesVerticalShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:  EdgeInsets.only(left: KSizes.sm),
        // height: 190.h,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GridView.builder(
            itemCount: 10,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: KSizes.gridViewSpacing,
              crossAxisSpacing: KSizes.gridViewSpacing,
              mainAxisExtent: 120,
            ),
            itemBuilder: (context, index) {
              return ShimmerWidget(
                  shimmerWidth: KDeviceUtils.getScreenWidth(context),
                  // shimmerHieght: 180.h,
                  // shimmerHeight: 270,
                  shimmerHeight: 170,
                  shimmerRadius: KSizes.md);
            })
        //  ListView.builder(
        //     scrollDirection: Axis.vertical,
        //     itemCount: 6,
        //     itemBuilder: (context, index) {
        //       return Column(
        //         children: [
        //           ShimmerWidget(
        //               shimmerWidth: KDeviceUtils.getScreenWidth(context) * 0.55,
        //               // shimmerHieght: 180.h,
        //               // shimmerHeight: 270,
        //               shimmerHeight: 170,
        //               shimmerRadius: KSizes.md),
        //           const SizedBox(height: KSizes.spaceBtwItems / 2),
        //           ShimmerWidget(
        //               shimmerWidth: 150,
        //               shimmerHeight: 17,
        //               shimmerRadius: KSizes.md),
        //           const SizedBox(height: KSizes.spaceBtwItems / 2),
        //           ShimmerWidget(
        //               shimmerWidth: 130,
        //               shimmerHeight: 17,
        //               shimmerRadius: KSizes.md),
        //           const SizedBox(height: KSizes.spaceBtwItems / 2),
        //           ShimmerWidget(
        //               shimmerWidth: 100,
        //               shimmerHeight: 17,
        //               shimmerRadius: KSizes.md),
        //         ],
        //       );
        //     }),
        );
  }
}
