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
            width: KDeviceUtils.getScreenWidth(context),
            child: AlertDialog(
              backgroundColor: KColors.white,
              insetPadding: EdgeInsets.symmetric(horizontal: 30.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(KSizes.xs),
              ),
              title: Text(
                "Login Alert",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontSize: 18.sp),
                textAlign: TextAlign.left,
              ),
              // content: const Text("You need to login to add items to the cart."),
              content: Text(
                "Please log in to add items to your cart and continue shopping.",
                style: Theme.of(context).textTheme.titleSmall,
              ),

              actions: <Widget>[
                TextButton(
                  child: Text(
                    "CANCEL",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: KColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(
                    "LOGIN",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: KColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
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
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: SizedBox(
            // width: 400.w,
            width: KDeviceUtils.getScreenWidth(context),
            child: AlertDialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 30.w),
              backgroundColor: KColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(KSizes.xs),
              ),
              title: Text(
                'Exit?',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontSize: 18.sp),
                textAlign: TextAlign.left,
              ),
              content: SizedBox(
                  // width: 400.w,
                  width: KDeviceUtils.getScreenWidth(context),
                  child: Text(
                    'Are you sure you want to exit application?',
                    style: Theme.of(context).textTheme.titleSmall,
                    // textAlign: TextAlign.center,
                  )),
              actions: [
                TextButton(
                  child: Text(
                    "CANCEL",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: KColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                TextButton(
                  child: Text(
                    "YES",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: KColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  onPressed: () {
                    // Navigator.of(context).pop();

                    SystemNavigator.pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // static Future<bool> alertCloseApp(BuildContext context) async {
  //   return await showDialog(
  //         context: context,
  //         barrierDismissible: false,
  //         builder: (BuildContext context) {
  //           return PopScope(
  //             canPop: false,
  //             child: Dialog(
  //               backgroundColor: Colors.transparent,
  //               insetPadding: EdgeInsets.zero,
  //               child: Container(
  //                 width: double.infinity,
  //                 height: double.infinity,
  //                 color: Colors.black54,
  //                 child: Center(
  //                   child: Container(
  //                     width: KDeviceUtils.getScreenWidth(context) * 0.85,
  //                     padding: EdgeInsets.all(KSizes.defaultSpace),
  //                     decoration: BoxDecoration(
  //                       color: KColors.white,
  //                       borderRadius: BorderRadius.circular(KSizes.xs),
  //                     ),
  //                     child: Column(
  //                       mainAxisSize: MainAxisSize.min,
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           'Exit App',
  //                           style: Theme.of(context).textTheme.titleMedium,
  //                           textAlign: TextAlign.left,
  //                         ),
  //                         SizedBox(height: KSizes.spaceBtwItems),
  //                         Text(
  //                           'Are you sure you want to exit?',
  //                           style: Theme.of(context).textTheme.bodyLarge,
  //                           textAlign: TextAlign.center,
  //                         ),
  //                         SizedBox(height: KSizes.spaceBtwItems),
  //                         Row(
  //                           mainAxisAlignment: MainAxisAlignment.end,
  //                           children: [
  //                             TextButton(
  //                               child: Text(
  //                                 "CANCEL",
  //                                 style: Theme.of(context)
  //                                     .textTheme
  //                                     .bodyMedium!
  //                                     .copyWith(color: KColors.black),
  //                               ),
  //                               onPressed: () {
  //                                 Navigator.of(context).pop(false);
  //                               },
  //                             ),
  //                             TextButton(
  //                               child: Text(
  //                                 "EXIT",
  //                                 style: Theme.of(context)
  //                                     .textTheme
  //                                     .bodyMedium!
  //                                     .copyWith(color: KColors.primary),
  //                               ),
  //                               onPressed: () {
  //                                 SystemNavigator.pop();
  //                               },
  //                             ),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           );
  //         },
  //       ) ??
  //       false;
  // }

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
