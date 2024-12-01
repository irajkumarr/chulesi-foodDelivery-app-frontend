import 'package:chulesi/core/network/connectivity_provider.dart';
import 'package:chulesi/features/authentication/providers/login_provider.dart';
import 'package:chulesi/features/authentication/providers/password_provider.dart';
import 'package:chulesi/features/authentication/providers/permission_provider.dart';
import 'package:chulesi/features/authentication/providers/signup_provider.dart';
import 'package:chulesi/features/authentication/providers/timer_provider.dart';
import 'package:chulesi/features/personalization/providers/address_provider.dart';
import 'package:chulesi/features/personalization/providers/location_provider.dart';
import 'package:chulesi/features/personalization/providers/map_provider.dart';
import 'package:chulesi/features/personalization/providers/order_provider.dart';
import 'package:chulesi/features/personalization/providers/profile_provider.dart';
import 'package:chulesi/features/personalization/providers/rating_provider.dart';
import 'package:chulesi/features/shop/providers/cart_provider.dart';

import 'package:chulesi/features/shop/providers/category_provider.dart';

import 'package:chulesi/features/shop/providers/foods_list_provider.dart';
import 'package:chulesi/features/shop/providers/foods_provider.dart';
import 'package:chulesi/features/shop/providers/home_provider.dart';
import 'package:chulesi/features/shop/providers/offers_food_list_provider.dart';
import 'package:chulesi/features/shop/providers/slider_provider.dart';
import 'package:chulesi/features/shop/providers/search_provider.dart';
import 'package:chulesi/navigation_menu.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppProviders {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => ResendTimerProvider()),
    ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
    ChangeNotifierProvider(create: (_) => LocationProvider()),
    ChangeNotifierProvider(create: (_) => MapProvider()),
    ChangeNotifierProvider(create: (_) => AddressProvider()),
    ChangeNotifierProvider(create: (_) => PermissionProvider()),
    ChangeNotifierProvider(create: (_) {
      final provider = CartProvider();
      provider.initializeCart(); // Initialize cart state
      return provider;
    }
        //  => CartProvider()
        ),
    ChangeNotifierProvider(create: (_) => RatingProvider()),
    ChangeNotifierProvider(create: (_) => OrderProvider()),
    ChangeNotifierProvider(create: (_) => CategoryProvider()),
    ChangeNotifierProvider(create: (_) => SliderProvider()),
    ChangeNotifierProvider(create: (_) => FoodsListProvider()),
    ChangeNotifierProvider(create: (_) => OffersFoodListProvider()),
    ChangeNotifierProvider(create: (_) => NavigationProvider()),
    ChangeNotifierProvider(create: (_) => HomeProvider()),
    ChangeNotifierProvider(create: (_) => LoginProvider()),
    ChangeNotifierProxyProvider<LoginProvider, ProfileProvider>(
      create: (context) => ProfileProvider(
          loginProvider: Provider.of<LoginProvider>(context, listen: false)),
      update: (context, loginProvider, previous) =>
          ProfileProvider(loginProvider: loginProvider),
    ),
    ChangeNotifierProvider(create: (_) => SignupProvider()),
    ChangeNotifierProvider(create: (_) => PasswordProvider()),
    ChangeNotifierProvider(create: (_) => SearchProvider()),
    ChangeNotifierProvider(create: (_) => FoodsProvider()),
  ];
}
