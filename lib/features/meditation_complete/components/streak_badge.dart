import 'package:flutter/material.dart';
import 'package:flutter_clean_template/core/extensions/context_extensions.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_colors.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_radius.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_spacing.dart';

class StreakBadge extends StatelessWidget {
  const StreakBadge({super.key, required this.streakText});

  final String streakText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: DsSpacing.md, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0x8CFFFFFF), // rgba(255,255,255,0.55)
        borderRadius: BorderRadius.circular(DsRadius.xl),
        border: Border.all(
          width: 1.5,
          color: const Color(0x330A643C), // rgba(10,100,60,0.20)
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🔥', style: TextStyle(fontSize: 18)),
          const SizedBox(width: 7),
          Text(
            streakText,
            style: context.textTheme.titleSmall?.copyWith(
              color: DsColors.completionText,
            ),
          ),
        ],
      ),
    );
  }
}
