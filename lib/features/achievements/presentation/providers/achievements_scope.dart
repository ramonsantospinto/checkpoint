import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../controller/achievements_controller.dart';

class AchievementsScope extends StatelessWidget {
  final Widget child;
  const AchievementsScope({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AchievementsController()..init(),
      child: child,
    );
  }
}
