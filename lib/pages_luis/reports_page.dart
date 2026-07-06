import 'package:flutter/material.dart';

import '../common-diego/app_colors.dart';
import '../model-diego/incidence_model.dart';

class ReportsPage extends StatefulWidget {
  final List<IncidenceModel> reports;
  final ValueChanged<IncidenceModel> onReportAdded;
  final void Function(IncidenceModel report, IncidenceStatus status)
      onStatusChanged;

  const ReportsPage({
    super.key,
    required this.reports,
    required this.onReportAdded,
    required this.onStatusChanged,
  });

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    locationController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void changeReportStatus(IncidenceModel report, IncidenceStatus status) {
    widget.onStatusChanged(report, status);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Estado cambiado a ${status.label}')),
    );
  }

  void showStatusOptions(IncidenceModel report) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const ListTile(
                  title: Text(
                    'Cambiar estado',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                for (final status in IncidenceStatus.values)
                  ListTile(
                    leading: Icon(status.icon, color: status.color),
                    title: Text(status.label),
                    trailing: report.status == status
                        ? Icon(Icons.check, color: status.color)
                        : null,
                    onTap: () {
                      Navigator.pop(context);
                      changeReportStatus(report, status);
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showReportDetails(IncidenceModel report) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(report.title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _DetailRow(icon: Icons.room_outlined, text: report.location),
              const SizedBox(height: 10),
              InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  Navigator.pop(context);
                  showStatusOptions(report);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: _DetailRow(
                    icon: report.status.icon,
                    text: 'Estado: ${report.status.label}',
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(report.description),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  void showNewReportSheet() {
    titleController.clear();
    locationController.clear();
    descriptionController.clear();

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 18,
            right: 18,
            top: 18,
            bottom: MediaQuery.of(context).viewInsets.bottom + 18,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Nuevo reporte',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Titulo',
                  prefixIcon: Icon(Icons.report_problem_outlined),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: locationController,
                decoration: const InputDecoration(
                  labelText: 'Aula o laboratorio',
                  prefixIcon: Icon(Icons.room_outlined),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Descripcion',
                  prefixIcon: Icon(Icons.notes_outlined),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Guardar reporte'),
                  onPressed: () {
                    final title = titleController.text.trim();
                    final location = locationController.text.trim();
                    final description = descriptionController.text.trim();

                    if (title.isEmpty || location.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Completa titulo y ubicacion'),
                        ),
                      );
                      return;
                    }

                    widget.onReportAdded(
                      IncidenceModel(
                        title: title,
                        location: location,
                        status: IncidenceStatus.pending,
                        description: description.isEmpty
                            ? 'Reporte creado desde la app.'
                            : description,
                      ),
                    );
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        padding: const EdgeInsets.all(14),
        itemCount: widget.reports.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final report = widget.reports[index];

          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            leading: InkWell(
              borderRadius: BorderRadius.circular(28),
              onTap: () => showStatusOptions(report),
              child: CircleAvatar(
                backgroundColor: report.status.color.withAlpha(28),
                foregroundColor: report.status.color,
                child: Icon(report.status.icon),
              ),
            ),
            title: Text(
              report.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(report.location),
                const SizedBox(height: 4),
                _StatusChip(
                  status: report.status,
                  onTap: () => showStatusOptions(report),
                ),
              ],
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => showReportDetails(report),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        onPressed: showNewReportSheet,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final IncidenceStatus status;
  final VoidCallback onTap;

  const _StatusChip({required this.status, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      visualDensity: VisualDensity.compact,
      avatar: Icon(status.icon, color: status.color, size: 16),
      label: Text(status.label),
      labelStyle: TextStyle(color: status.color, fontSize: 12),
      backgroundColor: status.color.withAlpha(28),
      side: BorderSide.none,
      onPressed: onTap,
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _DetailRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const SizedBox(width: 10),
        Expanded(child: Text(text)),
      ],
    );
  }
}
