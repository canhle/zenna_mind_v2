import 'package:flutter/material.dart';

/// Custom icon set for the app.
///
/// Replace with your own icons from Figma export (SVG → icon font or flutter_svg).
/// This class provides a centralized place to reference all custom icons.
///
/// For now, uses Material Icons as placeholders.
abstract class DsIcons {
  // Navigation
  static const IconData back = Icons.arrow_back;
  static const IconData close = Icons.close;
  static const IconData menu = Icons.menu;

  // Actions
  static const IconData search = Icons.search;
  static const IconData filter = Icons.filter_list;
  static const IconData sort = Icons.sort;
  static const IconData share = Icons.share;
  static const IconData edit = Icons.edit_outlined;
  static const IconData delete = Icons.delete_outline;
  static const IconData add = Icons.add;

  // Status
  static const IconData success = Icons.check_circle_outline;
  static const IconData error = Icons.error_outline;
  static const IconData warning = Icons.warning_amber;
  static const IconData info = Icons.info_outline;

  // Common
  static const IconData home = Icons.home_outlined;
  static const IconData settings = Icons.settings_outlined;
  static const IconData profile = Icons.person_outline;
  static const IconData notification = Icons.notifications_outlined;
  static const IconData cart = Icons.shopping_cart_outlined;
  static const IconData favorite = Icons.favorite_border;
  static const IconData favoriteFilled = Icons.favorite;
}
