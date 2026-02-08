import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../storage/secure_storage.dart';
import '../../features/auth/presentation/controller/auth_controller.dart';

List<SingleChildWidget> buildAppProviders() => [
  Provider<FlutterSecureStorage>(create: (_) => const FlutterSecureStorage()),

  ProxyProvider<FlutterSecureStorage, SecureStore>(
    update: (_, storage, _) => SecureStore(storage),
  ),

  ChangeNotifierProxyProvider<SecureStore, AuthController>(
    create: (_) => AuthController(),
    update: (_, store, controller) => controller!..attachStore(store),
  ),
];
