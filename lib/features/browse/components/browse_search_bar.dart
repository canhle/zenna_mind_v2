import 'package:flutter/material.dart';
import 'package:flutter_clean_template/core/extensions/context_extensions.dart';
import 'package:flutter_clean_template/core/l10n/generated/l10n.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_colors.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_radius.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_spacing.dart';

class BrowseSearchBar extends StatelessWidget {
  const BrowseSearchBar({super.key, required this.onChanged});

  final ValueChanged<String> onChanged;

  static final _borderColor = DsColors.primary.withValues(alpha: 0.10);
  static final _shadowColor = DsColors.primary.withValues(alpha: 0.05);
  static final _iconColor = DsColors.primary.withValues(alpha: 0.60);
  static final _focusBorderColor = DsColors.primary.withValues(alpha: 0.40);

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DsSpacing.lg),
      child: DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: _shadowColor,
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: l10n.browser_searchHint,
            hintStyle: context.textTheme.bodyLarge?.copyWith(
              color: DsColors.outlineVariant,
            ),
            prefixIcon: Icon(Icons.search, color: _iconColor),
            filled: true,
            fillColor: DsColors.surfaceContainerLowest,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: DsSpacing.lg,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(DsRadius.xl),
              borderSide: BorderSide(color: _borderColor, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(DsRadius.xl),
              borderSide: BorderSide(color: _borderColor, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(DsRadius.xl),
              borderSide: BorderSide(color: _focusBorderColor, width: 1.5),
            ),
          ),
        ),
      ),
    );
  }
}
