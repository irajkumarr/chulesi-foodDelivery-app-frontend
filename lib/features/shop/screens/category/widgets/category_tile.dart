import 'package:chulesi/core/utils/helpers/custom_cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chulesi/core/utils/constants/image_strings.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/sizes.dart';
import '../../../../../data/models/categories_model.dart';
import '../../../providers/category_provider.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({
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
      child: Container(
          padding: const EdgeInsets.all(KSizes.md),
          decoration: BoxDecoration(
            color: KColors.white,
            borderRadius: BorderRadius.circular(KSizes.sm),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(0, 1),
                blurRadius: 2,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(KSizes.sm),
                child: Container(
                  height: 60.h,
                  width: 60.w,
                  decoration: BoxDecoration(
                    color: KColors.white,
                    borderRadius: BorderRadius.circular(KSizes.borderRadiusMd),
                    // image:
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(KSizes.sm),
                    child: CachedNetworkImage(
                      imageUrl: category.imageUrl,
                      cacheKey: category.id,
                      cacheManager: MyCustomCacheManager.instance,
                      placeholder: (context, url) => SizedBox(
                          height: 60.h,
                          width: 60.w,
                          child: Image.asset(
                            KImages.placeholder_default,
                            fit: BoxFit.cover,
                          )),
                      errorWidget: (context, url, error) =>
                          Image.asset(KImages.placeholder_default),
                      fit: BoxFit.cover,
                    ),
                  ),
                  //  DecorationImage(
                  //   image: NetworkImage(category.imageUrl),
                  //   fit: BoxFit.cover,
                  //   // image: AssetImage(KImages.category),
                  //   // fit: BoxFit.cover,
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
          )),
    );
  }
}
