import 'package:checkpoint/features/auth/presentation/pages/auth_page.dart';
import 'package:checkpoint/features/splash/presentation/pages/splash_page.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../features/library/presentation/pages/library_page.dart';
import '../../features/auth/presentation/controller/auth_controller.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final auth = context.read<AuthController>();
      final loggedIn = auth.steamId != null;

      final path = state.uri.path;
      final inSplash = path == '/';
      final inLogin = path == '/login';

      if (inSplash) return null;

      if (!loggedIn && !inLogin) return '/login';
      if (loggedIn && inLogin) return '/library';

      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (_, _) => const SplashPage()),
      GoRoute(path: '/login', builder: (_, _) => const LoginPage()),
      GoRoute(path: '/library', builder: (_, _) => const LibraryPage()),
    ],
  );
}
