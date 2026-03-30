import 'package:riverpod/riverpod.dart';

List<T> collectStates<T>(
  ProviderContainer container,
  ProviderListenable<T> provider,
) {
  final states = <T>[];

  container.listen<T>(
    provider,
    (_, next) => states.add(next),
    fireImmediately: true,
  );

  return states;
}
