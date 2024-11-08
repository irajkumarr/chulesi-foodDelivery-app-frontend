import 'package:chulesi/app.dart';
import 'package:chulesi/core/services/notification_service.dart';
import 'package:chulesi/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

@pragma('vm:entry-point')
Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();
  // Use the NotificationService to store the notification
  final notificationService = NotificationService();

  await notificationService.storeNotification(message);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Lock the app in portrait mode
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);
  await GetStorage.init();

  runApp(const App());
}
