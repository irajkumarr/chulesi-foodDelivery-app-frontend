
// import 'package:flutter/material.dart';

// import 'package:iconsax/iconsax.dart';

// import '../../../../core/utils/constants/sizes.dart';
// import '../../layouts/grid_layout.dart';
// import '../products_card/product_card_vertical.dart';

// class SortableProducts extends StatelessWidget {
//   const SortableProducts({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         //dropdown
//         DropdownButtonFormField(
//           decoration: InputDecoration(prefixIcon: Icon(Iconsax.sort)),
//           items: [
//             "Name",
//             "Higher Price",
//             "Lower Price",
//             "Sale",
//             "Newest",
//             "Popular"
//           ]
//               .map((option) =>
//                   DropdownMenuItem(value: option, child: Text(option)))
//               .toList(),
//           onChanged: (value) {},
//         ),
//         SizedBox(height: KSizes.spaceBtwSections),
//         GridLayout(
//             itemCount: 4,
//             itemBuilder: (_, index) {
//               return ProductCardVertical();
//             })
//       ],
//     );
//   }
// }
