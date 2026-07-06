import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'menu-jesus/user_provider.dart';
import 'menu-jesus/cart_provider.dart';
import 'menu-jesus/auth_provider.dart';
import 'menu-jesus/app_routes.dart';
import 'common-diego/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mi Proyecto',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        initialRoute: AppRoutes.root,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
