import 'package:chulesi/common/widgets/success_screen/success.dart';
import 'package:chulesi/features/shop/screens/more/help_and_support.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chulesi/features/authentication/screens/login/login.dart';
import 'package:chulesi/features/authentication/screens/login/widgets/login_redirect.dart';
import 'package:chulesi/features/authentication/screens/password_confirmation/forget_password.dart';
import 'package:chulesi/features/authentication/screens/password_confirmation/reset_password.dart';
import 'package:chulesi/features/authentication/screens/phone_verification/otp_verification.dart';
import 'package:chulesi/features/authentication/screens/sign_up/sign_up.dart';
import 'package:chulesi/features/authentication/screens/splash/splash.dart';
import 'package:chulesi/features/personalization/screens/address/address.dart';
import 'package:chulesi/features/personalization/screens/order/order_history.dart';
import 'package:chulesi/features/personalization/screens/profile/change_password.dart';

import 'package:chulesi/features/personalization/screens/profile/profile.dart';
import 'package:chulesi/features/personalization/screens/profile/profile_settings.dart';
import 'package:chulesi/features/shop/screens/cart/cart.dart';
import 'package:chulesi/features/shop/screens/category/all_category.dart';
import 'package:chulesi/features/shop/screens/home/all_deals_offers.dart';
import 'package:chulesi/features/shop/screens/home/all_popular_foods.dart';
import 'package:chulesi/features/shop/screens/home/best_rated_foods.dart';
import 'package:chulesi/features/shop/screens/home/home.dart';
import 'package:chulesi/features/shop/screens/home/recommended_foods.dart';
import 'package:chulesi/features/shop/screens/home/category_foods_list.dart';
import 'package:chulesi/features/shop/screens/more/notification.dart';
import 'package:chulesi/features/shop/screens/search/search_screen.dart';
import '../../navigation_menu.dart';

class AppRoutes {
  static const String splash = "/splash";
  static const String category = "/category";
  static const String home = "/home";
  static const String account = "/account";
  static const String cart = "/cart";
  static const String notification = "/notification";
  static const String helpAndSupport = "/helpAndSupport";
  static const String allPopularFoods = "/allPopularFoods";
  static const String recommendedFoods = "/recommendedFoods";
  static const String bestRatedFoods = "/bestRatedFoods";
  static const String dealsAndOffers = "/dealsAndOffers";
  static const String search = "/search";
  static const String categoryFoodsScreen = "/categoryFoodsScreen";
  static const String login = "/login";
  static const String loginRedirect = "/loginRedirect";
  static const String signup = "/signup";
  static const String otp = "/otp";
  static const String forgotPassword = "/forgotPassword";
  static const String resetPassword = "/resetPassword";
  static const String profileSetting = "/profileSetting";
  static const String changePassword = "/changePassword";
  static const String orderHistory = "/orderHistory";
  static const String checkout = "/checkout";
  static const String address = "/address";
  static const String successScreen = "/successScreen";
  static const String addNewAddress = "/addNewAddress";

  static const String navigationMenu = "/navigationMenu";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {
      case splash:
        return CupertinoPageRoute(builder: (_) => const SplashScreen());
      case navigationMenu:
        return MaterialPageRoute(builder: (_) => const NavigationMenu());
      case home:
        return CupertinoPageRoute(builder: (_) => const HomeScreen());
      case category:
        return MaterialPageRoute(builder: (_) => const AllCategoryScreen());
      case allPopularFoods:
        return MaterialPageRoute(builder: (_) => const AllPopularFoodsScreen());
      case recommendedFoods:
        return MaterialPageRoute(
            builder: (_) => const RecommendedFoodsScreen());
      case bestRatedFoods:
        return MaterialPageRoute(builder: (_) => const BestRatedFoodsScreen());
      case dealsAndOffers:
        return MaterialPageRoute(builder: (_) => const DealsAndOffersScreen());
      case search:
        return CupertinoPageRoute(builder: (_) => const SearchScreen());
      case categoryFoodsScreen:
        return CupertinoPageRoute(builder: (_) => const CategoryFoodsList());
      case account:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case address:
        return CupertinoPageRoute(builder: (_) => const AddressScreen());
      case successScreen:
        return MaterialPageRoute(builder: (_) => const SuccessScreen());
      case orderHistory:
        return CupertinoPageRoute(builder: (_) => const OrderHistory());
      case cart:
        return CupertinoPageRoute(builder: (_) => const CartScreen());
      case notification:
        return MaterialPageRoute(builder: (_) => NotificationScreen());
      case helpAndSupport:
        return MaterialPageRoute(builder: (_) => const HelpAndSupportScreen());
      case login:
        return CupertinoPageRoute(builder: (_) => const LoginScreen());
      case loginRedirect:
        return CupertinoPageRoute(builder: (_) => const LoginRedirect());
      case signup:
        return CupertinoPageRoute(builder: (_) => const SignupScreen());
      case changePassword:
        return CupertinoPageRoute(builder: (_) => const ChangePasswordScreen());
      case otp:
        return CupertinoPageRoute(
            builder: (_) => const OtpVerificationScreen());
      case forgotPassword:
        return CupertinoPageRoute(builder: (_) => const ForgetPasswordScreen());
      case resetPassword:
        final String data = settings.arguments as String;
        return CupertinoPageRoute(
            builder: (_) => ResetPasswordScreen(email: data));
      case profileSetting:
        final arguments = settings.arguments as Map<String, dynamic>?;

        return MaterialPageRoute(
          builder: (_) => ProfileSettings(
            firstName: arguments?['firstName'] ?? '',
            lastName: arguments?['lastName'] ?? '',
            email: arguments?['email'] ?? '',
            phone: arguments?['phone'] ?? '',
          ),
        );

      default:
        return MaterialPageRoute(
            builder: (_) =>
                const Scaffold(body: Center(child: Text('Route not found'))));
    }
  }
}
