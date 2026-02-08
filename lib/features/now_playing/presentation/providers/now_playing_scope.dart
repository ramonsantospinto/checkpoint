import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../controller/now_playing_controller.dart';

class NowPlayingScope extends StatelessWidget {
  final Widget child;
  const NowPlayingScope({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NowPlayingController()..init(),
      child: child,
    );
  }
}
