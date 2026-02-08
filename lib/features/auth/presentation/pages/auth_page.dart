import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/auth_controller.dart';
import '../providers/auth_scope.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScope(
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    final c = context.watch<AuthController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Auth')),
      body: Center(
        child: c.loading
            ? const CircularProgressIndicator()
            : c.error != null
                ? Text('Erro: ${c.error}')
                : const Text('OK'),
      ),
    );
  }
}
