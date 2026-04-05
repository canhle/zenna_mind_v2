import 'package:flutter/material.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_colors.dart';

/// Player-specific color palette.
/// Reuses DsColors where possible — only keeps truly unique values.
abstract class PlayerColors {
  // Unique to player — no DsColors equivalent
  static const Color background = Color(0xFFBFE4D8);
  static final Color blobColor = Colors.white.withValues(alpha: 0.18);
  static final Color iconBtnBg = Colors.white.withValues(alpha: 0.42);
  static final Color ringCore = Colors.white.withValues(alpha: 0.46);

  // Mapped to DsColors
  static const Color textMain = DsColors.onSurface;
  static const Color textMuted = DsColors.onSurfaceVariant;
  static const Color textHint = DsColors.outline;
  static final Color skipBorder = DsColors.primary.withValues(alpha: 0.28);
  static final Color skipIcon = DsColors.primary.withValues(alpha: 0.52);
  static const Color playBg = DsColors.primaryDim;
  static final Color playShadow = DsColors.primaryDim.withValues(alpha: 0.30);
  static final Color progTrack = DsColors.primary.withValues(alpha: 0.15);
  static final Color progFill = DsColors.primary.withValues(alpha: 0.62);
  static const Color progDot = DsColors.primary;
  static final Color ringOuter = DsColors.primary.withValues(alpha: 0.20);
  static final Color ringMid = DsColors.primary.withValues(alpha: 0.12);
  static final Color ringDot = DsColors.primary.withValues(alpha: 0.36);
}
