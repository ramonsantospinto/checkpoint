import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../controller/library_controller.dart';

class LibraryScope extends StatelessWidget {
  final Widget child;
  const LibraryScope({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LibraryController()..init(),
      child: child,
    );
  }
}
