import 'package:chulesi/features/shop/providers/slider_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chulesi/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/core/utils/constants/image_strings.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/core/utils/shimmers/full_shimmer.dart';
import 'package:chulesi/data/models/slider_model.dart';
import 'package:chulesi/features/shop/providers/home_provider.dart';
import 'package:chulesi/features/shop/screens/home/widgets/carousel_widget.dart';
import 'package:provider/provider.dart';

class HomePromoSlider extends StatelessWidget {
  const HomePromoSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // CacheManager customCacheManager = CacheManager(
    //   Config(
    //     'customCacheKey',
    //     stalePeriod: const Duration(days: 7), // Cache for 7 days
    //     maxNrOfCacheObjects: 100, // Maximum number of objects in the cache
    //   ),
    // );
    final promoSliderProvider = Provider.of<SliderProvider>(context);
    final homeProvider = Provider.of<HomeProvider>(context);
    return promoSliderProvider.isLoading
        ? const FullShimmer()
        : (promoSliderProvider.promoSliders != null &&
                promoSliderProvider.promoSliders!.isNotEmpty)
            ? Column(
                children: [
                  SizedBox(
                    height: 200.h,
                    child: CarouselWidget(
                      itemCount: promoSliderProvider.promoSliders!.length,
                      aspectRatio: 16 / 7,
                      viewportFraction: 0.8,
                      pageChanged: (index, _) {
                        homeProvider.updatePromoPageIndicator(index);
                      },
                      itemBuilder: (context, index, pageviewIndex) {
                        SliderModel slider =
                            promoSliderProvider.promoSliders![index];
                        // checkCache(slider.imageUrl);
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(KSizes.sm),
                          child: CachedNetworkImage(
                            imageUrl: slider.imageUrl,
                            // cacheKey: slider.id,
                            // cacheManager: MyCustomCacheManager.instance,
                            // cacheManager: customCacheManager,
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
                          i < promoSliderProvider.promoSliders!.length;
                          i++)
                        CircularContainer(
                          color: homeProvider.carouselPromoCurrentIndex == i
                              ? KColors.primary
                              : KColors.grey,
                          width: homeProvider.carouselPromoCurrentIndex == i
                              ? 11.w
                              : 7.w,
                          // height: 7.h,
                          height: homeProvider.carouselPromoCurrentIndex == i
                              ? 5.w
                              : 7.w,
                          margin: EdgeInsets.only(right: 5.w),
                        )
                    ],
                  ),
                ],
              )
            : const SizedBox();
  }
}
