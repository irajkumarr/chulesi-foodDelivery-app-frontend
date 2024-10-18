import 'package:flutter/material.dart';

import 'package:chulesi/core/utils/constants/text_strings.dart';

class SignupHeader extends StatelessWidget {
  const SignupHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      KTexts.signupTitle,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}