// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:chulesi/core/utils/shimmers/categories_shimmer.dart';
// import 'package:chulesi/data/hooks/fetch_categories.dart';
// import 'package:chulesi/data/models/categories_model.dart';
// import 'package:chulesi/features/shop/screens/home/widgets/category_widget.dart';
// import 'package:provider/provider.dart';

// import '../../../../../common/widgets/texts/section_title.dart';
// import '../../../../../core/utils/constants/sizes.dart';
// import '../../../providers/category_provider.dart';

// class CategoryList extends HookWidget {
//   const CategoryList({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final hookResult = useFetchCategories();
//     List<CategoriesModel>? categoriesList = hookResult.data;
//     final isLoading = hookResult.isLoading;

//     // if (categoriesList == null || categoriesList.isEmpty) {
//     //   return Center(child: Text('No categories available.'));
//     // }
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SectionTitle(
//           title: "Shop By Categories",
//           showButtonTitle: true,
//           onPressed: () {
//             Navigator.pushNamed(context, "/category");
//           },
//         ),
//         const SizedBox(height: KSizes.md),
//         isLoading
//             ? const CatergoriesShimmer()
//             : SizedBox(
//                 height: 115.h,
//                 child: ListView(
//                   physics: const BouncingScrollPhysics(),
//                   scrollDirection: Axis.horizontal,
//                   children: List.generate(categoriesList!.length, (index) {
//                     CategoriesModel category = categoriesList[index];
//                     return CategoryWidget(category: category);
//                   }),
//                 ))
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chulesi/core/utils/shimmers/categories_shimmer.dart';
import 'package:chulesi/data/models/categories_model.dart';
import 'package:chulesi/features/shop/screens/home/widgets/category_widget.dart';
import 'package:provider/provider.dart';

import '../../../../../common/widgets/texts/section_title.dart';
import '../../../../../core/utils/constants/sizes.dart';
import '../../../providers/category_provider.dart';

// class CategoryList extends StatelessWidget {
//   const CategoryList({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final categoryProvider = Provider.of<CategoryProvider>(context);
//     // if (categoriesList == null || categoriesList.isEmpty) {
//     //   return Center(child: Text('No categories available.'));
//     // }
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SectionTitle(
//           title: "Shop By Categories",
//           showButtonTitle: true,
//           onPressed: () {
//             Navigator.pushNamed(context, "/category");
//           },
//         ),
//         const SizedBox(height: KSizes.md),
//         categoryProvider.isLoading
//             ? const CatergoriesShimmer()
//             : categoryProvider.error != null
//                 ? Center(child: Text(categoryProvider.error!))
//                 : SizedBox(
//                     height: 115.h,
//                     child: ListView(
//                       physics: const BouncingScrollPhysics(),
//                       scrollDirection: Axis.horizontal,
//                       children: List.generate(
//                           categoryProvider.categories!.length, (index) {
//                         CategoriesModel category =
//                             categoryProvider.categories![index];
//                         return CategoryWidget(category: category);
//                       }),
//                     ))
//       ],
//     );
//   }
// }
class CategoryList extends StatelessWidget {
  const CategoryList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    // print('isLoading: ${categoryProvider.isLoading}');
    // print('Error: ${categoryProvider.error}');
    // print('Categories: ${categoryProvider.categories?.length}');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: "Shop By Categories",
          showButtonTitle: true,
          onPressed: () {
            Navigator.pushNamed(context, "/category");
          },
        ),
        const SizedBox(height: KSizes.md),
        // Show shimmer loading state if still loading
        categoryProvider.isLoading
            ? const CatergoriesShimmer()

            // Show error message if an error occurred
            : categoryProvider.error != null
                ? Center(child: Text(categoryProvider.error!))

                // Check if categories are not null and not empty
                : categoryProvider.categories != null &&
                        categoryProvider.categories!.isNotEmpty
                    ? SizedBox(
                        height: 115.h,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: categoryProvider.categories!.length,
                          itemBuilder: (context, index) {
                            final CategoriesModel category =
                                categoryProvider.categories![index];
                            return CategoryWidget(category: category);
                          },
                        ),
                      )

                    // Show message when no categories are available
                    : const CatergoriesShimmer()
      ],
    );
  }
}
