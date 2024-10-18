import 'package:chulesi/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

import 'core/providers/app_providers.dart';
import 'core/utils/theme/theme.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (_, child) {
          return MultiProvider(
            providers: AppProviders.providers,
            child: MaterialApp(
              navigatorKey: navigatorKey,
              title: 'Chulesi',
              debugShowCheckedModeBanner: false,
              theme: KAppTheme.lightTheme,
              initialRoute: AppRoutes.splash,
              onGenerateRoute: AppRoutes.onGenerateRoute,
            ),
          );
        });
  }
}
