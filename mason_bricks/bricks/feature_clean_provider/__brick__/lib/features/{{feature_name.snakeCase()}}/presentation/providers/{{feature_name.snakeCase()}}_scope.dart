import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../controller/{{feature_name.snakeCase()}}_controller.dart';

class {{feature_name.pascalCase()}}Scope extends StatelessWidget {
  final Widget child;
  const {{feature_name.pascalCase()}}Scope({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => {{feature_name.pascalCase()}}Controller()..init(),
      child: child,
    );
  }
}
