import 'package:flutter/material.dart';


import '../constants/colors.dart';
import 'animation_loader.dart';

class KFullScreenLoader {
  //opens the loading dialog
  static void openLoadingDialog(
      BuildContext context, String text, String animation) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => PopScope(
            canPop: false,
            child: Container(
              color:  KColors.white,
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 250),
                  KAnimationLoaderWidget(text: text, animation: animation),
                ],
              ),
            )));
  }

//close the dialog
  static stopLoading(BuildContext context) {
    Navigator.of(context).pop();
  }
}
