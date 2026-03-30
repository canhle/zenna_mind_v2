import 'package:riverpod/riverpod.dart';

ProviderContainer createContainer({
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  final container = ProviderContainer(
    overrides: overrides,
    observers: observers,
  );

  return container;
}
