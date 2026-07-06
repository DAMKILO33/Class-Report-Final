import 'package:flutter/material.dart';

import '../pages_luis/cart_page.dart';
import '../pages_luis/home_page.dart';
import '../pages_luis/login_page.dart';
import '../pages_luis/splash_page.dart';

class AppRoutes {
  static const String root = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String cart = '/cart';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case root:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage(role: ''));
      case cart:
        return MaterialPageRoute(builder: (_) => const CartPage());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Ruta no encontrada'))),
        );
    }
  }
}
