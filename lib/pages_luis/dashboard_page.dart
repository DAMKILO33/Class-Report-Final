import 'package:flutter/material.dart';

import '../common-diego/app_colors.dart';
import '../model-diego/incidence_model.dart';

class DashboardPage extends StatelessWidget {
  final String role;
  final List<IncidenceModel> reports;

  const DashboardPage({super.key, required this.role, required this.reports});

  @override
  Widget build(BuildContext context) {
    final pending = reports
        .where((report) => report.status == IncidenceStatus.pending)
        .length;
    final inProgress = reports
        .where((report) => report.status == IncidenceStatus.inProgress)
        .length;
    final resolved = reports
        .where((report) => report.status == IncidenceStatus.resolved)
        .length;

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF1D4ED8), Color(0xFF2563EB)],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Bienvenido',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
              const SizedBox(height: 4),
              Text(
                role.isEmpty ? 'Administrador' : role,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Sistema de Reporte de Incidencias',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'Resumen',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _SummaryCard(
              icon: Icons.warning_amber_rounded,
              label: 'Pendientes',
              value: pending,
              color: Colors.red,
            ),
            _SummaryCard(
              icon: Icons.build_rounded,
              label: 'En proceso',
              value: inProgress,
              color: Colors.blue,
            ),
            _SummaryCard(
              icon: Icons.check_circle_rounded,
              label: 'Resueltos',
              value: resolved,
              color: Colors.green,
            ),
            _SummaryCard(
              icon: Icons.assignment_outlined,
              label: 'Total',
              value: reports.length,
              color: AppColors.primary,
            ),
          ],
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final int value;
  final Color color;

  const _SummaryCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color, size: 30),
              const SizedBox(height: 14),
              Text(
                '$value',
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(label, style: const TextStyle(color: Colors.black54)),
            ],
          ),
        ),
      ),
    );
  }
}
