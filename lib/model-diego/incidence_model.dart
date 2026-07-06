import 'package:flutter/material.dart';

enum IncidenceStatus {
  pending('Pendiente', Colors.red, Icons.warning_amber_rounded),
  inProgress('En proceso', Colors.blue, Icons.build_rounded),
  resolved('Resuelto', Colors.green, Icons.check_circle_rounded);

  const IncidenceStatus(this.label, this.color, this.icon);

  final String label;
  final Color color;
  final IconData icon;
}

class IncidenceModel {
  final String title;
  final String location;
  final IncidenceStatus status;
  final String description;

  const IncidenceModel({
    required this.title,
    required this.location,
    required this.status,
    required this.description,
  });

  IncidenceModel copyWith({
    String? title,
    String? location,
    IncidenceStatus? status,
    String? description,
  }) {
    return IncidenceModel(
      title: title ?? this.title,
      location: location ?? this.location,
      status: status ?? this.status,
      description: description ?? this.description,
    );
  }
}
