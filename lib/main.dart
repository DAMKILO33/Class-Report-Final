import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'common_diego/app_theme.dart';
import 'menu_jesus/app_routes.dart';
import 'menu_jesus/auth_provider.dart';
import 'menu_jesus/cart_provider.dart';
import 'menu_jesus/user_provider.dart';

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
        title: 'Class Report Final',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        initialRoute: AppRoutes.root,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
