
import 'package:flutter/material.dart';
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

class _SplashScreenState extends State<SplashScreen> {
  bool _timerFinished = false;
  final NotificationService _notificationService = NotificationService();
  Timer? _timer;
  late PermissionProvider _permissionProvider;

  @override
  void initState() {
    super.initState();

    _permissionProvider =
        Provider.of<PermissionProvider>(context, listen: false);
    _permissionProvider.addListener(_checkNavigation);

    _checkPermissionsAndInitNotifications();
  }

  @override
  void dispose() {
    // Cancel the timer if it's still running
    _timer?.cancel();

    // Remove listener when no longer needed
    _permissionProvider.removeListener(_checkNavigation);

    super.dispose();
  }

  Future<void> _checkPermissionsAndInitNotifications() async {
    // Use the stored _permissionProvider reference
//     await _permissionProvider.checkAndRequestPermissions(context);

//     // Initialize Firebase messaging and request notification permission
//     await _notificationService.requestNotificationPermission(context);
//  _notificationService.getDeviceToken();
//     _notificationService.firebaseInit(context);
//     _notificationService.setupInteractMessage(context);
//     // Start the timer after permissions check
//     _timer = Timer(const Duration(seconds: 3), () {
//       if (mounted) {
//         setState(() {
//           _timerFinished = true;
//         });
//       }
//       _checkNavigation();
//     });
    try {
      await _permissionProvider.checkAndRequestPermissions(context);
      await _notificationService.requestNotificationPermission(context);
      await _notificationService.getDeviceToken();
      _notificationService.firebaseInit(context);
      _notificationService.setupInteractMessage(context);
    } catch (e) {
      // Handle any errors that occur during initialization
      print("Error during initialization: $e");
    } finally {
      // Start the timer after all initialization is complete
      _timer = Timer(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _timerFinished = true;
          });
        }
        _checkNavigation();
      });
    }
  }

  Future<void> _initializeApp() async {
    final box = GetStorage();
    String? token = box.read("token");

    if (token != null) {
      final loginProvider = Provider.of<LoginProvider>(context, listen: false);
      loginProvider.getUserInfo();
    }

    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
          context, "/navigationMenu", (route) => false);
    }
  }

  void _checkNavigation() {
    // Use the stored _permissionProvider reference
    if (_timerFinished &&
        _permissionProvider.permissionsChecked &&
        _permissionProvider.isLocationGranted) {
      _initializeApp();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              KImages.logoGif,
              height: 300.h,
              width: 300.w,
              fit: BoxFit.cover,
            ),           
            KIndicator.circularIndicator(
              color: KColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
