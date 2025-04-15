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

// Auth state providers
@riverpod
bool isAuthenticated(Ref ref) {
  return ref.watch(supabaseServiceProvider).isAuthenticated;
}

// Current user id provider
@riverpod
String? currentUserId(Ref ref) {
  return ref.watch(supabaseServiceProvider).currentUserId;
}