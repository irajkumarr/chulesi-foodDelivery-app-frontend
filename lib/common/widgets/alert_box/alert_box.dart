import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/device/device_utility.dart';

class CustomAlertBox {
//login alert
  static Future<void> loginAlert(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SizedBox(
            width: 400.w,
            child: AlertDialog(
              backgroundColor: KColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(KSizes.xs),
              ),
              title: const Text("Login Alert"),
              // content: const Text("You need to login to add items to the cart."),
              content: const Text(
                "Please log in to add items to your cart and continue shopping.",
              ),

              actions: <Widget>[
                TextButton(
                  child: const Text("CANCEL"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text("LOGIN"),
                  onPressed: () {
                    // Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed("/login");
                  },
                ),
              ],
            ),
          );
        });
  }

//alert close app

  static Future<bool> alertCloseApp(BuildContext context) async {
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

  static showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = SizedBox(
      width: 110,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          side: BorderSide.none,
          backgroundColor: Colors.transparent,
          foregroundColor: KColors.black,
        ),
        onPressed: () => Navigator.pop(context),
        child: const Text("Cancel"),
      ),
    );
    Widget confirmButton = SizedBox(
      width: 110,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: KColors.primary,
          foregroundColor: Colors.white,
        ),
        onPressed: () {},
        child: const Text("Confirm"),
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      title: const Center(child: Text("Logout")),
      content: const SizedBox(
          width: 400, child: Text("Are you sure you want to logout?")),
      actions: [
        cancelButton,
        confirmButton,
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static Future<void> showAlert(
      BuildContext context, String subTitle, VoidCallback onPressed) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: 400.w,
          child: AlertDialog(
            backgroundColor: KColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(KSizes.xs),
            ),
            // title: Text(title),
            content: SizedBox(
                width: 400.w,
                child: Text(
                  subTitle,
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
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                  "OK",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: KColors.primary),
                ),
                onPressed: () {
                  // Navigator.of(context).pop();

                  onPressed();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
