import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/{{feature_name.snakeCase()}}_controller.dart';
import '../providers/{{feature_name.snakeCase()}}_scope.dart';

class {{feature_name.pascalCase()}}Page extends StatelessWidget {
  const {{feature_name.pascalCase()}}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return {{feature_name.pascalCase()}}Scope(
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    final c = context.watch<{{feature_name.pascalCase()}}Controller>();

    return Scaffold(
      appBar: AppBar(title: const Text('{{feature_name.pascalCase()}}')),
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
