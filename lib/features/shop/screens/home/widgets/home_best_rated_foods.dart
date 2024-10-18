import 'package:flutter/widgets.dart';
import 'package:chulesi/common/widgets/texts/section_title.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/features/shop/screens/home/widgets/best_rated_foods_list.dart';

class HomeBestRatedFoods extends StatelessWidget {
  const HomeBestRatedFoods({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          title: "Best Reviewed Foods",
          showButtonTitle: true,
          onPressed: () {
            Navigator.pushNamed(context, "/bestRatedFoods");
          },
        ),
        const SizedBox(height: KSizes.md),
        const BestRatedFoodsList(),
      ],
    );
  }
}
