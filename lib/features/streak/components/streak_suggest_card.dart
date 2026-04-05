import 'package:flutter/material.dart';
import 'package:flutter_clean_template/core/extensions/context_extensions.dart';
import 'package:flutter_clean_template/core/l10n/generated/l10n.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_radius.dart';
import 'package:flutter_clean_template/features/streak/models/streak_mock_data.dart';

class StreakSuggestCard extends StatelessWidget {
  const StreakSuggestCard({super.key});

  static const _gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1A5C42), Color(0xFF0A3D28)],
  );
  static final _decoColor = Colors.white.withValues(alpha: 0.06);
  static final _labelColor = Colors.white.withValues(alpha: 0.50);
  static final _metaColor = Colors.white.withValues(alpha: 0.65);

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;

    return ClipRRect(
      borderRadius: DsRadius.borderRadiusLg,
      child: DecoratedBox(
        decoration: const BoxDecoration(gradient: _gradient),
        child: Stack(
          children: [
            Positioned(
              top: -40,
              right: -30,
              child: SizedBox(
                width: 120,
                height: 120,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _decoColor,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -20,
              left: 20,
              child: SizedBox(
                width: 70,
                height: 70,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _decoColor,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.streak_suggestLabel,
                    style: context.textTheme.labelSmall?.copyWith(
                      letterSpacing: 1.2,
                      color: _labelColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    mockSuggestTitle,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _MetaChip(icon: Icons.access_time, text: mockSuggestDuration),
                      const SizedBox(width: 12),
                      _MetaChip(icon: Icons.person, text: mockSuggestType),
                      const SizedBox(width: 12),
                      _MetaChip(icon: Icons.music_note, text: mockSuggestSound),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: StreakSuggestCard._metaColor),
        const SizedBox(width: 4),
        Text(
          text,
          style: context.textTheme.labelSmall?.copyWith(
            color: StreakSuggestCard._metaColor,
          ),
        ),
      ],
    );
  }
}
