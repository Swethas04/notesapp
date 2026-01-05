// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$notesServiceHash() => r'0614fe701818784d6499b6e5c3afd184b5dea92f';

/// See also [notesService].
@ProviderFor(notesService)
final notesServiceProvider = AutoDisposeProvider<NotesService>.internal(
  notesService,
  name: r'notesServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$notesServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NotesServiceRef = AutoDisposeProviderRef<NotesService>;
String _$notesControllerHash() => r'c0b0afca7881902b135ffdfd56b2785400874c90';

/// See also [NotesController].
@ProviderFor(NotesController)
final notesControllerProvider = AutoDisposeNotifierProvider<
  NotesController,
  AsyncValue<List<Note>>
>.internal(
  NotesController.new,
  name: r'notesControllerProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$notesControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NotesController = AutoDisposeNotifier<AsyncValue<List<Note>>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
