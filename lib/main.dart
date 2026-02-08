import 'package:checkpoint/features/auth/presentation/pages/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'core/storage/secure_storage.dart';
import 'features/auth/presentation/controller/auth_controller.dart';

void main() {
  runApp(const CheckPointPreview());
}

class CheckPointPreview extends StatelessWidget {
  const CheckPointPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FlutterSecureStorage>(
          create: (_) => const FlutterSecureStorage(),
        ),
        ProxyProvider<FlutterSecureStorage, SecureStore>(
          update: (_, storage, _) => SecureStore(storage),
        ),
        ChangeNotifierProxyProvider<SecureStore, AuthController>(
          create: (_) => AuthController(),
          update: (_, store, controller) => controller!..attachStore(store),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CheckPoint',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LoginPage(),
      ),
    );
  }
}
