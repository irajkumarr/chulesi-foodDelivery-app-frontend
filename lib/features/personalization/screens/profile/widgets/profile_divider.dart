import 'package:flutter/material.dart';
import 'package:chulesi/core/utils/constants/colors.dart';

class ProfileDivider extends StatelessWidget {
  const ProfileDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: KColors.grey,
      thickness: 1,
    );
  }
}
