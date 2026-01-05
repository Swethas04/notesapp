import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/note.dart';
import '../service/notes_service.dart';

part 'notes_provider.g.dart';

@riverpod
NotesService notesService(NotesServiceRef ref) {
  return NotesService(Supabase.instance.client);
}

@riverpod
class NotesController extends _$NotesController {
  @override
  AsyncValue<List<Note>> build() {
    loadNotes();
    return const AsyncValue.loading();
  }

  Future<void> loadNotes() async {
    try {
      final userId = Supabase.instance.client.auth.currentUser!.id;

      final notes = await ref.read(notesServiceProvider).fetchNotes(userId);

      state = AsyncValue.data(notes);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addNote(String title, String content) async {
    final userId = Supabase.instance.client.auth.currentUser!.id;

    await ref
        .read(notesServiceProvider)
        .addNote(userId: userId, title: title, content: content);

    await loadNotes();
  }

  Future<void> updateNote(String id, String title, String content) async {
    await ref
        .read(notesServiceProvider)
        .updateNote(id: id, title: title, content: content);

    await loadNotes();
  }

  Future<void> deleteNote(String id) async {
    await ref.read(notesServiceProvider).deleteNote(id);
    await loadNotes();
  }
}
