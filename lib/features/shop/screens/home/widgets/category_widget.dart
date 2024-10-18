import 'package:chulesi/core/utils/helpers/custom_cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chulesi/core/utils/constants/image_strings.dart';
import 'package:chulesi/data/models/categories_model.dart';
import 'package:chulesi/features/shop/providers/category_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/sizes.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.category,
  });

  final CategoriesModel category;

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    return GestureDetector(
      onTap: () {
        if (categoryProvider.categoryValue == category.id) {
          categoryProvider.updateCategory = '';
          categoryProvider.updateTitle = '';
        } else {
          categoryProvider.updateCategory = category.id;
          categoryProvider.updateTitle = category.title;
          Navigator.pushNamed(context, "/categoryFoodsScreen");
        }
      },
      child: Padding(
        padding: EdgeInsets.only(left: KSizes.sm),
        child: SizedBox(
          width: 75.w,
          // width: 55,

          // margin: EdgeInsets.only(right: KSizes.sm),
          // padding: EdgeInsets.only(right: 5, left: 5),
          child: Column(
            children: [
              Container(
                height: 70.h,
                width: 70.w,
                decoration: BoxDecoration(
                  color: KColors.white,
                  border: Border.all(color: KColors.buttonDisabled, width: 1.3),
                  borderRadius: BorderRadius.circular(KSizes.borderRadiusLg),

                  // image:DecorationImage(image: NetworkImage(category.imageUrl)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    imageUrl: category.imageUrl,
                    cacheKey: category.id,
                    cacheManager: MyCustomCacheManager.instance,
                    placeholder: (context, url) => SizedBox(
                        // height: 70.h,
                        // width: 70.w,
                        child: Image.asset(KImages.placeholder_default)),
                    errorWidget: (context, url, error) =>
                        Image.asset(KImages.placeholder_default),
                    fit: BoxFit.cover,
                    height: 70.h,
                    width: 70.w,
                  ),
                  //  Image.network(
                  //   category.imageUrl,
                  //   fit: BoxFit.cover,
                  //   height: 70.h,
                  //   width: 70.w,
                  // ),
                ),
              ),
              SizedBox(height: KSizes.sm),
              Text(
                category.title,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontWeight: FontWeight.w600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
