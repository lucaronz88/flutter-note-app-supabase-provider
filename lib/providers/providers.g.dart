// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$supabaseServiceHash() => r'3bfdf1718d00eb5434752c3fccde825ad5230c42';

/// See also [supabaseService].
@ProviderFor(supabaseService)
final supabaseServiceProvider = AutoDisposeProvider<SupabaseService>.internal(
  supabaseService,
  name: r'supabaseServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$supabaseServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SupabaseServiceRef = AutoDisposeProviderRef<SupabaseService>;
String _$authStateHash() => r'43668a52ad478e930eb43fe628b240a42ebeda78';

/// See also [authState].
@ProviderFor(authState)
final authStateProvider = AutoDisposeProvider<bool>.internal(
  authState,
  name: r'authStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthStateRef = AutoDisposeProviderRef<bool>;
String _$currentUserIdHash() => r'0d580969a37241bd7dedbc2b27202af83b05e0c4';

/// See also [currentUserId].
@ProviderFor(currentUserId)
final currentUserIdProvider = AutoDisposeProvider<String?>.internal(
  currentUserId,
  name: r'currentUserIdProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$currentUserIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentUserIdRef = AutoDisposeProviderRef<String?>;
String _$notesStreamHash() => r'37e00e1dadb081e5725b78e2cf6152913ba1d3bd';

/// See also [notesStream].
@ProviderFor(notesStream)
final notesStreamProvider = AutoDisposeStreamProvider<List<Note>>.internal(
  notesStream,
  name: r'notesStreamProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$notesStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NotesStreamRef = AutoDisposeStreamProviderRef<List<Note>>;
String _$noteStreamHash() => r'f8d42a80007da1bd5eebf0e9e96ba719a67d1dbf';

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

/// See also [noteStream].
@ProviderFor(noteStream)
const noteStreamProvider = NoteStreamFamily();

/// See also [noteStream].
class NoteStreamFamily extends Family<AsyncValue<Note?>> {
  /// See also [noteStream].
  const NoteStreamFamily();

  /// See also [noteStream].
  NoteStreamProvider call(String noteId) {
    return NoteStreamProvider(noteId);
  }

  @override
  NoteStreamProvider getProviderOverride(
    covariant NoteStreamProvider provider,
  ) {
    return call(provider.noteId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'noteStreamProvider';
}

/// See also [noteStream].
class NoteStreamProvider extends AutoDisposeStreamProvider<Note?> {
  /// See also [noteStream].
  NoteStreamProvider(String noteId)
    : this._internal(
        (ref) => noteStream(ref as NoteStreamRef, noteId),
        from: noteStreamProvider,
        name: r'noteStreamProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$noteStreamHash,
        dependencies: NoteStreamFamily._dependencies,
        allTransitiveDependencies: NoteStreamFamily._allTransitiveDependencies,
        noteId: noteId,
      );

  NoteStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.noteId,
  }) : super.internal();

  final String noteId;

  @override
  Override overrideWith(Stream<Note?> Function(NoteStreamRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: NoteStreamProvider._internal(
        (ref) => create(ref as NoteStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        noteId: noteId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Note?> createElement() {
    return _NoteStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NoteStreamProvider && other.noteId == noteId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, noteId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin NoteStreamRef on AutoDisposeStreamProviderRef<Note?> {
  /// The parameter `noteId` of this provider.
  String get noteId;
}

class _NoteStreamProviderElement extends AutoDisposeStreamProviderElement<Note?>
    with NoteStreamRef {
  _NoteStreamProviderElement(super.provider);

  @override
  String get noteId => (origin as NoteStreamProvider).noteId;
}

String _$loadingHash() => r'5bf211311517a0c9f39e3fff4a0ebd43bab1bd1e';

/// See also [Loading].
@ProviderFor(Loading)
final loadingProvider = AutoDisposeNotifierProvider<Loading, bool>.internal(
  Loading.new,
  name: r'loadingProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$loadingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Loading = AutoDisposeNotifier<bool>;
String _$errorMessageHash() => r'b416eb0a63370319bbc14ee0d66bebaa659c9a0f';

/// See also [ErrorMessage].
@ProviderFor(ErrorMessage)
final errorMessageProvider =
    AutoDisposeNotifierProvider<ErrorMessage, String?>.internal(
      ErrorMessage.new,
      name: r'errorMessageProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$errorMessageHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ErrorMessage = AutoDisposeNotifier<String?>;
String _$isNewNoteHash() => r'97d01aeef03a945be20ce8bd64f82fcf757ee2cf';

/// See also [IsNewNote].
@ProviderFor(IsNewNote)
final isNewNoteProvider = AutoDisposeNotifierProvider<IsNewNote, bool>.internal(
  IsNewNote.new,
  name: r'isNewNoteProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$isNewNoteHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$IsNewNote = AutoDisposeNotifier<bool>;
String _$selectedNoteIdHash() => r'49d36723c218f4433b19f1db9a96858269b31e49';

/// See also [SelectedNoteId].
@ProviderFor(SelectedNoteId)
final selectedNoteIdProvider =
    AutoDisposeNotifierProvider<SelectedNoteId, String?>.internal(
      SelectedNoteId.new,
      name: r'selectedNoteIdProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$selectedNoteIdHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SelectedNoteId = AutoDisposeNotifier<String?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
