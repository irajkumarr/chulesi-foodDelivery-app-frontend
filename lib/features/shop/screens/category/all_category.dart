import 'package:chulesi/features/shop/providers/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chulesi/common/widgets/layouts/grid_layout.dart';
import 'package:chulesi/core/network/connectivity_checker.dart';
import 'package:chulesi/core/utils/constants/colors.dart';

import 'package:chulesi/features/shop/screens/category/widgets/category_tile.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/constants/sizes.dart';
import '../../../../core/utils/shimmers/categories_vertical_shimmer.dart';
import '../../../../data/models/categories_model.dart';

class AllCategoryScreen extends StatelessWidget {
  const AllCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    return ConnectivityChecker(
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Categories",
              style: TextStyle(color: KColors.white),
            ),
            centerTitle: true,
            backgroundColor: KColors.primary,
            elevation: 4,
            automaticallyImplyLeading: false,
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: KSizes.md, right: KSizes.md),
            child: categoryProvider.isLoading
                ? const Padding(
                    padding: EdgeInsets.only(top: KSizes.md),
                    child: CategoriesVerticalShimmer(),
                  )
                : SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.only(top: KSizes.md),
                      child: GridLayout(
                          itemCount: categoryProvider.allCategories!.length,
                          mainAxisExtent: 120.w,
                          itemBuilder: (context, index) {
                            CategoriesModel category =
                                categoryProvider.allCategories![index];
                            return CategoryTile(category: category);
                          }),
                    ),
                  ),
          )),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:chulesi/common/widgets/layouts/grid_layout.dart';
// import 'package:chulesi/core/network/connectivity_checker.dart';
// import 'package:chulesi/core/utils/constants/colors.dart';

// import 'package:chulesi/features/shop/screens/category/widgets/category_tile.dart';

// import '../../../../core/utils/constants/sizes.dart';
// import '../../../../core/utils/shimmers/categories_vertical_shimmer.dart';
// import '../../../../data/hooks/fetch_all_categories.dart';
// import '../../../../data/models/categories_model.dart';

// class AllCategoryScreen extends HookWidget {
//   const AllCategoryScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final hookResult = useFetchAllCategories();
//     List<CategoriesModel>? categoriesList = hookResult.data;
//     final isLoading = hookResult.isLoading;
//     return ConnectivityChecker(
//       child: Scaffold(
//           appBar: AppBar(
//             title: const Text(
//               "Categories",
//               style: TextStyle(color: KColors.white),
//             ),
//             centerTitle: true,
//             backgroundColor: KColors.primary,
//             elevation: 4,
//             // automaticallyImplyLeading: false,
//           ),
//           body: Padding(
//             padding: const EdgeInsets.only(left: KSizes.md, right: KSizes.md),
//             child: isLoading
//                 ? const Padding(
//                     padding: EdgeInsets.only(top: KSizes.md),
//                     child: CategoriesVerticalShimmer(),
//                   )
//                 : SingleChildScrollView(
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: KSizes.md),
//                       child: GridLayout(
//                           itemCount: categoriesList!.length,
//                           mainAxisExtent: 120.w,
//                           itemBuilder: (context, index) {
//                             CategoriesModel category = categoriesList[index];
//                             return CategoryTile(category: category);
//                           }),
//                     ),
//                   ),
//           )),
//     );
//   }
// }
