import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/achievements_controller.dart';
import '../providers/achievements_scope.dart';

class AchievementsPage extends StatelessWidget {
  const AchievementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AchievementsScope(
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    final c = context.watch<AchievementsController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Achievements')),
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
