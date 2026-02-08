import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/now_playing_controller.dart';
import '../providers/now_playing_scope.dart';

class NowPlayingPage extends StatelessWidget {
  const NowPlayingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return NowPlayingScope(
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    final c = context.watch<NowPlayingController>();

    return Scaffold(
      appBar: AppBar(title: const Text('NowPlaying')),
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
