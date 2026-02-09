import 'package:checkpoint/features/auth/domain/usecases/login_with_steam_usecase.dart';
import 'package:checkpoint/features/auth/presentation/widgets/error_box.dart';
import 'package:checkpoint/features/auth/presentation/widgets/glass_card.dart';
import 'package:checkpoint/features/auth/presentation/widgets/how_it_works_sheet.dart';
import 'package:checkpoint/features/auth/presentation/widgets/login_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
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
    } on Exception catch (e) {
      if (!mounted) return;
      setState(() => _error = _getErrorMessage(e));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  String _getErrorMessage(Exception e) {
    if (e.toString().contains('canceled')) {
      return 'Login cancelado';
    }
    if (e.toString().contains('network')) {
      return 'Erro de conexão. Verifique sua internet.';
    }
    return 'Erro ao fazer login. Tente novamente.';
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
    return LoginBackground(
      child: _LoginContent(
        isLoading: _loading,
        error: _error,
        onLogin: _login,
        onOpenHowItWorks: _openHowItWorks,
      ),
    );
  }
}

class _LoginContent extends StatelessWidget {
  final bool isLoading;
  final String? error;
  final VoidCallback onLogin;
  final VoidCallback onOpenHowItWorks;

  const _LoginContent({
    required this.isLoading,
    required this.error,
    required this.onLogin,
    required this.onOpenHowItWorks,
  });

  Future<void> _openPortfolio() async {
    final uri = Uri.parse('https://ramondeveloper.web.app');
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final year = DateTime.now().year;

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 24,
                  ),
                  child: GlassCard(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 6),
                        Hero(
                          tag: 'cp-logo',
                          child: SizedBox(
                            width: 52,
                            height: 52,
                            child: Image.asset(
                              'assets/images/mobile_game.png',
                              fit: BoxFit.contain,
                              filterQuality: FilterQuality.high,
                              color: Colors.white.withValues(alpha: 0.92),
                              colorBlendMode: BlendMode.srcIn,
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          'CheckPoint',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.4,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Entre com sua Steam para ver jogo atual, horas jogadas e progresso de conquistas.',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withValues(alpha: 0.72),
                            height: 1.35,
                          ),
                        ),
                        const SizedBox(height: 22),
                        if (error != null) ...[
                          ErrorBox(message: error!),
                          const SizedBox(height: 12),
                        ],
                        _LoginButton(isLoading: isLoading, onPressed: onLogin),
                        const SizedBox(height: 14),
                        _HowItWorksButton(
                          isLoading: isLoading,
                          onPressed: onOpenHowItWorks,
                          theme: theme,
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
          ),
          _Footer(year: year, theme: theme, onOpenPortfolio: _openPortfolio),
        ],
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const _LoginButton({required this.isLoading, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
        onPressed: isLoading ? null : onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading) ...[
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
    );
  }
}

class _HowItWorksButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  final ThemeData theme;

  const _HowItWorksButton({
    required this.isLoading,
    required this.onPressed,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: BorderSide(color: Colors.white.withValues(alpha: 0.12)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child: Text(
          'Como funciona?',
          style: theme.textTheme.labelLarge?.copyWith(
            color: Colors.white.withValues(alpha: 0.92),
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final int year;
  final ThemeData theme;
  final VoidCallback onOpenPortfolio;

  const _Footer({
    required this.year,
    required this.theme,
    required this.onOpenPortfolio,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 4,
        runSpacing: 4,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            '© $year Ramon Santos. Todos os direitos reservados.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.white.withValues(alpha: 0.45),
              height: 1.2,
            ),
          ),
          InkWell(
            onTap: onOpenPortfolio,
            borderRadius: BorderRadius.circular(999),
            child: const Padding(
              padding: EdgeInsets.only(left: 2, right: 2, top: 2, bottom: 2),
              child: Text('🎮', style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}
