import 'package:flutter/material.dart';
import 'package:hassel/data/model/category_model.dart';
import 'package:hassel/data/model/order_model.dart';
import 'package:hassel/data/model/productModel.dart';
import 'package:hassel/features/auth/presentation/screens/forget_password.dart';
import 'package:hassel/features/auth/presentation/screens/login_screen.dart';
import 'package:hassel/features/auth/presentation/screens/register_screen.dart';
import 'package:hassel/features/auth/presentation/screens/welcome_screen.dart';
import 'package:hassel/features/cart/presentation/screens/cart_screen.dart';
import 'package:hassel/features/cart/presentation/screens/delivery_address.dart';
import 'package:hassel/features/favorite/presentation/favorite_screen.dart';
import 'package:hassel/features/home/presentation/screens/add_preview_product/add_review_screen.dart';
import 'package:hassel/features/home/presentation/screens/home_screen.dart';
import 'package:hassel/features/home/presentation/screens/product_details_screen.dart';
import 'package:hassel/features/home/presentation/screens/product_preview/product_preview_screen.dart';
import 'package:hassel/features/home/presentation/screens/product_screen.dart';
import 'package:hassel/features/home/presentation/screens/search/filter_screen.dart';
import 'package:hassel/features/intro/presentation/screens/intro_screen.dart';
import 'package:hassel/features/onboarding/onboarding_screen.dart';
import 'package:hassel/features/profile/my_addresses/add_address_screen.dart';
import 'package:hassel/features/profile/my_addresses/my_addresses_screen.dart';
import 'package:hassel/features/profile/my_credit/add_credit_card_screen.dart';
import 'package:hassel/features/profile/my_credit/my_credit_screen.dart';
import 'package:hassel/features/profile/my_information/my_information_screen.dart';
import 'package:hassel/features/profile/my_orders/my_orders_screen.dart';
import 'package:hassel/features/profile/my_orders/tracking_order_screen.dart';
import 'package:hassel/features/profile/notifications/notification_screen.dart';
import 'package:hassel/features/profile/profile_screen.dart';
import 'package:hassel/features/profile/transictions/transiction_screen.dart';

import '../home_page.dart';
import 'app.dart';
import 'features/home/presentation/screens/search/search_screen.dart';
import 'shared/app_utils/app_strings.dart';

class Routes {
  static const String initialRoute = '/';
  static const String introScreen = 'introRoute';
  static const String deliveryAddresscreen = 'DeliveryAddresscreen';
  static const String welcomeRoute = 'welcomeRoute';
  static const String logInRoute = 'logInRoute';
  static const String registerRoute = 'registerRoute';
  static const String forgetRoute = 'forgetRoute';
  static const String onBoardRoute = 'onBoardRoute';
  static const String homeRoute = 'homeRoute';
  static const String profileRoute = 'profileRoute';
  static const String favoriteRoute = 'favoriteRoute';
  static const String productRoute = 'productRoute';
  static const String productDetailsRoute = 'productDetailsRoute';
  static const String cartRoute = 'cartRoute';
  static const String addReviewScreen = 'AddProductReviewScreen';
  static const String myInformationRoute = 'MyInformationScreen';
  static const String myAdressesRoute = 'MyAdressesScreen';
  static const String addAddresscreen = 'AddAddresscreen';
  static const String myOrdersScreen = 'MyOrdersScreen';
  static const String searchScreen = 'SearchScreen';
  static const String filterScreen = 'FilterScreen';
  static const String transictiosScreen = 'TransictiosScreen';
  static const String poductPreviewScreen = 'PoductPreviewScreen';
  static const String notiFicationScreen = 'NotiFicationScreen';
  static const String myCreditCardScreen = 'MyCreditCardScreen';
  static const String addCreditCardScreen = 'AddCreditCardScreen';
  static const String trackingOrderScreen = 'TrackingOrderScreen';
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      //initial Route
      case Routes.initialRoute:
        return MaterialPageRoute(builder: (context) {
          return MyHomePage(
            title: App.tr.appName,
          );
        });
      //intro Route
      case Routes.introScreen:
        return MaterialPageRoute(builder: (context) {
          return const IntroScreen();
        });
      case Routes.deliveryAddresscreen:
        return MaterialPageRoute(builder: (context) {
          return const DeliveryAddresscreen();
        });
      case Routes.filterScreen:
        return MaterialPageRoute(builder: (context) {
          return const FilterScreen();
        });
      case Routes.poductPreviewScreen:
        return MaterialPageRoute(builder: (context) {
          return const PoductPreviewScreen();
        });
      case Routes.addReviewScreen:
        return MaterialPageRoute(builder: (context) {
          return const AddProductReviewScreen();
        });
      case Routes.addCreditCardScreen:
        return MaterialPageRoute(builder: (context) {
          return const AddCreditCardScreen();
        });
      case Routes.searchScreen:
        return MaterialPageRoute(builder: (context) {
          return const SearchScreen();
        });
      case Routes.transictiosScreen:
        return MaterialPageRoute(builder: (context) {
          return const TransictiosScreen();
        });
      case Routes.myCreditCardScreen:
        return MaterialPageRoute(builder: (context) {
          return const MyCreditCardScreen();
        });
      case Routes.notiFicationScreen:
        return MaterialPageRoute(builder: (context) {
          return const NotiFicationScreen();
        });
      case Routes.welcomeRoute:
        return MaterialPageRoute(builder: (context) {
          return const WelComeScreen();
        });
      case Routes.logInRoute:
        return MaterialPageRoute(builder: (context) {
          return const LogInScreen();
        });
      case Routes.myOrdersScreen:
        return MaterialPageRoute(builder: (context) {
          return const MyOrdersScreen();
        });
      case Routes.trackingOrderScreen:
        return MaterialPageRoute(builder: (context) {
          final order = routeSettings.arguments as OrderModel;
          return TrackingOrderScreen(order: order);
        });
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (context) {
          return const RegisterScreen();
        });
      case Routes.addAddresscreen:
        return MaterialPageRoute(builder: (context) {
          return const AddAddresscreen();
        });
      case Routes.forgetRoute:
        return MaterialPageRoute(builder: (context) {
          return const ForgetPasswordScreen();
        });
      case Routes.onBoardRoute:
        return MaterialPageRoute(builder: (context) {
          return const OnBoardingScreen();
        });
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (context) {
          return const HomeScreen();
        });
      case Routes.profileRoute:
        return MaterialPageRoute(builder: (context) {
          return const ProfileScreen();
        });
      case Routes.myInformationRoute:
        return MaterialPageRoute(builder: (context) {
          return  MyInformationScreen();
        });
      case Routes.favoriteRoute:
        return MaterialPageRoute(builder: (context) {
          return const FavoriteScreen();
        });
      case Routes.cartRoute:
        return MaterialPageRoute(builder: (context) {
          return const CartScreen();
        });
      case Routes.myAdressesRoute:
        return MaterialPageRoute(builder: (context) {
          return const MyAdressesScreen();
        });
      case Routes.productRoute:
        final item = routeSettings.arguments as CategoryModel;
        return MaterialPageRoute(builder: (context) {
          return ProductScreen(
            item: item,
          );
        });
      case Routes.productDetailsRoute:
        final item = routeSettings.arguments as ProductModel;
        return MaterialPageRoute(builder: (context) {
          return ProductDetailsScreen(
            item: item,
          );
        });

      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
        builder: ((context) => const Scaffold(
              body: Center(
                child: Text(AppStrings.noRouteFound),
              ),
            )));
  }
}
