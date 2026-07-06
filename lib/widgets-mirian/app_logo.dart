import 'package:flutter/material.dart';

import '../common-diego/app_colors.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 45,
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.school, color: Colors.white, size: 50),
        ),

        const SizedBox(height: 15),

        const Text(
          "ClassReport",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 5),

        const Text(
          "Sistema de Reporte de Incidencias",
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
