import 'package:flutter/material.dart';

import '../common-diego/app_colors.dart';
import '../model-diego/classroom_model.dart';

class ClassroomsPage extends StatelessWidget {
  const ClassroomsPage({super.key});

  static const classrooms = [
    ClassroomModel(
      name: 'Aula 101',
      building: 'Pabellon A',
      capacity: 30,
      status: ClassroomStatus.available,
    ),
    ClassroomModel(
      name: 'Aula 203',
      building: 'Pabellon B',
      capacity: 35,
      status: ClassroomStatus.occupied,
    ),
    ClassroomModel(
      name: 'Laboratorio 1',
      building: 'Pabellon C',
      capacity: 24,
      status: ClassroomStatus.maintenance,
    ),
    ClassroomModel(
      name: 'Laboratorio 2',
      building: 'Pabellon C',
      capacity: 28,
      status: ClassroomStatus.available,
    ),
  ];

  void showDetails(BuildContext context, ClassroomModel classroom) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(classroom.name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ClassroomDetail(
                icon: Icons.location_on_outlined,
                text: classroom.building,
              ),
              _ClassroomDetail(
                icon: Icons.groups_outlined,
                text: 'Capacidad: ${classroom.capacity} estudiantes',
              ),
              _ClassroomDetail(
                icon: Icons.circle,
                text: classroom.status.label,
                color: classroom.status.color,
              ),
            ],
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cerrar'),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: classrooms.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 360,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 1.18,
      ),
      itemBuilder: (context, index) {
        final classroom = classrooms[index];

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: classroom.status.color.withAlpha(28),
                  foregroundColor: classroom.status.color,
                  child: const Icon(Icons.meeting_room_outlined),
                ),
                const SizedBox(height: 10),
                Text(
                  classroom.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(
                  classroom.building,
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 8),
                Chip(
                  visualDensity: VisualDensity.compact,
                  label: Text(classroom.status.label),
                  labelStyle: TextStyle(color: classroom.status.color),
                  backgroundColor: classroom.status.color.withAlpha(28),
                  side: BorderSide(color: classroom.status.color.withAlpha(80)),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 42,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.info_outline, size: 18),
                    label: const Text('Detalles'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () => showDetails(context, classroom),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ClassroomDetail extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? color;

  const _ClassroomDetail({required this.icon, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: color ?? AppColors.primary, size: 20),
          const SizedBox(width: 12),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
