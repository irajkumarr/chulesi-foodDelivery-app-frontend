import 'package:flutter/material.dart';

import '../../../core/utils/constants/colors.dart';


class SettingsMenuTile extends StatelessWidget {
  const SettingsMenuTile(
      {super.key,
      required this.icon,
      this.trailing,
      required this.title,
      required this.subTitle,
      this.onTap});
  final IconData icon;
  final Widget? trailing;
  final String title;
  final String subTitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: KColors.primary,
        size: 28,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      subtitle: Text(
        subTitle,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      trailing: trailing,
    );
  }
}
