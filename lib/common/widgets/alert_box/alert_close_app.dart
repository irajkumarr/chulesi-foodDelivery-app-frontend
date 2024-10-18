import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/constants/sizes.dart';
import '../../../core/utils/device/device_utility.dart';

Future<bool> alertCloseApp(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        // width: 400.w,
        width: KDeviceUtils.getScreenWidth(context),
        child: AlertDialog(
          backgroundColor: KColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(KSizes.xs),
          ),
          // title: Text(title),
          content: SizedBox(
              // width: 400.w,
              width: KDeviceUtils.getScreenWidth(context),
              child: Text(
                'Are you sure you want to exit?',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              )),
          actions: [
            TextButton(
              child: Text(
                "CANCEL",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: KColors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text(
                "EXIT",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: KColors.primary),
              ),
              onPressed: () {
                // Navigator.of(context).pop();

                SystemNavigator.pop();
              },
            ),
          ],
        ),
      );
    },
  );
}
