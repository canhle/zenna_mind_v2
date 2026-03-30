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
}
