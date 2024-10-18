import 'package:chulesi/core/utils/helpers/custom_cache_manager.dart';
import 'package:chulesi/features/shop/providers/slider_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chulesi/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:chulesi/core/utils/circular_progress_indicator/circlular_indicator.dart';
import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/core/utils/constants/image_strings.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/core/utils/shimmers/full_shimmer.dart';
import 'package:chulesi/data/models/slider_model.dart';
import 'package:chulesi/features/shop/providers/home_provider.dart';
import 'package:chulesi/features/shop/screens/home/widgets/carousel_widget.dart';
import 'package:provider/provider.dart';

class HomeOfferSlider extends StatelessWidget {
  const HomeOfferSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    // final hookResult = useFetchAllOfferSlider();
    // List<SliderModel>? sliderList = hookResult.data;
    // final isLoading = hookResult.isLoading;
    final offerSliderProvider = Provider.of<SliderProvider>(context);
    return offerSliderProvider.isLoading
        ? const FullShimmer()
        : (offerSliderProvider.offerSliders != null &&
                offerSliderProvider.offerSliders!.isNotEmpty)
            ? Column(
                children: [
                  SizedBox(
                    height: 200.h,
                    child: CarouselWidget(
                      itemCount: offerSliderProvider.offerSliders!.length,
                      aspectRatio: 16 / 7,
                      viewportFraction: 0.8,
                      pageChanged: (index, _) {
                        homeProvider.updatePageIndicator(index);
                      },
                      itemBuilder: (context, index, pageviewIndex) {
                        SliderModel slider =
                            offerSliderProvider.offerSliders![index];
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(KSizes.sm),
                          child: CachedNetworkImage(
                            imageUrl: slider.imageUrl,
                            cacheKey: slider.id,
                            cacheManager: MyCustomCacheManager.instance,
                            placeholder: (context, url) => SizedBox(
                                height: 175.h,
                                width: double.infinity,
                                child: Image.asset(
                                  KImages.banner_placeholder,
                                  fit: BoxFit.cover,
                                )),
                            errorWidget: (context, url, error) =>
                                Image.asset(KImages.banner_placeholder),
                            fit: BoxFit.cover,
                            // height: 175.h,
                            width: double.infinity,
                          ),
                        );
                      },
                    ),
                  ),
                  // SizedBox(height: KSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0;
                          i < offerSliderProvider.offerSliders!.length;
                          i++)
                        CircularContainer(
                          color: homeProvider.carouselCurrentIndex == i
                              ? KColors.primary
                              : KColors.grey,
                          width: 7,
                          height: 7,
                          margin: EdgeInsets.only(right: 10.w),
                        )
                    ],
                  ),
                ],
              )
            : Center(
                child: KIndicator.circularIndicator(),
              );
  }
}

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:chulesi/common/widgets/custom_shapes/container/circular_container.dart';
// import 'package:chulesi/core/utils/circular_progress_indicator/circlular_indicator.dart';
// import 'package:chulesi/core/utils/constants/colors.dart';
// import 'package:chulesi/core/utils/constants/image_strings.dart';
// import 'package:chulesi/core/utils/constants/sizes.dart';
// import 'package:chulesi/core/utils/shimmers/full_shimmer.dart';
// import 'package:chulesi/data/models/slider_model.dart';
// import 'package:chulesi/features/shop/providers/home_provider.dart';
// import 'package:chulesi/features/shop/screens/home/widgets/carousel_widget.dart';
// import 'package:provider/provider.dart';

// import '../../../../../data/hooks/fetch_all_offer_slider.dart';

// class HomeOfferSlider extends HookWidget {
//   const HomeOfferSlider({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final homeProvider = Provider.of<HomeProvider>(context);
//     final hookResult = useFetchAllOfferSlider();
//     List<SliderModel>? sliderList = hookResult.data;
//     final isLoading = hookResult.isLoading;
//     return isLoading
//         ? const FullShimmer()
//         : (sliderList != null && sliderList.isNotEmpty)
//             ? Column(
//                 children: [
//                   SizedBox(
//                     height: 200.h,
//                     child: CarouselWidget(
//                       itemCount: sliderList.length,
//                       aspectRatio: 16 / 7,
//                       viewportFraction: 0.8,
//                       pageChanged: (index, _) {
//                         homeProvider.updatePageIndicator(index);
//                       },
//                       itemBuilder: (context, index, pageviewIndex) {
//                         SliderModel slider = sliderList[index];
//                         return ClipRRect(
//                           borderRadius: BorderRadius.circular(KSizes.sm),
//                           child: CachedNetworkImage(
//                             imageUrl: slider.imageUrl,
//                             placeholder: (context, url) => SizedBox(
//                                 height: 175.h,
//                                 width: double.infinity,
//                                 child: Image.asset(
//                                   KImages.banner_placeholder,
//                                   fit: BoxFit.cover,
//                                 )),
//                             errorWidget: (context, url, error) =>
//                                 Image.asset(KImages.banner_placeholder),
//                             fit: BoxFit.cover,
//                             // height: 175.h,
//                             width: double.infinity,
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   // SizedBox(height: KSizes.spaceBtwItems),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       for (int i = 0; i < sliderList.length; i++)
//                         CircularContainer(
//                           color: homeProvider.carouselCurrentIndex == i
//                               ? KColors.primary
//                               : KColors.grey,
//                           width: 7,
//                           height: 7,
//                           margin: EdgeInsets.only(right: 10.w),
//                         )
//                     ],
//                   ),
//                 ],
//               )
//             : Center(
//                 child: KIndicator.circularIndicator(),
//               );
//   }
// }
