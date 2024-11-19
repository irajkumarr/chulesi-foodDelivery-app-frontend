// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:chulesi/core/services/notification_service.dart';
// import 'package:chulesi/features/authentication/providers/login_provider.dart';
// import 'package:chulesi/features/authentication/providers/permission_provider.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:provider/provider.dart';
// import 'dart:async';

// import '../../../../../core/utils/circular_progress_indicator/circlular_indicator.dart';
// import '../../../../../core/utils/constants/colors.dart';
// import '../../../../../core/utils/constants/image_strings.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with TickerProviderStateMixin {
//   bool _timerFinished = false;
//   final NotificationService _notificationService = NotificationService();
//   Timer? _timer;
//   late PermissionProvider _permissionProvider;
//   late AnimationController _logoController;
//   late Animation<double> _logoAnimation;

//   @override
//   void initState() {
//     super.initState();

//     _permissionProvider =
//         Provider.of<PermissionProvider>(context, listen: false);
//     _permissionProvider.addListener(_checkNavigation);

//     _checkPermissionsAndInitNotifications();

//     // Initialize logo animation
//     _logoController = AnimationController(
//       duration: const Duration(seconds: 3),
//       vsync: this,
//     );
//     _logoAnimation =
//         Tween<double>(begin: 1.0, end: 1.2).animate(_logoController)
//           ..addStatusListener((status) {
//             if (status == AnimationStatus.completed) {
//               _logoController.reverse();
//             } else if (status == AnimationStatus.dismissed) {
//               _logoController.forward();
//             }
//           });
//     _logoController.forward();
//   }

//   @override
//   void dispose() {
//     // Cancel the timer if it's still running
//     _timer?.cancel();

//     // Remove listener when no longer needed
//     _permissionProvider.removeListener(_checkNavigation);

//     // Dispose the logo animation controller
//     _logoController.dispose();

//     super.dispose();
//   }

//   Future<void> _checkPermissionsAndInitNotifications() async {
//     try {
//       await _permissionProvider.checkAndRequestPermissions(context);
//       await _notificationService.requestNotificationPermission(context);
//       await _notificationService.getDeviceToken();
//       _notificationService.firebaseInit(context);
//       _notificationService.setupInteractMessage(context);
//     } catch (e) {
//       // Handle any errors that occur during initialization
//       print("Error during initialization: $e");
//     } finally {
//       // Start the timer after all initialization is complete
//       _timer = Timer(const Duration(seconds: 3), () {
//         if (mounted) {
//           setState(() {
//             _timerFinished = true;
//           });
//         }
//         _checkNavigation();
//       });
//     }
//   }

//   Future<void> _initializeApp() async {
//     final box = GetStorage();
//     String? token = box.read("token");

//     if (token != null) {
//       final loginProvider = Provider.of<LoginProvider>(context, listen: false);
//       loginProvider.getUserInfo();
//     }

//     if (mounted) {
//       Navigator.pushNamedAndRemoveUntil(
//           context, "/navigationMenu", (route) => false);
//     }
//   }

//   void _checkNavigation() {
//     if (_timerFinished &&
//         _permissionProvider.permissionsChecked &&
//         _permissionProvider.isLocationGranted) {
//       _initializeApp();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: KColors.primary,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             AnimatedBuilder(
//               animation: _logoAnimation,
//               builder: (context, child) {
//                 return Transform.scale(
//                   scale: _logoAnimation.value,
//                   child: Image.asset(
//                     KImages.lightIcon,
//                     height: 300.h,
//                     width: 300.w,
//                     fit: BoxFit.cover,
//                   ),
//                 );
//               },
//             ),
//             KIndicator.circularIndicator(
//               color: KColors.white,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chulesi/core/services/notification_service.dart';
import 'package:chulesi/features/authentication/providers/login_provider.dart';
import 'package:chulesi/features/authentication/providers/permission_provider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import '../../../../../core/utils/circular_progress_indicator/circlular_indicator.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/image_strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late PermissionProvider _permissionProvider;
  late AnimationController _logoController;
  late Animation<double> _logoAnimation;
  bool _isInitializing = false;
  Timer? _splashTimer;
  bool _timerCompleted = false;
  bool _initializationCompleted = false;

  @override
  void initState() {
    super.initState();
    _setupLogoAnimation();
    _startSplashTimer();
    _initializeApp();
  }

  void _startSplashTimer() {
    _splashTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _timerCompleted = true;
        });
        _checkNavigate();
      }
    });
  }

  void _checkNavigate() {
    if (_timerCompleted && _initializationCompleted && mounted) {
      Navigator.pushNamedAndRemoveUntil(
          context, "/navigationMenu", (route) => false);
    }
  }

  void _setupLogoAnimation() {
    _logoController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _logoAnimation =
        Tween<double>(begin: 1.0, end: 1.2).animate(_logoController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _logoController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              _logoController.forward();
            }
          });
    _logoController.forward();
  }

  @override
  void dispose() {
    _logoController.dispose();
    _splashTimer?.cancel();
    super.dispose();
  }

  Future<void> _initializeApp() async {
    if (_isInitializing) return;
    _isInitializing = true;

    try {
      _permissionProvider =
          Provider.of<PermissionProvider>(context, listen: false);

      // Check permissions
      bool permissionsGranted =
          await _permissionProvider.checkAndRequestPermissions(context);

      if (!permissionsGranted) {
        if (mounted) {
          SystemNavigator.pop();
        }
        return;
      }

      // Initialize notifications
      final NotificationService notificationService = NotificationService();
      await notificationService.requestNotificationPermission(context);
      await notificationService.getDeviceToken();
      notificationService.firebaseInit(context);
      notificationService.setupInteractMessage(context);

      // Check authentication
      final box = GetStorage();
      String? token = box.read("token");

      if (token != null && mounted) {
        final loginProvider =
            Provider.of<LoginProvider>(context, listen: false);
        await loginProvider.getUserInfo();
      }

      // Mark initialization as complete and check for navigation
      if (mounted) {
        setState(() {
          _initializationCompleted = true;
        });
        _checkNavigate();
      }
    } catch (e) {
      print("Initialization error: $e");
      if (mounted) {
        SystemNavigator.pop();
      }
    } finally {
      _isInitializing = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: KColors.primary,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _logoAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _logoAnimation.value,
                    child: Image.asset(
                      KImages.lightIcon,
                      height: 300.h,
                      width: 300.w,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
              KIndicator.circularIndicator(
                color: KColors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
