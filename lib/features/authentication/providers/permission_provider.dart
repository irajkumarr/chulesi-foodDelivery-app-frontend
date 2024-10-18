// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';

// class PermissionProvider extends ChangeNotifier {
//   bool _isLocationGranted = false;
//   bool _isNotificationGranted = false;
//   bool _permissionsChecked = false;

//   bool get isLocationGranted => _isLocationGranted;
//   bool get isNotificationGranted => _isNotificationGranted;
//   bool get permissionsChecked => _permissionsChecked;

//   Future<void> checkAndRequestPermissions(BuildContext context) async {
//     if (_permissionsChecked) return;

//     // Request Location Permission
//     _isLocationGranted = await _requestPermission(
//       context,
//       Permission.location,
//       "Location Permission",
//       "Location access is required for finding rides near you.",
//     );

//     // Request Notification Permission only if location permission is granted
//     if (_isLocationGranted) {
//       _isNotificationGranted = await _requestPermission(
//         context,
//         Permission.notification,
//         "Notification Permission",
//         "We need notifications to alert you about ride updates.",
//       );
//       notifyListeners();
//     }
//     // _isNotificationGranted = await _requestPermission(
//     //   context,
//     //   Permission.notification,
//     //   "Notification Permission",
//     //   "We need notifications to alert you about ride updates.",
//     // );
//     // Update permissions checked flag and notify listeners
//     _permissionsChecked = true;
//     notifyListeners(); // Notify listeners to recheck navigation
//   }

//   Future<bool> _requestPermission(BuildContext context, Permission permission,
//       String title, String message) async {
//     PermissionStatus status = await permission.status;

//     if (status.isDenied) {
//       bool shouldShowRationale = await permission.shouldShowRequestRationale;
//       if (shouldShowRationale) {
//         // Show rationale dialog and request permission again
//         bool granted = await _showPermissionRationaleDialog(
//             context, permission, title, message);
//         if (granted) {
//           status = await permission.request();
//           if (status.isGranted) {
//             _updatePermissionStatus(permission, true);
//             return true;
//           } else if (status.isPermanentlyDenied) {
//             await _showPermanentlyDeniedDialog(context);
//             return false;
//           } else {
//             // Retry if permission is denied but not permanently
//             await _showPermissionDeniedDialog(
//                 context, permission, title, message);
//             return false;
//           }
//         } else {
//           await _showPermissionDeniedDialog(
//               context, permission, title, message);
//           return false;
//         }
//       } else {
//         // Directly request permission without rationale
//         status = await permission.request();
//         if (status.isGranted) {
//           _updatePermissionStatus(permission, true);
//           return true;
//         } else if (status.isPermanentlyDenied) {
//           await _showPermanentlyDeniedDialog(context);
//           return false;
//         } else {
//           // Retry if permission is denied but not permanently
//           await _showPermissionDeniedDialog(
//               context, permission, title, message);
//           return false;
//         }
//       }
//     } else if (status.isPermanentlyDenied) {
//       await _showPermanentlyDeniedDialog(context);
//       return false;
//     } else {
//       // Permission already granted
//       _updatePermissionStatus(permission, true);
//       return true;
//     }
//   }

//   Future<bool> _showPermissionRationaleDialog(BuildContext context,
//       Permission permission, String title, String message) async {
//     if (!context.mounted) return false; // Ensure context is still mounted

//     final result = await showDialog<String>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(title),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context, 'deny'),
//             child: const Text('Deny'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context, 'allow');
//             },
//             child: const Text('Allow'),
//           ),
//         ],
//       ),
//     );

//     return result == 'allow';
//   }

//   Future<void> _showPermissionDeniedDialog(BuildContext context,
//       Permission permission, String title, String message) async {
//     if (!context.mounted) return; // Ensure context is still mounted

