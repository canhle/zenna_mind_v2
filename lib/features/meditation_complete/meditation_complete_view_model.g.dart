// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meditation_complete_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$meditationCompleteViewModelHash() =>
    r'c744835a5f93c367d0dcb1e54e44a00f8dc5edff';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$MeditationCompleteViewModel
    extends BuildlessAutoDisposeNotifier<MeditationCompleteUiState> {
  late final MeditationCompleteArguments args;

  MeditationCompleteUiState build(MeditationCompleteArguments args);
}

/// See also [MeditationCompleteViewModel].
@ProviderFor(MeditationCompleteViewModel)
const meditationCompleteViewModelProvider = MeditationCompleteViewModelFamily();

/// See also [MeditationCompleteViewModel].
class MeditationCompleteViewModelFamily
    extends Family<MeditationCompleteUiState> {
  /// See also [MeditationCompleteViewModel].
  const MeditationCompleteViewModelFamily();

  /// See also [MeditationCompleteViewModel].
  MeditationCompleteViewModelProvider call(MeditationCompleteArguments args) {
    return MeditationCompleteViewModelProvider(args);
  }

  @override
  MeditationCompleteViewModelProvider getProviderOverride(
    covariant MeditationCompleteViewModelProvider provider,
  ) {
    return call(provider.args);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'meditationCompleteViewModelProvider';
}

/// See also [MeditationCompleteViewModel].
class MeditationCompleteViewModelProvider
    extends
        AutoDisposeNotifierProviderImpl<
          MeditationCompleteViewModel,
          MeditationCompleteUiState
        > {
  /// See also [MeditationCompleteViewModel].
  MeditationCompleteViewModelProvider(MeditationCompleteArguments args)
    : this._internal(
        () => MeditationCompleteViewModel()..args = args,
        from: meditationCompleteViewModelProvider,
        name: r'meditationCompleteViewModelProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$meditationCompleteViewModelHash,
        dependencies: MeditationCompleteViewModelFamily._dependencies,
        allTransitiveDependencies:
            MeditationCompleteViewModelFamily._allTransitiveDependencies,
        args: args,
      );

  MeditationCompleteViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.args,
  }) : super.internal();

  final MeditationCompleteArguments args;

  @override
  MeditationCompleteUiState runNotifierBuild(
    covariant MeditationCompleteViewModel notifier,
  ) {
    return notifier.build(args);
  }

  @override
  Override overrideWith(MeditationCompleteViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: MeditationCompleteViewModelProvider._internal(
        () => create()..args = args,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        args: args,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<
    MeditationCompleteViewModel,
    MeditationCompleteUiState
  >
  createElement() {
    return _MeditationCompleteViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MeditationCompleteViewModelProvider && other.args == args;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, args.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MeditationCompleteViewModelRef
    on AutoDisposeNotifierProviderRef<MeditationCompleteUiState> {
  /// The parameter `args` of this provider.
  MeditationCompleteArguments get args;
}

class _MeditationCompleteViewModelProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          MeditationCompleteViewModel,
          MeditationCompleteUiState
        >
    with MeditationCompleteViewModelRef {
  _MeditationCompleteViewModelProviderElement(super.provider);

  @override
  MeditationCompleteArguments get args =>
      (origin as MeditationCompleteViewModelProvider).args;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
