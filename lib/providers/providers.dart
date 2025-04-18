import 'package:notes_app_supabase_provider/models/note.dart';
import 'package:notes_app_supabase_provider/services/supabase_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

// Services provider
@riverpod
SupabaseService supabaseService(Ref ref) {
  final service = SupabaseService();
  service.initialize();
  return service;
}

/* 

AUTH PROVIDERS

*/

// Auth state provider
@riverpod
bool authState(Ref ref) {
  return ref.watch(supabaseServiceProvider).isAuthenticated;
}

// Current user id provider
@riverpod
String? currentUserId(Ref ref) {
  return ref.watch(supabaseServiceProvider).currentUserId;
}

/*

NOTES PROVIDERS

*/

// Notes stream provider
@riverpod
Stream<List<Note>> notesStream(Ref ref) {
  return ref.watch(supabaseServiceProvider).getNotesStream();
}

// Single note stream provider
@riverpod
Stream<Note?> noteStream(Ref ref, String noteId) {
  return ref.watch(supabaseServiceProvider).getNoteStream(noteId);
}

/* 

UI STATE PROVIDERS

*/

// Loading state provider
@riverpod
class Loading extends _$Loading {
  @override
  bool build() => false;

  void setLoading(bool value) => state = value;
}

// Error state provider
@riverpod
class ErrorState extends _$ErrorState {
  @override
  String? build() => null;

  void setError(String? message) => state = message;
}

// New note state provider
@riverpod
class IsNewNote extends _$IsNewNote {
  @override
  bool build() => false;

  void setIsNewNote(bool value) => state = value;
}

// Selected note id provider
@riverpod
class SelectedNoteId extends _$SelectedNoteId {
  @override
  String? build() => null;

  void setSelectedNoteId(String? id) => state = id;
}