//     final result = await showDialog<String>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('$title Denied'),
//         content: Text(
//             'This permission is required for the app to function properly. $message'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context, 'cancel'),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.pop(context, 'retry'),
//             child: const Text('Retry'),
//           ),
//         ],
//       ),
//     );

//     if (result == 'retry') {
//       // Retry permission request
//       await _requestPermission(context, permission, title, message);
//     }
//   }

//   Future<void> _showPermanentlyDeniedDialog(BuildContext context) async {
//     if (!context.mounted) return; // Ensure context is still mounted

//     await showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Permissions Permanently Denied'),
//         content: const Text(
//             'Some permissions are required for the app to function properly. Please enable them in the app settings.'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () async {
//               Navigator.pop(context);
//               await openAppSettings();
//             },
//             child: const Text('Open Settings'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _updatePermissionStatus(Permission permission, bool status) {
//     if (permission == Permission.location) {
//       _isLocationGranted = status;
//     } else if (permission == Permission.notification) {
//       _isNotificationGranted = status;
//       notifyListeners();
//     }
//     notifyListeners(); // Notify listeners to recheck navigation
//   }
// }
import 'package:flutter/material.dart';
import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionProvider extends ChangeNotifier {
  bool _isLocationGranted = false;
  bool _permissionsChecked = false;

  bool get isLocationGranted => _isLocationGranted;
  bool get permissionsChecked => _permissionsChecked;

  Future<void> checkAndRequestPermissions(BuildContext context) async {
    if (_permissionsChecked) return;

    // Request Location Permission
    _isLocationGranted = await _requestPermission(
      context,
      Permission.location,
      "Location Permission",
      "Location access is required for finding foods nearby.",
    );

    // Update permissions checked flag and notify listeners
    _permissionsChecked = true;
    notifyListeners();
  }

  // Future<bool> _requestPermission(BuildContext context, Permission permission,
  //     String title, String message) async {
  //   PermissionStatus status = await permission.status;

  //   if (status.isDenied) {
  //     bool shouldShowRationale = await permission.shouldShowRequestRationale;
  //     if (shouldShowRationale) {
  //       // Show rationale dialog and request permission again
  //       bool granted = await _showPermissionRationaleDialog(
  //           context, permission, title, message);
  //       if (granted) {
  //         status = await permission.request();
  //         if (status.isGranted) {
  //           _updatePermissionStatus(permission, true);
  //           return true;
  //         } else if (status.isPermanentlyDenied) {
  //           await _showPermanentlyDeniedDialog(context);
  //           return false;
  //         } else {
  //           // Retry if permission is denied but not permanently
  //           await _showPermissionDeniedDialog(
  //               context, permission, title, message);
  //           return false;
  //         }
  //       } else {
  //         await _showPermissionDeniedDialog(
  //             context, permission, title, message);
  //         return false;
  //       }

  //     } else {
  //       // Directly request permission without rationale
  //       status = await permission.request();
  //       if (status.isGranted) {
  //         _updatePermissionStatus(permission, true);
  //         return true;
  //       } else if (status.isPermanentlyDenied) {
  //         await _showPermanentlyDeniedDialog(context);
  //         return false;
  //       } else {
  //         // Retry if permission is denied but not permanently
  //         await _showPermissionDeniedDialog(
  //             context, permission, title, message);
  //         return false;
  //       }
  //     }
  //   } else if (status.isPermanentlyDenied) {
  //     await _showPermanentlyDeniedDialog(context);
  //     return false;
  //   } else {
  //     // Permission already granted
  //     _updatePermissionStatus(permission, true);
  //     return true;
  //   }
  // }
  // Future<bool> _requestPermission(BuildContext context, Permission permission,
  //     String title, String message) async {
  //   PermissionStatus status = await permission.status;

  //   if (status.isDenied) {
  //     bool shouldShowRationale = await permission.shouldShowRequestRationale;
  //     if (shouldShowRationale) {
  //       // Show rationale dialog and request permission again
  //       bool granted = await _showPermissionRationaleDialog(
  //           context, permission, title, message);
  //       if (!granted) {
  //         await _showPermissionDeniedDialog(
  //             context, permission, title, message);
  //         return false;
  //       }
  //     }
  //     // Request permission after rationale or directly if not required
  //     status = await permission.request();
  //     if (status.isGranted) {
  //       _updatePermissionStatus(permission, true);
  //       return true;
  //     } else if (status.isPermanentlyDenied) {
  //       await _showPermanentlyDeniedDialog(context);
  //       return false;
  //     } else {
  //       await _showPermissionDeniedDialog(context, permission, title, message);
  //       return false;
  //     }
  //   } else if (status.isPermanentlyDenied) {
  //     await _showPermanentlyDeniedDialog(context);
  //     return false;
  //   } else if (status.isGranted) {
  //     // Permission already granted
  //     _updatePermissionStatus(permission, true);
  //     return true;
  //   }

  //   return false; // Fallback return in case of unexpected behavior
  // }
  Future<bool> _requestPermission(BuildContext context, Permission permission,
      String title, String message) async {
    PermissionStatus status = await permission.status;

    if (status.isDenied) {
      bool shouldShowRationale = await permission.shouldShowRequestRationale;
      if (shouldShowRationale) {
        // Show rationale dialog and request permission again
        bool granted = await _showPermissionRationaleDialog(
            context, permission, title, message);
        if (!granted) {
          await _showPermissionDeniedDialog(
              context, permission, title, message);
          return false;
        }
      }
      // Request permission after rationale or directly if not required
      status = await permission.request();
      if (status.isGranted) {
        _updatePermissionStatus(permission, true);
        // Force navigation after permission is granted
        // Navigator.pushNamedAndRemoveUntil(
        //     context, "/navigationMenu", (route) => false);
        notifyListeners();
        return true;
      } else if (status.isPermanentlyDenied) {
        await _showPermanentlyDeniedDialog(context);
        return false;
      } else {
        await _showPermissionDeniedDialog(context, permission, title, message);
        return false;
      }
    } else if (status.isPermanentlyDenied) {
      await _showPermanentlyDeniedDialog(context);
      return false;
    } else if (status.isGranted) {
      // Permission already granted
      _updatePermissionStatus(permission, true);
      // Navigator.pushNamedAndRemoveUntil(
      //     context, "/navigationMenu", (route) => false);
      notifyListeners();
      return true;
    }

    return false; // Fallback return in case of unexpected behavior
  }

  Future<bool> _showPermissionRationaleDialog(BuildContext context,
      Permission permission, String title, String message) async {
    if (!context.mounted) return false; // Ensure context is still mounted

    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: KColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(KSizes.xs),
        ),
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'deny'),
            child: const Text('DENY'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'allow');
            },
            child: const Text('ALLOW'),
          ),
        ],
      ),
    );

    return result == 'allow';
  }

  Future<void> _showPermissionDeniedDialog(BuildContext context,
      Permission permission, String title, String message) async {
    if (!context.mounted) return; // Ensure context is still mounted

    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: KColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(KSizes.xs),
        ),
        title: Text('$title Denied'),
        content: Text(
            'This permission is required for the app to function properly. $message'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'cancel'),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'retry'),
            child: const Text('RETRY'),
          ),
        ],
      ),
    );

    if (result == 'retry') {
      // Retry permission request
      await _requestPermission(context, permission, title, message);
    }
  }

  Future<void> _showPermanentlyDeniedDialog(BuildContext context) async {
    if (!context.mounted) return; // Ensure context is still mounted

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: KColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(KSizes.xs),
        ),
        title: const Text('Permissions Permanently Denied'),
        content: const Text(
            'Some permissions are required for the app to function properly. Please enable them in the app settings.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await openAppSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  void _updatePermissionStatus(Permission permission, bool status) {
    if (permission == Permission.location) {
      _isLocationGranted = status;
    }
    notifyListeners();
  }
}
