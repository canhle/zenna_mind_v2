import 'package:flutter/material.dart';
import 'package:flutter_clean_template/core/extensions/context_extensions.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_colors.dart';

class HomeMoodItem extends StatelessWidget {
  const HomeMoodItem({
    super.key,
    required this.emoji,
    required this.label,
    required this.backgroundColor,
    required this.isSelected,
    required this.onTap,
  });

  final String emoji;
  final String label;
  final Color backgroundColor;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedScale(
            scale: isSelected ? 1.1 : 1.0,
            duration: const Duration(milliseconds: 200),
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: backgroundColor,
                border: isSelected
                    ? Border.all(color: Colors.white, width: 4)
                    : null,
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: DsColors.primary.withValues(alpha: 0.15),
                          blurRadius: 8,
                        ),
                      ]
                    : null,
              ),
              alignment: Alignment.center,
              child: Text(emoji, style: const TextStyle(fontSize: 24)),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: context.textTheme.labelSmall?.copyWith(
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? DsColors.primary : DsColors.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
