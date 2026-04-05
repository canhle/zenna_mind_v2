import 'package:flutter/material.dart';
import 'package:flutter_clean_template/core/extensions/context_extensions.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_colors.dart';

/// A reusable top bar with a translucent back button and centered title.
/// Sized to match standard AppBar height (kToolbarHeight = 56).
class GlassTopBar extends StatelessWidget {
  const GlassTopBar({
    super.key,
    required this.title,
    required this.onBackTapped,
    this.trailing,
  });

  final String title;
  final VoidCallback onBackTapped;
  final Widget? trailing;

  static final _btnBg = Colors.white.withValues(alpha: 0.45);
  static final _btnBorder = Colors.white.withValues(alpha: 0.60);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 40,
              height: 40,
              child: Material(
                color: _btnBg,
                shape: CircleBorder(side: BorderSide(color: _btnBorder)),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: onBackTapped,
                  child: const Icon(
                    Icons.chevron_left,
                    size: 22,
                    color: DsColors.onSurface,
                  ),
                ),
              ),
            ),
          ),
          Text(
            title,
            style: context.textTheme.titleLarge?.copyWith(
              color: DsColors.onSurface,
            ),
          ),
          if (trailing != null)
            Align(
              alignment: Alignment.centerRight,
              child: trailing,
            ),
        ],
      ),
    );
  }
}
