import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:notes_app_supabase_provider/models/note.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  // initialize method
  Future<void> initialize() async {
    // load env file
    await dotenv.load(fileName: ".env");

    // initialize supabase
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
    );
  }

  /*

  AUTH METHODS

  */

  // Sign up
  Future<void> signUp(String email, String password) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
    );

    if (response.user == null) {
      throw Exception("Failed to sign up");
    }
  }

  // Sign in
  Future<void> signIn(String email, String password) async {
    final response = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.user == null) {
      throw Exception("Failed to sign in");
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  // get current user id
  String? get currentUserId => _client.auth.currentUser?.id;

  // login status
  bool get isAuthenticated => _client.auth.currentUser != null;

  /*

  NOTE METHODS

  */

  // Get notes streams
  Stream<List<Note>> getNotesStream() {
    return _client
        .from('notes')
        .stream(primaryKey: ['id'])
        .order('updated_at')
        .map((response) {
          // Convert the response to a list of notes
          return response.map((note) {
            // Convert the note json to a Note object
            return Note.fromJson(note);
          }).toList();
        });
  }

  // Get single note stream
  Stream<Note?> getNoteStream(String noteId) {
    return _client
        .from('notes')
        .stream(primaryKey: ['id'])
        .eq('id', noteId)
        .map((response) {
          // Convert the response to a list of notes
          return response.isNotEmpty ? Note.fromJson(response.first) : null;
        });
  }

  // Create note
  Future<void> createNote(String title, String content) async {
    await _client.from('notes').insert({
      'title': title,
      'content': content,
      'user_id': currentUserId,
    });
  }

  // Update note
  Future<void> updateNote(String noteId, String title, String content) async {
    await _client.from('notes').update({
      'title': title,
      'content': content,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', noteId);
  }

  // Delete note
  Future<void> deleteNote(String noteId) async {
    await _client.from('notes').delete().eq('id', noteId);
  }
}
