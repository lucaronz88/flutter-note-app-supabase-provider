import 'package:flutter_dotenv/flutter_dotenv.dart';
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

  // WIP
}
