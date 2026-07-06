import 'package:flutter/material.dart';

import '../common-diego/app_colors.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        "title": "Nuevo reporte registrado",
        "message": "Se registró una incidencia en el Aula 101.",
        "time": "Hace 5 min",
        "icon": Icons.report_problem,
        "color": Colors.orange,
      },
      {
        "title": "Reporte solucionado",
        "message": "El proyector del Laboratorio 1 fue reparado.",
        "time": "Hace 20 min",
        "icon": Icons.check_circle,
        "color": Colors.green,
      },
      {
        "title": "Nuevo usuario",
        "message": "Un estudiante creó una cuenta.",
        "time": "Hace 1 hora",
        "icon": Icons.person_add,
        "color": Colors.blue,
      },
      {
        "title": "Mantenimiento programado",
        "message": "El Aula 203 estará en mantenimiento mañana.",
        "time": "Ayer",
        "icon": Icons.build,
        "color": Colors.red,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(title: const Text("Notificaciones")),

      body: ListView.builder(
        padding: const EdgeInsets.all(18),
        itemCount: notifications.length,

        itemBuilder: (context, index) {
          final item = notifications[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 15),

            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: (item["color"] as Color).withValues(
                  alpha: .15,
                ),
                child: Icon(
                  item["icon"] as IconData,
                  color: item["color"] as Color,
                ),
              ),

              title: Text(
                item["title"] as String,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),

              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(item["message"] as String),
                  const SizedBox(height: 8),
                  Text(
                    item["time"] as String,
                    style: const TextStyle(
                      color: AppColors.textLight,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
