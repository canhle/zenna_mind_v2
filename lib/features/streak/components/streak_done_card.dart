import 'package:flutter/material.dart';
import 'package:flutter_clean_template/core/extensions/context_extensions.dart';
import 'package:flutter_clean_template/core/l10n/generated/l10n.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_colors.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_radius.dart';
import 'package:flutter_clean_template/features/streak/models/streak_mock_data.dart';

class StreakDoneCard extends StatelessWidget {
  const StreakDoneCard({super.key});

  static final _cardBg = DsColors.primaryDim.withValues(alpha: 0.10);
  static final _cardBorder = DsColors.primaryDim.withValues(alpha: 0.20);
  static final _statBg = Colors.white.withValues(alpha: 0.50);

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _cardBg,
        border: Border.all(color: _cardBorder, width: 1.5),
        borderRadius: DsRadius.borderRadiusLg,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: DsColors.primaryDim,
                ),
                child: const Icon(Icons.check, size: 18, color: Colors.white),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mockDoneSessionTitle,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: DsColors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Vừa hoàn thành · $mockDoneSessionTime',
                      style: context.textTheme.labelSmall?.copyWith(
                        color: DsColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _StatBox(value: mockDoneMinutes, label: l10n.streak_duration),
              const SizedBox(width: 10),
              _StatBox(value: mockDoneBreathCycles, label: l10n.streak_breathCycles),
              const SizedBox(width: 10),
              _StatBox(value: mockDoneMoodEmoji, label: l10n.streak_mood),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  const _StatBox({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: StreakDoneCard._statBg,
          borderRadius: DsRadius.borderRadiusMd,
        ),
        child: Column(
          children: [
            Text(
              value,
              style: context.textTheme.titleMedium?.copyWith(
                fontSize: 18,
                color: DsColors.onSurface,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: context.textTheme.labelSmall?.copyWith(
                fontSize: 10,
                letterSpacing: 0.8,
                color: DsColors.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
