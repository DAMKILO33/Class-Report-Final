import 'package:flutter/material.dart';

// Importa las páginas de cada compañero
import 'pages_luis/home_page.dart';       // Luis
import 'menu_jesus/app_routes.dart';      // Jesús
import 'widgets_mirian/app_logo.dart';    // Mirian
// Diego: sus modelos se usan en lógica, no como pantallas

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Class Report Final',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),   // Luis
        '/menu': (context) => const MenuPage(), // Jesús
        '/logo': (context) => const AppLogo(), // Mirian
      },
    );
  }
}
