import 'package:flutter/material.dart';

import 'package:iconsax/iconsax.dart';

import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/constants/image_strings.dart';
import '../images_widget/roundedimage.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({
    super.key, this.onPressed,
  });
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading:  const RoundedImage(
          imageUrl: KImages.user,
          width: 50,
          height: 50,
          padding: EdgeInsets.all(0),
        ),
        title: Text(
          "Raj Kumar Timalsina",
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: KColors.white),
        ),
        subtitle: Text(
          "admin@gmail.com",
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .apply(color: KColors.white),
        ),
        trailing: IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Iconsax.edit,
              color: KColors.white,
            )));
  }
}
