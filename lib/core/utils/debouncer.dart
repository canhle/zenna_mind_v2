import 'dart:async';
import 'dart:ui';

class Debouncer {
  Debouncer({this.duration = Debouncer.defaultDuration});

  static const Duration defaultDuration = Duration(milliseconds: 500);
  static const Duration uiDuration = Duration(milliseconds: 300);

  final Duration duration;
  Timer? _timer;

  void call(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(duration, action);
  }

  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}
