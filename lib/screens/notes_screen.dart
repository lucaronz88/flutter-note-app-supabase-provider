import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app_supabase_provider/components/note_tile.dart';
import 'package:notes_app_supabase_provider/providers/providers.dart';

class NotesScreen extends ConsumerWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen for auth state changes
    ref.listen(authStateProvider, (_, isAuthenticated) {
      if (isAuthenticated) {
        // User is authenticated, navigate to notes screen
        Navigator.pushReplacementNamed(context, '/notes');
      }
    });

    // Watch for notes stream
    final notesAsyncValue = ref.watch(notesStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              // Sign out the user
              await ref.read(supabaseServiceProvider).signOut();
            },
          ),
        ],
      ),
      body: notesAsyncValue.when(
        data: (notes) {
          // Check if notes are empty
          if (notes.isEmpty) {
            return const Center(child: Text('No notes yet. Add your first note!'));
          }

          // Display the list of notes
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return NoteTile(ref: ref, note: note,);
            },
          );
        },
        // Handle loading state
        loading: () => const Center(child: CircularProgressIndicator()),
        // Handle error state
        error: (error, stack) => Center(child: Text('Error: ${error.toString()}')),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add note screen
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
