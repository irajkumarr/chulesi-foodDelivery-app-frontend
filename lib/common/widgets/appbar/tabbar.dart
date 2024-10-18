import 'package:flutter/material.dart';


import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/device/device_utility.dart';
import '../../../core/utils/helpers/helper_functions.dart';

class Tabbar extends StatelessWidget implements PreferredSizeWidget {
  const Tabbar({super.key, required this.tabs});
  final List<Widget> tabs;
  @override
  Widget build(BuildContext context) {
    final dark = KHelperFunctions.isDarkMode(context);
    return Material(
      color: dark ? KColors.black : KColors.white,
      child: TabBar(
        tabs: tabs,
        isScrollable: true,
        
        padding: const EdgeInsets.symmetric(horizontal: 0),
        indicatorColor: KColors.primary,
        labelColor: dark ? KColors.white : KColors.primary,
        unselectedLabelColor: KColors.darkGrey,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(KDeviceUtils.getAppBarHeight());
}
