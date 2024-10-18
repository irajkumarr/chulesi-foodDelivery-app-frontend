import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/core/utils/constants/image_strings.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';

void showToast(String text) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    // toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.black.withOpacity(0.6),

    // backgroundColor: Colors.white,
    textColor: Colors.white,
    // textColor: Colors.black,
  );
}

// void showCustomToast(BuildContext context, String text) {
//   FToast fToast = FToast();
//   fToast.init(context);

//   // Calculate the available height considering the keyboard
//   final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

//   Widget toast = Container(
//     width: 225.w,
//     padding: EdgeInsets.symmetric(horizontal: KSizes.sm, vertical: 6),
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(5),
//       color: Colors.black.withOpacity(0.6),
//     ),
//     child: Row(
//       mainAxisSize: MainAxisSize.max,
//       children: [
//         SizedBox(height: 30, width: 30, child: Image.asset(KImages.logoOnly)),
//         SizedBox(width: KSizes.xs),
//         Expanded(
//           child: Text(
//             text,
//             overflow: TextOverflow.ellipsis,
//             maxLines: 1,
//             style: Theme.of(context)
//                 .textTheme
//                 .labelLarge!
//                 .copyWith(color: KColors.white, fontWeight: FontWeight.w600),
//           ),
//         ),
//       ],
//     ),
//   );

//   fToast.showToast(
//     child: toast,
//     toastDuration: const Duration(seconds: 3),
//     gravity: ToastGravity.BOTTOM,
//     positionedToastBuilder: (context, child) {
//       return Positioned(
//         bottom: bottomPadding > 0
//             ? bottomPadding + 16.0
//             : 16.0, // Add padding above the keyboard if it's open
//         left: 16.0,
//         right: 16.0,
//         child: child,
//       );
//     },
//     // fadeDuration: Duration(seconds: 1),
//   );
// }


void showCustomToast(BuildContext context, String text) {
  FToast fToast = FToast();
  fToast.init(context);

  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.black.withOpacity(0.8),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14.0,
      ),
    ),
  );

  fToast.showToast(
    child: toast,
    toastDuration: const Duration(seconds: 2),
    gravity: ToastGravity.BOTTOM,
    positionedToastBuilder: (context, child) {
      return Positioned(
        bottom: 50.0,
        left: 16.0,
        right: 16.0,
        child: child,
      );
    },
  );
}
