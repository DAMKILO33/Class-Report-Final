import 'package:flutter/material.dart';

import '../common-diego/app_colors.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _sendRecoveryEmail() {
    if (!_formKey.currentState!.validate()) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.success,
        content: Text(
          "Se enviaron las instrucciones a ${_emailController.text}",
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(title: const Text("Recuperar contraseña")),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),

            child: Form(
              key: _formKey,

              child: Column(
                children: [
                  const Icon(
                    Icons.lock_reset,
                    size: 90,
                    color: AppColors.primary,
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    "¿Olvidaste tu contraseña?",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "Ingresa tu correo institucional y te enviaremos las instrucciones para recuperar tu contraseña.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.textLight, fontSize: 15),
                  ),

                  const SizedBox(height: 35),

                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,

                    decoration: const InputDecoration(
                      labelText: "Correo electrónico",
                      prefixIcon: Icon(Icons.email_outlined),
                    ),

                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Ingrese su correo";
                      }

                      if (!value.contains("@")) {
                        return "Correo inválido";
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 35),

                  SizedBox(
                    width: double.infinity,
                    height: 52,

                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.send),
                      label: const Text(
                        "Enviar",
                        style: TextStyle(fontSize: 17),
                      ),
                      onPressed: _sendRecoveryEmail,
                    ),
                  ),

                  const SizedBox(height: 15),

                  TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                    label: const Text("Volver al inicio de sesión"),
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
