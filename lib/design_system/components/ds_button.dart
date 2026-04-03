import 'package:flutter/material.dart';
import 'package:flutter_clean_template/core/extensions/context_extensions.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_colors.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_radius.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_spacing.dart';

enum DsButtonVariant { primary, secondary, text }

enum DsButtonSize { small, medium, large }

class DsButton extends StatelessWidget {
  const DsButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = DsButtonVariant.primary,
    this.size = DsButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.isExpanded = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final DsButtonVariant variant;
  final DsButtonSize size;
  final IconData? icon;
  final bool isLoading;
  final bool isExpanded;

  static final _primaryGlowShadow = [
    BoxShadow(
      color: DsColors.primary.withValues(alpha: 0.30),
      blurRadius: 35,
      offset: const Offset(0, 15),
    ),
  ];

  bool get _disabled => onPressed == null || isLoading;

  double get _height => switch (size) {
        DsButtonSize.small => 40.0,
        DsButtonSize.medium => 52.0,
        DsButtonSize.large => 60.0,
      };

  double get _fontSize => switch (size) {
        DsButtonSize.small => 14.0,
        DsButtonSize.medium => 16.0,
        DsButtonSize.large => 18.0,
      };

  EdgeInsets get _padding => switch (size) {
        DsButtonSize.small =>
          const EdgeInsets.symmetric(horizontal: DsSpacing.md),
        DsButtonSize.medium =>
          const EdgeInsets.symmetric(horizontal: DsSpacing.lg),
        DsButtonSize.large =>
          const EdgeInsets.symmetric(horizontal: DsSpacing.xl),
      };

  @override
  Widget build(BuildContext context) {
    return switch (variant) {
      DsButtonVariant.primary => _buildPrimary(context),
      DsButtonVariant.secondary => _buildSecondary(context),
      DsButtonVariant.text => _buildText(context),
    };
  }

  Widget _buildPrimary(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: _disabled
            ? null
            : const LinearGradient(
                colors: [DsColors.primaryDim, DsColors.primary],
              ),
        color: _disabled ? DsColors.outline : null,
        borderRadius: DsRadius.borderRadiusLg,
        boxShadow: _disabled ? null : _primaryGlowShadow,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _disabled ? null : onPressed,
          borderRadius: DsRadius.borderRadiusLg,
          child: _buildContent(
            context: context,
            textColor: _disabled ? DsColors.onSurfaceVariant : DsColors.onPrimary,
            spinnerColor: DsColors.onPrimary,
          ),
        ),
      ),
    );
  }

  Widget _buildSecondary(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: DsRadius.borderRadiusLg,
        border: Border.all(
          color: _disabled ? DsColors.outline : DsColors.primary,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _disabled ? null : onPressed,
          borderRadius: DsRadius.borderRadiusLg,
          child: _buildContent(
            context: context,
            textColor: _disabled ? DsColors.outline : DsColors.primary,
            spinnerColor: DsColors.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    final textColor = _disabled ? DsColors.outline : DsColors.primary;
    return TextButton(
      onPressed: _disabled ? null : onPressed,
      style: TextButton.styleFrom(
        minimumSize: Size(isExpanded ? double.infinity : 0, _height),
        padding: _padding,
      ),
      child: _buildLabel(
        context: context,
        textColor: textColor,
        spinnerColor: DsColors.primary,
      ),
    );
  }

  Widget _buildContent({
    required BuildContext context,
    required Color textColor,
    required Color spinnerColor,
  }) {
    return SizedBox(
      width: isExpanded ? double.infinity : null,
      height: _height,
      child: Padding(
        padding: _padding,
        child: Align(
          child: _buildLabel(
            context: context,
            textColor: textColor,
            spinnerColor: spinnerColor,
          ),
        ),
      ),
    );
  }

  Widget _buildLabel({
    required BuildContext context,
    required Color textColor,
    required Color spinnerColor,
  }) {
    if (isLoading) return _buildSpinner(spinnerColor);

    final labelStyle = context.textTheme.labelLarge?.copyWith(
      fontSize: _fontSize,
      fontWeight: FontWeight.w700,
      color: textColor,
      letterSpacing: 1.0,
    );

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: textColor),
          const SizedBox(width: DsSpacing.sm),
          Text(label, style: labelStyle),
        ],
      );
    }

    return Text(label, style: labelStyle);
  }

  Widget _buildSpinner(Color color) {
    return SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(strokeWidth: 2, color: color),
    );
  }
}
