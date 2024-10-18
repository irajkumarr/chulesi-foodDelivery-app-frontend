import 'package:flutter/widgets.dart';
import 'package:chulesi/common/widgets/texts/section_title.dart';
import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';

import 'package:chulesi/features/shop/screens/home/widgets/food_offers_list.dart';

class HomeFoodOffers extends StatelessWidget {
  const HomeFoodOffers({
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
            title: "Deals and Offers",
            showButtonTitle: true,
            onPressed: () {
              Navigator.pushNamed(context, "/dealsAndOffers");
            },
          ),
          const SizedBox(height: KSizes.md),
          const FoodOffersList(),
        ],
      ),
    );
  }
}
