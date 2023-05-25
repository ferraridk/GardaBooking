import 'package:ecomrejsegarda/models/category_model.dart';
import 'package:ecomrejsegarda/screens/product/product_screen.dart';
import 'package:ecomrejsegarda/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/product_model.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('This is route: ${settings.name}');

    switch (settings.name) {
      case '/':
        return CitiesScreen.route();
      case CitiesScreen.routeName:
        return CitiesScreen.route();
      case SplashScreen.routeName:
        return SplashScreen.route();
      case CartScreen.routeName:
        return CartScreen.route();
      case CatalogScreen.routeName:
        return CatalogScreen.route(category: settings.arguments as Category);
      case LoginScreen.routeName:
        return LoginScreen.route();
      case CheckoutScreen.routeName:
        return CheckoutScreen.route();
      case ProductScreen.routeName:
        return ProductScreen.route(product: settings.arguments as Product);
      case WishlistScreen.routeName:
        return WishlistScreen.route();
      case HomeScreen.routeName:
        final selectedCity = settings
            .arguments as String;
        return HomeScreen.route(
            selectedCity: selectedCity);

      default:
        return _errorRoute();
    }
  }
}

  Route _errorRoute() {
    return MaterialPageRoute(
      settings: RouteSettings(name: 'error'),
      builder: (_) =>
          Scaffold(appBar: AppBar(title: Text('Error'),
          ),
          ),
    );
  }
