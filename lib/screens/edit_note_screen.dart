import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app_supabase_provider/providers/providers.dart';

class EditNoteScreen extends ConsumerStatefulWidget {
  const EditNoteScreen({super.key});

  @override
  ConsumerState<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends ConsumerState<EditNoteScreen> {
  // Form key for the note form
  final _formKey = GlobalKey<FormState>();

  // Text editing controllers for title and content
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  // Check if the screen is initialized
  bool _initialized = false;

  // dispose method to clean up controllers
  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listen for state changes
    final isLoading = ref.watch(loadingProvider);
    final errorMessage = ref.watch(errorMessageProvider);
    final isNewNote = ref.watch(isNewNoteProvider);
    final noteId = ref.watch(selectedNoteIdProvider);

    // If not a new note, fetch the note data
    if (!isNewNote && noteId != null && !_initialized) {
      // Fetch the note data
      final noteAsync = ref.watch(noteStreamProvider(noteId));

      // Initialize the controllers with the note data
      return Scaffold(
        appBar: AppBar(title: const Text("Loading Note...")),
        body: noteAsync.when(
          data: (note) {
            // Check if the note is empty
            if (note == null) {
              return const Center(child: Text("Note not found"));
            }

            // Initialize the controllers with the note data
            _titleController.text = note.title;
            _contentController.text = note.content;
            _initialized = true;

            // Show the note form
            return _buildNoteForm(isNewNote, noteId, isLoading, errorMessage);
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error:
              (error, stackTrace) =>
                  Center(child: Text("Error: ${error.toString()}")),
        ),
      );
    }

    // If it's a new note or the note data is already fetched, show the note form
    return Scaffold(
      appBar: AppBar(title: Text(isNewNote ? "New Note" : "Edit Note")),
      body: _buildNoteForm(isNewNote, noteId, isLoading, errorMessage),
      floatingActionButton: FloatingActionButton(
        // Save button
        onPressed: isLoading ? null : _saveNote,
        child: const Icon(Icons.save),
      ),
    );
  }

  // Build the note form
  Widget _buildNoteForm(
    bool isNewNote,
    String? noteId,
    bool isLoading,
    String? errorMessage,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Show error message if any
            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ),

            // Title text fields
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a title";
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // Content text fields
            Expanded(
              child: TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: "Content",
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: null,
                textAlignVertical: TextAlignVertical.top,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter some content";
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Save note method
  Future<void> _saveNote() async {
    // Validate the form
    if (_formKey.currentState!.validate()) {
      // Show loading indicator
      ref.read(loadingProvider.notifier).setLoading(true);

      // Clear any previous error message
      ref.read(errorMessageProvider.notifier).setError(null);

      try {
        final isNewNote = ref.read(isNewNoteProvider);
        final noteId = ref.read(selectedNoteIdProvider);

        if (isNewNote) {
          // Create a new note
          await ref
              .read(supabaseServiceProvider)
              .createNote(
                _titleController.text.trim(),
                _contentController.text.trim(),
              );
        } else if (noteId != null) {
          // Update the existing note
          await ref
              .read(supabaseServiceProvider)
              .updateNote(
                noteId,
                _titleController.text,
                _contentController.text,
              );
        }

        if (mounted) {
          Navigator.of(context).pop();
        }
      } catch (e) {
        // Show error message
        ref
            .read(errorMessageProvider.notifier)
            .setError("Failed to save note: ${e.toString()}");
      } finally {
        // Hide loading indicator
        ref.read(loadingProvider.notifier).setLoading(false);
      }
    }
  }
}
