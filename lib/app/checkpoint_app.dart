import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes/app_router.dart';

class CheckPointApp extends StatelessWidget {
  const CheckPointApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: buildAppProviders(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'CheckPoint',
        routerConfig: AppRouter.router,
      ),
    );
  }
}
