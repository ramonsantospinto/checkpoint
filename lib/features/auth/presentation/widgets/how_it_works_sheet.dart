import 'package:flutter/material.dart';

class HowItWorksSheet extends StatelessWidget {
  const HowItWorksSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget item(String title, String desc) => Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle_outline,
            color: Colors.white70,
            size: 18,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.7),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 44,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'Como funciona',
            style: theme.textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 16),
          item(
            'Login Steam',
            'Abrimos o login da Steam (OpenID) no navegador e recebemos o retorno no app.',
          ),
          item(
            'SteamID64',
            'Extraímos sua SteamID64 no servidor e salvamos no dispositivo com segurança.',
          ),
          item(
            'Dados do jogo',
            'Com a SteamID64 consultamos horas, jogo atual e progresso de conquistas.',
          ),
        ],
      ),
    );
  }
}
