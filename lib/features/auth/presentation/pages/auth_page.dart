import 'package:checkpoint/features/auth/domain/usecases/login_with_steam_usecase.dart';
import 'package:checkpoint/features/auth/presentation/widgets/brand_header.dart';
import 'package:checkpoint/features/auth/presentation/widgets/error_box.dart';
import 'package:checkpoint/features/auth/presentation/widgets/glass_card.dart';
import 'package:checkpoint/features/auth/presentation/widgets/how_it_works_sheet.dart';
import 'package:checkpoint/features/auth/presentation/widgets/login_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/config/env.dart';
import '../../../../core/network/dio_client.dart';
import '../controller/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loading = false;
  String? _error;

  Future<void> _login() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final dio = DioClient(baseUrl: Env.apiBaseUrl).dio;
      final usecase = LoginWithSteamUsecase(dio);

      final authUrl = await usecase.getAuthUrl(
        callbackScheme: Env.authCallbackScheme,
      );

      final resultUrl = await FlutterWebAuth2.authenticate(
        url: authUrl,
        callbackUrlScheme: Env.authCallbackScheme,
      );

      final steamId64 = await usecase.verifyAndGetSteamId(resultUrl: resultUrl);

      if (!mounted) return;

      await context.read<AuthController>().setSteamId(steamId64);

      if (mounted) context.go('/library');
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _openHowItWorks() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF111118),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (_) => const HowItWorksSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Theme.of(context);

    return const LoginBackground(child: _LoginContent());
  }
}

class _LoginContent extends StatelessWidget {
  const _LoginContent();

  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_LoginPageState>()!;
    final theme = Theme.of(context);

    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
            child: GlassCard(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 6),
                  const BrandHeader(
                    title: 'CheckPoint',
                    subtitle:
                        'Entre com sua Steam para ver jogo atual, horas jogadas e progresso de conquistas.',
                  ),
                  const SizedBox(height: 22),

                  if (state._error != null) ...[
                    ErrorBox(message: state._error!),
                    const SizedBox(height: 12),
                  ],

                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        elevation: 0,
                      ),
                      onPressed: state._loading ? null : state._login,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (state._loading) ...[
                            const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Conectando...',
                              style: TextStyle(
                                fontSize: 15.5,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ] else ...[
                            const Icon(Icons.login, size: 20),
                            const SizedBox(width: 10),
                            const Text(
                              'Entrar com Steam',
                              style: TextStyle(
                                fontSize: 15.5,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: BorderSide(
                          color: Colors.white.withValues(alpha: 0.12),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      onPressed: state._loading ? null : state._openHowItWorks,
                      child: Text(
                        'Como funciona?',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: Colors.white.withValues(alpha: 0.92),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  Text(
                    'Segurança: sua API key fica no servidor (Firebase).\nO app salva apenas sua SteamID64 no dispositivo.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white.withValues(alpha: 0.55),
                      height: 1.35,
                    ),
                  ),

                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
