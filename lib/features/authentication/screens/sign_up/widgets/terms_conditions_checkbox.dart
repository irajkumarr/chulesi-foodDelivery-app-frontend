import 'package:chulesi/core/utils/http/url_launch.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/core/utils/constants/text_strings.dart';

class TermsConditionsCheckbox extends StatelessWidget {
  const TermsConditionsCheckbox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("By creating an account you are agreeing to our ",
            style: Theme.of(context).textTheme.bodySmall),
        Text.rich(TextSpan(children: [
          TextSpan(
              text: "${KTexts.privacyPolicy} ",
              recognizer: TapGestureRecognizer()
                ..onTap = () =>
                    UrlLaunch.launchUrl("https://chulesi.com/privacy-policy")
              //  Navigator.pushNamed(context, "/privacyPolicy")
              ,
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: KColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: KColors.primary,
                  )),
          TextSpan(
              text: "${KTexts.and} ",
              style: Theme.of(context).textTheme.bodySmall),
          TextSpan(
              text: KTexts.termsOfUse,
              recognizer: TapGestureRecognizer()
                ..onTap = () => UrlLaunch.launchUrl(
                    "https://chulesi.com/terms-and-condition"),
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: KColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: KColors.primary,
                  )),
        ]))
      ],
    );
  }
}
