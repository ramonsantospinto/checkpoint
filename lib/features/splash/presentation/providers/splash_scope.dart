import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../controller/splash_controller.dart';

class SplashScope extends StatelessWidget {
  final Widget child;
  const SplashScope({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SplashController()..init(),
      child: child,
    );
  }
}
