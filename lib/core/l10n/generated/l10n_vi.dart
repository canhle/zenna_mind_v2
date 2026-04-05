// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class SVi extends S {
  SVi([String locale = 'vi']) : super(locale);

  @override
  String get common_appTitle => 'Flutter Clean Template';

  @override
  String get common_loading => 'Đang tải...';

  @override
  String get common_emptyList => 'Không có mục nào.';

  @override
  String get common_pageNotFound => 'Không tìm thấy trang';

  @override
  String get btn_retry => 'Thử lại';

  @override
  String get btn_cancel => 'Hủy';

  @override
  String get btn_ok => 'OK';

  @override
  String get btn_save => 'Lưu';

  @override
  String get btn_delete => 'Xóa';

  @override
  String get error_network => 'Lỗi mạng. Vui lòng kiểm tra kết nối.';

  @override
  String get error_unauthorized =>
      'Phiên đăng nhập hết hạn. Vui lòng đăng nhập lại.';

  @override
  String get error_server => 'Lỗi máy chủ. Vui lòng thử lại sau.';

  @override
  String get error_unknown => 'Đã xảy ra lỗi không mong muốn.';

  @override
  String get error_notFound => 'Không tìm thấy tài nguyên.';

  @override
  String get productList_title => 'Sản phẩm';

  @override
  String get productList_empty => 'Không tìm thấy sản phẩm.';

  @override
  String get productList_searchHint => 'Tìm kiếm sản phẩm...';

  @override
  String get productDetail_title => 'Chi tiết sản phẩm';

  @override
  String get productDetail_addToCart => 'Thêm vào giỏ hàng';

  @override
  String get auth_login => 'Đăng nhập';

  @override
  String get auth_logout => 'Đăng xuất';

  @override
  String get auth_emailHint => 'Nhập email của bạn';

  @override
  String get auth_passwordHint => 'Nhập mật khẩu của bạn';

  @override
  String get welcome_badge => 'Bình an';

  @override
  String get welcome_stats => 'Hơn 1 triệu người đang luyện tập mỗi ngày';

  @override
  String get welcome_greeting => 'Chào mừng bạn đến với';

  @override
  String get welcome_appName => 'Ứng dụng Thiền';

  @override
  String get welcome_subtitle =>
      'Hãy bắt đầu hành trình bình an của bạn và tìm lại sự cân bằng trong tâm hồn.';

  @override
  String get welcome_cta => 'Bắt đầu';

  @override
  String get welcome_copyright => '© 2024 Thiền Sanctuary';

  @override
  String get welcome_privacy => 'Chính sách bảo mật';

  @override
  String get welcome_terms => 'Điều khoản sử dụng';

  @override
  String get home_appName => 'DIGITAL SANCTUARY';

  @override
  String home_greetingMorning(String name) {
    return 'Chào buổi sáng, $name 🌤️';
  }

  @override
  String home_greetingAfternoon(String name) {
    return 'Chào buổi chiều, $name ☀️';
  }

  @override
  String home_greetingEvening(String name) {
    return 'Chào buổi tối, $name 🌙';
  }

  @override
  String get home_greetingSubtitle => 'Hít một hơi thật sâu...';

  @override
  String get home_moodLabel => 'BẠN CẢM THẤY THẾ NÀO?';

  @override
  String get home_moodHappy => 'Vui';

  @override
  String get home_moodAnxious => 'Lo lắng';

  @override
  String get home_moodTired => 'Mệt mỏi';

  @override
  String get home_moodStressed => 'Căng thẳng';

  @override
  String get home_moodPeaceful => 'Bình yên';

  @override
  String get home_dailyLabel => 'BÀI TẬP HÔM NAY';

  @override
  String get home_startButton => 'Bắt đầu';

  @override
  String get home_continueTitle => 'Tiếp tục nghe';

  @override
  String get home_streakTitle => 'Chuỗi hằng ngày';

  @override
  String home_streakCount(int count) {
    return '$count ngày liên tiếp';
  }

  @override
  String get home_streakWeek => 'TUẦN NÀY';

  @override
  String get home_navHome => 'Home';

  @override
  String get home_navBrowse => 'Browse';

  @override
  String get home_navFavorites => 'Favorites';

  @override
  String get home_navSettings => 'Settings';

  @override
  String get browser_searchHint => 'Tìm bài thiền...';

  @override
  String get browser_trending => 'Xu hướng';

  @override
  String get browser_viewAll => 'XEM TẤT CẢ';

  @override
  String get browser_tabTopics => 'Chủ đề';

  @override
  String get browser_tabMoods => 'Cảm xúc';

  @override
  String get player_nowPlaying => 'ĐANG PHÁT';
}
