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

  @override
  String get welcome_badge => 'Peace';

  @override
  String get welcome_stats => 'Over 1 million people practice every day';

  @override
  String get welcome_greeting => 'Welcome to';

  @override
  String get welcome_appName => 'Meditation App';

  @override
  String get welcome_subtitle =>
      'Start your journey to inner peace and find balance in your soul.';

  @override
  String get welcome_cta => 'Get Started';

  @override
  String get welcome_copyright => '© 2024 Thiền Sanctuary';

  @override
  String get welcome_privacy => 'Privacy Policy';

  @override
  String get welcome_terms => 'Terms of Use';

  @override
  String get home_appName => 'DIGITAL SANCTUARY';

  @override
  String home_greetingMorning(String name) {
    return 'Good morning, $name 🌤️';
  }

  @override
  String home_greetingAfternoon(String name) {
    return 'Good afternoon, $name ☀️';
  }

  @override
  String home_greetingEvening(String name) {
    return 'Good evening, $name 🌙';
  }

  @override
  String get home_greetingSubtitle => 'Take a deep breath...';

  @override
  String get home_moodLabel => 'HOW ARE YOU FEELING?';

  @override
  String get home_moodHappy => 'Happy';

  @override
  String get home_moodAnxious => 'Anxious';

  @override
  String get home_moodTired => 'Tired';

  @override
  String get home_moodStressed => 'Stressed';

  @override
  String get home_moodPeaceful => 'Peaceful';

  @override
  String get home_dailyLabel => 'TODAY\'S EXERCISE';

  @override
  String get home_startButton => 'Start';

  @override
  String get home_continueTitle => 'Continue listening';

  @override
  String get home_streakTitle => 'Daily streak';

  @override
  String home_streakCount(int count) {
    return '$count days in a row';
  }

  @override
  String get home_streakWeek => 'THIS WEEK';

  @override
  String get home_navHome => 'Home';

  @override
  String get home_navBrowse => 'Browse';

  @override
  String get home_navFavorites => 'Favorites';

  @override
  String get home_navSettings => 'Settings';

  @override
  String get browser_searchHint => 'Search meditations...';

  @override
  String get browser_trending => 'Trending';

  @override
  String get browser_viewAll => 'VIEW ALL';

  @override
  String get browser_tabTopics => 'Topics';

  @override
  String get browser_tabMoods => 'Moods';

  @override
  String get player_nowPlaying => 'NOW PLAYING';

  @override
  String get streak_title => 'Build your habit';

  @override
  String get streak_days => 'days';

  @override
  String get streak_minutes => 'min';

  @override
  String get streak_today => 'TODAY';

  @override
  String get streak_suggestLabel => 'TODAY\'S SUGGESTION';

  @override
  String get streak_notDoneYet => 'Not meditated yet';

  @override
  String get streak_completed => 'Completed ✓';

  @override
  String streak_dayCount(int count) {
    return 'Day $count';
  }

  @override
  String get streak_startToday => 'Start meditating today';

  @override
  String get streak_doAnother => 'Meditate one more session';

  @override
  String get streak_goHome => 'Back to home';

  @override
  String get streak_duration => 'DURATION';

  @override
  String get streak_breathCycles => 'BREATH CYCLES';

  @override
  String get streak_mood => 'MOOD';

  @override
  String get meditationComplete_title => 'You\'ve completed\nthe meditation!';

  @override
  String get meditationComplete_moodLabel => 'How are you feeling?';

  @override
  String get meditationComplete_moodPeaceful => 'Peaceful';

  @override
  String get meditationComplete_moodRefreshed => 'Refreshed';

  @override
  String get meditationComplete_moodRelaxed => 'Relaxed';

  @override
  String get meditationComplete_moodHappier => 'Happier';

  @override
  String get meditationComplete_nextCta => 'Explore the next session';

  @override
  String get meditationComplete_homeCta => 'Back to home';
}
