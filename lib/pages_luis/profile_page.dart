import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

import '../common_diego/app_colors.dart';

class ProfilePage extends StatefulWidget {
  final String role;
  final VoidCallback onLogout;

  const ProfilePage({super.key, required this.role, required this.onLogout});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;
  late final TextEditingController codeController;

  String name = 'Administrador';
  String email = 'admin@classreport.com';
  String phone = '999999999';
  String code = 'ADM001';

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    codeController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    codeController.dispose();
    super.dispose();
  }

  void showAction(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void showEditProfileDialog() {
    nameController.text = name;
    emailController.text = email;
    phoneController.text = phone;
    codeController.text = code;

    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar perfil'),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: (value) {
                      if ((value ?? '').trim().isEmpty) {
                        return 'Ingresa el nombre';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Correo',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    validator: (value) {
                      final email = (value ?? '').trim();

                      if (email.isEmpty) {
                        return 'Ingresa el correo';
                      }

                      if (!EmailValidator.validate(email)) {
                        return 'Correo invalido';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Telefono',
                      prefixIcon: Icon(Icons.phone_outlined),
                    ),
                    validator: (value) {
                      if ((value ?? '').trim().isEmpty) {
                        return 'Ingresa el telefono';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: codeController,
                    decoration: const InputDecoration(
                      labelText: 'Codigo',
                      prefixIcon: Icon(Icons.tag),
                    ),
                    validator: (value) {
                      if ((value ?? '').trim().isEmpty) {
                        return 'Ingresa el codigo';
                      }

                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: saveProfile,
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void saveProfile() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      name = nameController.text.trim();
      email = emailController.text.trim();
      phone = phoneController.text.trim();
      code = codeController.text.trim();
    });

    Navigator.pop(context);
    showAction(context, 'Perfil actualizado');
  }

  @override
  Widget build(BuildContext context) {
    final displayRole = widget.role.isEmpty ? 'Administrador' : widget.role;

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Column(
          children: [
            const CircleAvatar(
              radius: 38,
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              child: Icon(Icons.person, size: 42),
            ),
            const SizedBox(height: 12),
            Text(
              name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              email,
              style: const TextStyle(color: Colors.black54),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _ProfileTile(
          icon: Icons.badge_outlined,
          title: 'Rol',
          subtitle: displayRole,
        ),
        const Divider(height: 1),
        _ProfileTile(
          icon: Icons.phone_outlined,
          title: 'Telefono',
          subtitle: phone,
        ),
        const Divider(height: 1),
        _ProfileTile(
          icon: Icons.tag,
          title: 'Codigo',
          subtitle: code,
        ),
        const SizedBox(height: 18),
        SizedBox(
          height: 46,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.edit_outlined),
            label: const Text('Editar perfil'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            onPressed: showEditProfileDialog,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 46,
          child: OutlinedButton.icon(
            icon: const Icon(Icons.lock_reset_outlined),
            label: const Text('Cambiar contrasena'),
            onPressed: () => showAction(
              context,
              'Solicitud de cambio de contrasena enviada',
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 46,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.logout),
            label: const Text('Cerrar sesion'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: widget.onLogout,
          ),
        ),
      ],
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}
