import 'package:flutter/material.dart';

import '../common-diego/app_colors.dart';
import '../menu-jesus/auth_service.dart';
import '../widgets-mirian/app_logo.dart';
import '../widgets-mirian/custom_text_field.dart';
import 'home_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() {
    if (!formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Correo o contrasena incorrectos'),
        ),
      );
      return;
    }

    AuthService.instance.login(
      '1',
      'Administrador',
      emailController.text.trim(),
      role: 'Administrador',
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(role: 'Administrador'),
      ),
    );
  }

  void goToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterPage()),
    );
  }

  void recoverPassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Se envio un enlace de recuperacion al correo'),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AppLogo(),
                  const SizedBox(height: 14),
                  const Text(
                    'Inicia sesion para continuar',
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 24),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: emailController,
                          label: 'Correo',
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            final email = value?.trim() ?? '';

                            if (email.isEmpty) {
                              return 'Ingresa el correo';
                            }

                            if (email != 'admin@classreport.com') {
                              return 'Correo incorrecto';
                            }

                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        CustomTextField(
                          controller: passwordController,
                          label: 'Contrasena',
                          icon: Icons.lock_outline,
                          isPassword: true,
                          validator: (value) {
                            final password = value ?? '';

                            if (password.isEmpty) {
                              return 'Ingresa la contrasena';
                            }

                            if (password != '123456') {
                              return 'Contrasena incorrecta';
                            }

                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: recoverPassword,
                      child: const Text('Olvidaste tu contrasena?'),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Iniciar sesion'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Text('No tienes cuenta?'),
                      TextButton(
                        onPressed: goToRegister,
                        child: const Text('Registrate'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
