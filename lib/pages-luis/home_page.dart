import 'package:flutter/material.dart';

import '../common-diego/app_colors.dart';
import '../menu-jesus/app_routes.dart';
import '../menu-jesus/auth_service.dart';
import '../model-diego/incidence_model.dart';
import 'classrooms_page.dart';
import 'dashboard_page.dart';
import 'profile_page.dart';
import 'reports_page.dart';

class HomePage extends StatefulWidget {
  final String role;

  const HomePage({super.key, required this.role});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<IncidenceModel> reports = [
    const IncidenceModel(
      title: 'Proyector no funciona',
      location: 'Aula 101',
      status: IncidenceStatus.pending,
      description: 'El proyector no enciende al iniciar la clase.',
    ),
    const IncidenceModel(
      title: 'Silla rota',
      location: 'Aula 203',
      status: IncidenceStatus.inProgress,
      description: 'Una silla necesita reparacion en la segunda fila.',
    ),
    const IncidenceModel(
      title: 'Foco quemado',
      location: 'Laboratorio 1',
      status: IncidenceStatus.resolved,
      description: 'Se reemplazo el foco principal del laboratorio.',
    ),
  ];

  void selectPage(int index) {
    setState(() {
      selectedIndex = index;
    });
    Navigator.maybePop(context);
  }

  void addReport(IncidenceModel report) {
    setState(() {
      reports.insert(0, report);
    });
  }

  void updateReportStatus(IncidenceModel report, IncidenceStatus status) {
    final index = reports.indexOf(report);

    if (index == -1) {
      return;
    }

    setState(() {
      reports[index] = report.copyWith(status: status);
    });
  }

  void logout() {
    AuthService.instance.logout();
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      DashboardPage(role: widget.role, reports: reports),
      ReportsPage(
        reports: reports,
        onReportAdded: addReport,
        onStatusChanged: updateReportStatus,
      ),
      const ClassroomsPage(),
      ProfilePage(role: widget.role, onLogout: logout),
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('ClassReport'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Notificaciones',
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No hay notificaciones nuevas')),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1D4ED8), Color(0xFF2563EB)],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.primary,
                      child: Icon(Icons.person),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.role.isEmpty ? 'Administrador' : widget.role,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'admin@classreport.com',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              _DrawerDestination(
                icon: Icons.dashboard_outlined,
                label: 'Inicio',
                selected: selectedIndex == 0,
                onTap: () => selectPage(0),
              ),
              _DrawerDestination(
                icon: Icons.assignment_outlined,
                label: 'Reportes',
                selected: selectedIndex == 1,
                onTap: () => selectPage(1),
              ),
              _DrawerDestination(
                icon: Icons.apartment_outlined,
                label: 'Aulas',
                selected: selectedIndex == 2,
                onTap: () => selectPage(2),
              ),
              _DrawerDestination(
                icon: Icons.person_outline,
                label: 'Perfil',
                selected: selectedIndex == 3,
                onTap: () => selectPage(3),
              ),
              const Spacer(),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text('Cerrar sesion'),
                onTap: logout,
              ),
            ],
          ),
        ),
      ),
      body: IndexedStack(index: selectedIndex, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: selectPage,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.assignment_outlined),
            selectedIcon: Icon(Icons.assignment),
            label: 'Reportes',
          ),
          NavigationDestination(
            icon: Icon(Icons.apartment_outlined),
            selectedIcon: Icon(Icons.apartment),
            label: 'Aulas',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

class _DrawerDestination extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _DrawerDestination({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      selected: selected,
      selectedColor: AppColors.primary,
      onTap: onTap,
    );
  }
}
