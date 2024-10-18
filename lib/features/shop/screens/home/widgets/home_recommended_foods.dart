import 'package:flutter/widgets.dart';
import 'package:chulesi/common/widgets/texts/section_title.dart';
import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/core/utils/constants/text_strings.dart';
import 'package:chulesi/features/shop/screens/home/widgets/new_foods_list.dart';

class HomeRecommendedFoods extends StatelessWidget {
  const HomeRecommendedFoods({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: KSizes.sm, bottom: KSizes.sm),
      decoration: BoxDecoration(color: KColors.secondary.withOpacity(0.3)),
      child: Column(
        children: [
          SectionTitle(
            title: "New on ${KTexts.appName}",
            showButtonTitle: true,
            textColor: KColors.primary,
            onPressed: () {
              Navigator.pushNamed(context, "/recommendedFoods");
            },
          ),
          const SizedBox(height: KSizes.md),
          const NewFoodsList(),
        ],
      ),
    );
  }
}
