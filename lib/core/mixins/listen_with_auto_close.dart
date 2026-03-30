import 'package:riverpod/riverpod.dart';

mixin ListenWithAutoClose {
  void listenWithAutoClose<V>({
    required ProviderListenable<V> provider,
    required Ref ref,
    required void Function(V value) onValue,
  }) {
    ref.listen<V>(
      provider,
      (_, next) => onValue(next),
    );
  }
}
