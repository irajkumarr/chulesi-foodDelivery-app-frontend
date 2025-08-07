import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:chulesi/common/widgets/products/carts/cart_counter_icon.dart';
import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/features/personalization/providers/map_provider.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<MapProvider>(context);

    return AppBar(
      // titleSpacing: 0,
      backgroundColor: KColors.primary,
      // leading: IconButton(
      //   onPressed: () {
      //     Navigator.pushNamed(context, "/account");
      //   },
      //   icon: Icon(
      //     MaterialCommunityIcons.account,
      //     color: KColors.white,
      //     size: KSizes.iconMd + 3,
      //   ),
      // ),
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Location",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: KColors.white,
                  ),
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: KColors.white,
                  size: KSizes.iconSm,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    // mapProvider.address ?? "Locating your address..",
                    "Hetauda, Nepal",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: KColors.white,
                          fontStyle: FontStyle.normal,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // if (mapProvider.address == null)
                //   SizedBox(
                //     width: 8,
                //     height: 8,
                //     child: CircularProgressIndicator(
                //       strokeWidth: 1,
                //       color: KColors.white,
                //     ),
                //   ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          tooltip: "Search",
          onPressed: () {
            Navigator.pushNamed(context, "/search");
          },
          icon: Icon(
            AntDesign.search1,
            color: KColors.white,
            size: KSizes.iconMd,
          ),
        ),
        const CartCounterIcon(),
      ],
    );
  }
}
