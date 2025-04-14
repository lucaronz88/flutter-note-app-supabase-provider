import 'package:freezed_annotation/freezed_annotation.dart';

// include generated files
part 'note.freezed.dart';
part 'note.g.dart';

// for code generation run: 
// dart run build_runner build --delete-conflicting-outputs
@freezed
abstract class Note with _$Note {
  const factory Note({
    required String id,
    required String title,
    required String content,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Note;

  // JSON  serialization support
  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
}