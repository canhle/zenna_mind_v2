import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_template/core/extensions/context_extensions.dart';
import 'package:flutter_clean_template/core/l10n/generated/l10n.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_colors.dart';
import 'package:flutter_clean_template/features/streak/models/streak_mock_data.dart';
import 'package:flutter_clean_template/features/streak/streak_view_model.dart';

class StreakCalendarCard extends ConsumerWidget {
  const StreakCalendarCard({super.key});

  static final _cardBg = Colors.white.withValues(alpha: 0.50);
  static final _cardBorder = Colors.white.withValues(alpha: 0.60);
  static final _todayGlow = DsColors.primaryDim.withValues(alpha: 0.12);
  static final _todayDoneGlow = DsColors.primaryDim.withValues(alpha: 0.18);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = S.of(context)!;
    final (weekDays, isTodayDone) = ref.watch(
      streakViewModelProvider.select((s) => (s.weekDays, s.isTodayCompleted)),
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        color: _cardBg,
        border: Border.all(color: _cardBorder),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.home_streakWeek,
            style: context.textTheme.labelSmall?.copyWith(
              letterSpacing: 1.2,
              color: DsColors.outline,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(7, (i) {
              final isToday = i == 6;
              final isDone = weekDays[i];

              return Expanded(
                child: Column(
                  children: [
                  Text(
                    mockWeekDayNames[i],
                    style: context.textTheme.labelSmall?.copyWith(
                      fontSize: 9,
                      color: DsColors.outline,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _CalendarDot(
                    isDone: isDone,
                    isToday: isToday,
                    isTodayDone: isTodayDone,
                    dayNumber: i + 1,
                  ),
                ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _CalendarDot extends StatelessWidget {
  const _CalendarDot({
    required this.isDone,
    required this.isToday,
    required this.isTodayDone,
    required this.dayNumber,
  });

  final bool isDone;
  final bool isToday;
  final bool isTodayDone;
  final int dayNumber;

  @override
  Widget build(BuildContext context) {
    if (isToday && !isTodayDone) {
      return Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: DsColors.primaryDim, width: 2.5),
          boxShadow: [
            BoxShadow(
              color: StreakCalendarCard._todayGlow,
              spreadRadius: 4,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          '$dayNumber',
          style: context.textTheme.labelSmall?.copyWith(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: DsColors.onSurface,
          ),
        ),
      );
    }

    if (isToday && isTodayDone) {
      return Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: DsColors.primaryDim,
          boxShadow: [
            BoxShadow(
              color: StreakCalendarCard._todayDoneGlow,
              blurRadius: 6,
              spreadRadius: 4,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: const Icon(Icons.check, size: 13, color: Colors.white),
      );
    }

    if (isDone) {
      return Container(
        width: 32,
        height: 32,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: DsColors.primaryDim,
        ),
        alignment: Alignment.center,
        child: const Icon(Icons.check, size: 13, color: Colors.white),
      );
    }

    return const SizedBox(width: 32, height: 32);
  }
}
