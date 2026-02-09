import 'package:checkpoint/app/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/providers/app_providers.dart';

void main() {
  runApp(const CheckPointApp());
}

class CheckPointApp extends StatelessWidget {
  const CheckPointApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: buildAppProviders(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'CheckPoint',
        theme: ThemeData(useMaterial3: true),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
