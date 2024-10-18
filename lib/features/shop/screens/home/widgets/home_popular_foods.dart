import 'package:flutter/widgets.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/features/shop/screens/home/widgets/popular_foods_list.dart';

import '../../../../../common/widgets/texts/section_title.dart';

class HomePopularFoods extends StatelessWidget {
  const HomePopularFoods({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          title: "Popular Foods Nearby",
          showButtonTitle: true,
          onPressed: () {
            Navigator.pushNamed(context, "/allPopularFoods");
          },
        ),
        const SizedBox(height: KSizes.md),
        const PopularFoodsList(),
      ],
    );
  }
}
