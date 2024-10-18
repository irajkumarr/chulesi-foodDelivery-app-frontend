// import 'package:flutter/material.dart';

// import 'package:iconsax/iconsax.dart';

// import '../../../core/utils/constants/colors.dart';
// import '../../../core/utils/constants/sizes.dart';
// import '../../../core/utils/device/device_utility.dart';
// import '../products/carts/cart_counter_icon.dart';

// class Appbar extends StatelessWidget implements PreferredSizeWidget {
//   const Appbar(
//       {super.key,
//       required this.title,
//       this.subTitle,
//       this.showBackArrow = false,
//       this.leadingIcon,
//       this.actions,
//       this.leadingOnPressed,
//       this.bgColor});
//   final String title;
//   final String? subTitle;
//   final bool showBackArrow;
//   final IconData? leadingIcon;
//   final List<Widget>? actions;
//   final VoidCallback? leadingOnPressed;
//   final Color? bgColor;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding:  EdgeInsets.symmetric(horizontal: KSizes.md),
//       child: AppBar(
//         // automaticallyImplyLeading: false,
//         backgroundColor: bgColor,
//         leading: showBackArrow
//             ? IconButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 icon: Icon(
//                   Iconsax.arrow_left,
//                   color: KColors.black,
//                 ))
//             : IconButton(
//                 onPressed: () {},
//                 icon: Icon(
//                   Icons.person,
//                   color: KColors.white,
//                   size: KSizes.iconMd + 3,
//                 )),
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: Theme.of(context)
//                   .textTheme
//                   .titleMedium!
//                   .copyWith(fontWeight: FontWeight.w600, color: KColors.white),
//             ),
//             Text(
//               subTitle!,
//               style: Theme.of(context)
//                   .textTheme
//                   .bodySmall!
//                   .copyWith(color: KColors.white),
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//               onPressed: () {},
//               icon: Icon(
//                 Icons.search,
//                 color: KColors.white,
//                 size: KSizes.iconMd + 3,
//               )),
//           CartCounterIcon(onPressed: () {}),
//         ],
//       ),
//     );
//   }

//   @override
//   // TODO: implement preferredSize
//   Size get preferredSize => Size.fromHeight(KDeviceUtils.getAppBarHeight());
// }
