import 'package:flutter/material.dart';

enum ClassroomStatus {
  available('Disponible', Colors.green),
  occupied('Ocupada', Colors.orange),
  maintenance('Mantenimiento', Colors.red);

  const ClassroomStatus(this.label, this.color);

  final String label;
  final Color color;
}

class ClassroomModel {
  final String name;
  final String building;
  final int capacity;
  final ClassroomStatus status;

  const ClassroomModel({
    required this.name,
    required this.building,
    required this.capacity,
    required this.status,
  });
}
