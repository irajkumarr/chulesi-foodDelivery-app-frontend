import 'package:chulesi/features/shop/providers/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:chulesi/common/widgets/layouts/grid_layout.dart';
import 'package:chulesi/common/widgets/texts/section_title.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/core/utils/shimmers/categories_shimmer.dart';
import 'package:chulesi/data/models/categories_model.dart';
import 'package:chulesi/features/shop/screens/home/widgets/category_widget.dart';
import 'package:provider/provider.dart';

class ExploreCategoryScreen extends StatelessWidget {
  const ExploreCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: "Explore More Categories",
          showButtonTitle: true,
          onPressed: () {
            Navigator.pushNamed(context, "/category");
          },
        ),
        const SizedBox(height: KSizes.md),
        categoryProvider.isLoading
            ? const CatergoriesShimmer()
            : Container(
                child: GridLayout(
                  itemCount: categoryProvider.allCategories!.length,
                  itemBuilder: (context, index) {
                    CategoriesModel category =
                        categoryProvider.allCategories![index];
                    return CategoryWidget(category: category);
                  },
                ),
              ),
      ],
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:chulesi/common/widgets/layouts/grid_layout.dart';
// import 'package:chulesi/common/widgets/texts/section_title.dart';
// import 'package:chulesi/core/utils/constants/sizes.dart';
// import 'package:chulesi/core/utils/shimmers/categories_shimmer.dart';
// import 'package:chulesi/data/hooks/fetch_all_categories.dart';
// import 'package:chulesi/data/models/categories_model.dart';
// import 'package:chulesi/features/shop/screens/home/widgets/category_widget.dart';

// class ExploreCategoryScreen extends HookWidget {
//   const ExploreCategoryScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final hookResult = useFetchAllCategories();
//     List<CategoriesModel>? categoriesList = hookResult.data ?? [];
//     final isLoading = hookResult.isLoading;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SectionTitle(
//           title: "Explore More Categories",
//           showButtonTitle: true,
//           onPressed: () {
//             Navigator.pushNamed(context, "/category");
//           },
//         ),
//         const SizedBox(height: KSizes.md),
//         isLoading
//             ? const CatergoriesShimmer()
//             : Container(
//                 child: GridLayout(
//                   itemCount: categoriesList.length,
//                   itemBuilder: (context, index) {
//                     CategoriesModel category = categoriesList[index];
//                     return CategoryWidget(category: category);
//                   },
//                 ),
//               ),
//       ],
//     );
//   }
// }
