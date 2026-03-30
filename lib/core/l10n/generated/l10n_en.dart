// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SEn extends S {
  SEn([String locale = 'en']) : super(locale);

  @override
  String get common_appTitle => 'Flutter Clean Template';

  @override
  String get common_loading => 'Loading...';

  @override
  String get common_emptyList => 'No items found.';

  @override
  String get common_pageNotFound => 'Page not found';

  @override
  String get btn_retry => 'Retry';

  @override
  String get btn_cancel => 'Cancel';

  @override
  String get btn_ok => 'OK';

  @override
  String get btn_save => 'Save';

  @override
  String get btn_delete => 'Delete';

  @override
  String get error_network => 'Network error. Please check your connection.';

  @override
  String get error_unauthorized => 'Session expired. Please log in again.';

  @override
  String get error_server => 'Server error. Please try again later.';

  @override
  String get error_unknown => 'An unexpected error occurred.';

  @override
  String get error_notFound => 'Resource not found.';

  @override
  String get productList_title => 'Products';

  @override
  String get productList_empty => 'No products found.';

  @override
  String get productList_searchHint => 'Search products...';

  @override
  String get productDetail_title => 'Product Detail';

  @override
  String get productDetail_addToCart => 'Add to Cart';

  @override
  String get auth_login => 'Log In';

  @override
  String get auth_logout => 'Log Out';

  @override
  String get auth_emailHint => 'Enter your email';

  @override
  String get auth_passwordHint => 'Enter your password';
}
