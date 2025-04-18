import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app_supabase_provider/models/note.dart';
import 'package:notes_app_supabase_provider/providers/providers.dart';

class NoteTile extends StatelessWidget {
  // final BuildContext context;
  final WidgetRef ref;
  final Note note;

  const NoteTile({
    super.key,
    // required this.context,
    required this.ref,
    required this.note,
  });

  // When delete note button pressed
  Future<void> _deleteNote(
    BuildContext context,
    WidgetRef ref,
    String noteId,
  ) async {
    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Note'),
          content: const Text('Are you sure you want to delete this note?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    // If user confirmed, delete the note
    if (confirmed == true) {
      // Show loading indicator
      ref.read(loadingProvider.notifier).setLoading(true);

      // Delete the note
      try {
        await ref.read(supabaseServiceProvider).deleteNote(noteId);
        // Show success message
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Note deleted successfully')),
          );
        }
      } catch (e) {
        // Show error message
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to delete note: ${e.toString()}')),
          );
        }
      } finally {
        // Hide loading indicator
        ref.read(loadingProvider.notifier).setLoading(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        note.title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        note.content,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => _deleteNote(context, ref, note.id),
      ),
      onTap: () {
        // Navigate to note details screen
      },
    );
  }
}
