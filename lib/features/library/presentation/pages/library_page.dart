import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/library_controller.dart';
import '../providers/library_scope.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LibraryScope(
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    final c = context.watch<LibraryController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Library')),
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
