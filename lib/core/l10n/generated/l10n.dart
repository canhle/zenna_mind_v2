import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'l10n_en.dart';
import 'l10n_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of S
/// returned by `S.of(context)`.
///
/// Applications need to include `S.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/l10n.dart';
///
/// return MaterialApp(
///   localizationsDelegates: S.localizationsDelegates,
///   supportedLocales: S.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the S.supportedLocales
/// property.
abstract class S {
  S(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static S? of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  static const LocalizationsDelegate<S> delegate = _SDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Flutter Clean Template'**
  String get common_appTitle;

  /// Loading text
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get common_loading;

  /// Empty list message
  ///
  /// In en, this message translates to:
  /// **'No items found.'**
  String get common_emptyList;

  /// 404 page title
  ///
  /// In en, this message translates to:
  /// **'Page not found'**
  String get common_pageNotFound;

  /// Retry button text
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get btn_retry;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get btn_cancel;

  /// OK button text
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get btn_ok;

  /// Save button text
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get btn_save;

  /// Delete button text
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get btn_delete;

  /// Network error message
  ///
  /// In en, this message translates to:
  /// **'Network error. Please check your connection.'**
  String get error_network;

  /// Unauthorized error message
  ///
  /// In en, this message translates to:
  /// **'Session expired. Please log in again.'**
  String get error_unauthorized;

  /// Server error message
  ///
  /// In en, this message translates to:
  /// **'Server error. Please try again later.'**
  String get error_server;

  /// Unknown error message
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred.'**
  String get error_unknown;

  /// Not found error message
  ///
  /// In en, this message translates to:
  /// **'Resource not found.'**
  String get error_notFound;

  /// Product list screen title
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get productList_title;

  /// Product list empty state
  ///
  /// In en, this message translates to:
  /// **'No products found.'**
  String get productList_empty;

  /// Product search field hint
  ///
  /// In en, this message translates to:
  /// **'Search products...'**
  String get productList_searchHint;

  /// Product detail screen title
  ///
  /// In en, this message translates to:
  /// **'Product Detail'**
  String get productDetail_title;

  /// Add to cart button
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get productDetail_addToCart;

  /// Login button text
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get auth_login;

  /// Logout button text
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get auth_logout;

  /// Email input hint
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get auth_emailHint;

  /// Password input hint
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get auth_passwordHint;

  /// Welcome screen badge text
  ///
  /// In en, this message translates to:
  /// **'Peace'**
  String get welcome_badge;

  /// Welcome screen social proof stats
  ///
  /// In en, this message translates to:
  /// **'Over 1 million people practice every day'**
  String get welcome_stats;

  /// Welcome screen greeting
  ///
  /// In en, this message translates to:
  /// **'Welcome to'**
  String get welcome_greeting;

  /// Welcome screen app name
  ///
  /// In en, this message translates to:
  /// **'Meditation App'**
  String get welcome_appName;

  /// Welcome screen subtitle
  ///
  /// In en, this message translates to:
  /// **'Start your journey to inner peace and find balance in your soul.'**
  String get welcome_subtitle;

  /// Welcome screen CTA button
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get welcome_cta;

  /// Welcome screen copyright
  ///
  /// In en, this message translates to:
  /// **'© 2024 Thiền Sanctuary'**
  String get welcome_copyright;

  /// Welcome screen privacy link
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get welcome_privacy;

  /// Welcome screen terms link
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get welcome_terms;

  /// Home screen app name in app bar
  ///
  /// In en, this message translates to:
  /// **'DIGITAL SANCTUARY'**
  String get home_appName;

  /// Morning greeting
  ///
  /// In en, this message translates to:
  /// **'Good morning, {name} 🌤️'**
  String home_greetingMorning(String name);

  /// Afternoon greeting
  ///
  /// In en, this message translates to:
  /// **'Good afternoon, {name} ☀️'**
  String home_greetingAfternoon(String name);

  /// Evening greeting
  ///
  /// In en, this message translates to:
  /// **'Good evening, {name} 🌙'**
  String home_greetingEvening(String name);

  /// Home greeting subtitle
  ///
  /// In en, this message translates to:
  /// **'Take a deep breath...'**
  String get home_greetingSubtitle;

  /// Mood selector section label
  ///
  /// In en, this message translates to:
  /// **'HOW ARE YOU FEELING?'**
  String get home_moodLabel;

  /// Happy mood label
  ///
  /// In en, this message translates to:
  /// **'Happy'**
  String get home_moodHappy;

  /// Anxious mood label
  ///
  /// In en, this message translates to:
  /// **'Anxious'**
  String get home_moodAnxious;

  /// Tired mood label
  ///
  /// In en, this message translates to:
  /// **'Tired'**
  String get home_moodTired;

  /// Stressed mood label
  ///
  /// In en, this message translates to:
  /// **'Stressed'**
  String get home_moodStressed;

  /// Peaceful mood label
  ///
  /// In en, this message translates to:
  /// **'Peaceful'**
  String get home_moodPeaceful;

  /// Daily meditation card label
  ///
  /// In en, this message translates to:
  /// **'TODAY\'S EXERCISE'**
  String get home_dailyLabel;

  /// Start meditation button
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get home_startButton;

  /// Continue listening card title
  ///
  /// In en, this message translates to:
  /// **'Continue listening'**
  String get home_continueTitle;

  /// Daily streak card title
  ///
  /// In en, this message translates to:
  /// **'Daily streak'**
  String get home_streakTitle;

  /// Daily streak count
  ///
  /// In en, this message translates to:
  /// **'{count} days in a row'**
  String home_streakCount(int count);

  /// Streak week label
  ///
  /// In en, this message translates to:
  /// **'THIS WEEK'**
  String get home_streakWeek;

  /// Bottom nav home tab
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home_navHome;

  /// Bottom nav browse tab
  ///
  /// In en, this message translates to:
  /// **'Browse'**
  String get home_navBrowse;

  /// Bottom nav favorites tab
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get home_navFavorites;

  /// Bottom nav settings tab
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get home_navSettings;

  /// Browse search placeholder
  ///
  /// In en, this message translates to:
  /// **'Search meditations...'**
  String get browser_searchHint;

  /// Browse trending section title
  ///
  /// In en, this message translates to:
  /// **'Trending'**
  String get browser_trending;

  /// Browse view all link
  ///
  /// In en, this message translates to:
  /// **'VIEW ALL'**
  String get browser_viewAll;

  /// Browse topics tab
  ///
  /// In en, this message translates to:
  /// **'Topics'**
  String get browser_tabTopics;

  /// Browse moods tab
  ///
  /// In en, this message translates to:
  /// **'Moods'**
  String get browser_tabMoods;
}

class _SDelegate extends LocalizationsDelegate<S> {
  const _SDelegate();

  @override
  Future<S> load(Locale locale) {
    return SynchronousFuture<S>(lookupS(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_SDelegate old) => false;
}

S lookupS(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return SEn();
    case 'vi':
      return SVi();
  }

  throw FlutterError(
    'S.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
